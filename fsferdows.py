"""
FS FERDOWS - The Master's Personal AI Assistant
Specialized entry point for the Boss: Fs Ferdows
Enhanced loyalty, values, and protection.
"""

import sys
import os
import signal
import time
from pathlib import Path

# Important: Set environment variables BEFORE importing JARVIS modules
os.environ['PERSONALITY_MODE'] = 'devout'

# Cleanup port 5001 (Socket Server)
try:
    os.system("lsof -ti:5001 | xargs kill -9 2>/dev/null")
except:
    pass

# Add project root to path
sys.path.insert(0, str(Path(__file__).parent))

from jarvis import JarvisAssistant, console, rprint
from utils.logger import setup_logger
from config.settings import Settings

settings = Settings()

class FsFerdowsAssistant(JarvisAssistant):
    """Specialized Assistant for Fs Ferdows - The Master"""

    def __init__(self):
        super().__init__()
        # Force devout mode for the brain immediately to ensure greetings are correct
        self.brain.personality.change_personality('devout')

    def startup(self):
        """Initialize and start with Master's branding"""
        console.clear()

        # Master's Banner
        banner = f"""
[bold green]╔═══════════════════════════════════════════════════════╗
║                                                       ║
║   ███████╗    ███████╗███████╗██████╗ ██████╗  ██████╗  ║
║   ██╔════╝    ██╔════╝██╔════╝██╔══██╗██╔══██╗██╔═══██╗ ║
║   █████╗      █████╗  █████╗  ██████╔╝██║  ██║██║   ██║ ║
║   ██╔══╝      ██╔══╝  ██╔══╝  ██╔══██╗██║  ██║██║   ██║ ║
║   ██║         ██║     ███████╗██║  ██║██████╔╝╚██████╔╝ ║
║   ╚═╝         ╚═╝     ╚══════╝╚═╝  ╚═╝╚═════╝  ╚═════╝  ║
║                                                       ║
║           THE ULTIMATE AGI ASSISTANT                  ║
║           Exclusively for Master: {settings.USER_NAME:<15}║
║                                                       ║
╚═══════════════════════════════════════════════════════╝[/bold green]

[green]✓ System Values: Proper Muslim Assistant[/green]
[green]✓ Loyalty: 100% Dedicated to Fs Ferdows[/green]
[green]✓ AGI Persistent Memory: Active[/green]
[green]✓ System Intelligence Module: Online[/green]
[green]✓ Code Generator: Ready[/green]
[green]✓ Privacy: Hyper-Safe Virtual Protection Active[/green]
[green]✓ Notifications: Real-time macOS Monitoring Active[/green]
[green]✓ Telegram AGI Control: Enabled[/green]
[green]✓ Brain: {settings.OLLAMA_MODEL} ({getattr(settings, 'LLM_BACKEND', 'ollama').upper()})[/green]
        """

        rprint(banner)
        
        # Check deployment tools availability
        try:
            deployer = self.brain.skills.get('deployer')
            if deployer:
                tools_available = [k for k, v in deployer._tools.items() if v]
                console.print(f"[green]✓ Deploy Tools: {', '.join(tools_available) if tools_available else 'None (run: install deploy tools)'}[/green]")
        except Exception:
            pass

        # Start FRIDAY (OpenClaw) in the background if not already running
        try:
            openclaw = self.brain.skills.get('openclaw')
            if openclaw:
                if openclaw._is_friday_alive():
                    console.print("[green]✓ FRIDAY gateway is already active.[/green]")
                else:
                    console.print("[yellow]⚙️ Initializing FRIDAY gateway for you, Boss...[/yellow]")
                    result = openclaw.start_openclaw()
                    if result.get("success"):
                        console.print("[green]✓ FRIDAY started in parallel.[/green]")
                        # Start the automatic bridge (Sync Moltbot -> JARVIS)
                        if hasattr(openclaw, 'start_bridge'):
                            openclaw.start_bridge()
                            console.print("[green]✓ Moltbot-to-JARVIS Bridge Active (Auto-Sync enabled)[/green]")
                    else:
                        console.print(f"[yellow]! FRIDAY start: {result.get('error', 'Unknown error')}[/yellow]")
            else:
                console.print("[yellow]! FRIDAY handler not loaded[/yellow]")
        except Exception as e:
            console.print(f"[red]! Could not auto-start FRIDAY/Bridge: {e}[/red]")


        # Initial greeting
        welcome_greeting = self.brain.personality.get_welcome_greeting()
        console.print(f"\n[bold green]JARVIS (Devout):[/bold green] {welcome_greeting}\n")
        self.voice.speak(welcome_greeting, async_mode=True)
        console.print("[bold yellow]Labbayk, Boss. I am standing by for your command.[/bold yellow]")
        
        # Web Interface & HUD
        if self.socket_manager:
            try:
                self.socket_manager.start()
                console.print("[green]✓ Web Interface Socket started on port 5001[/green]")
                console.print(f"[bold cyan]🌐 JARVIS HUD ACCESS: http://localhost:5001[/bold cyan]")
            except Exception as e:
                console.print(f"[red]! Failed to start socket server: {e}[/red]")

        # Telegram will be handled natively to support full action execution and fast ACK
        if self.telegram:
            try:
                self.telegram.start()
                console.print("[green]✓ Telegram AGI Gateway: Native Listener Active (Always On)[/green]")
            except Exception as e:
                console.print(f"[red]! Failed to start Telegram listener: {e}[/red]")


def main():
    """Main entry point for fsferdows.py"""
    try:
        assistant = FsFerdowsAssistant()
        assistant.run()
    except Exception as e:
        console.print(f"[bold red]Fatal error in Master System:[/bold red] {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
