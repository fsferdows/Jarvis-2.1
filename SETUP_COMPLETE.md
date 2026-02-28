# JARVIS Full Setup Guide

## What's New

JARVIS is now a **full-featured, Iron-Man-style personal assistant** with:

✅ **Safety & Confirmations** - Dangerous actions require user approval  
✅ **Messaging** - Send messages via Telegram, WhatsApp, Email  
✅ **Media** - YouTube, Spotify, Apple Music integration  
✅ **Behavior Learning** - JARVIS learns your preferences over time  
✅ **Audit Trail** - Every action is logged for transparency  
✅ **Multi-modal** - Voice input, text input, natural responses  

## Installation

### 1. Install System Dependencies (macOS)

```bash
brew install portaudio ffmpeg ollama
```

### 2. Install Python Dependencies

```bash
python3 -m pip install -r requirements.txt
```

### 3. Setup Ollama AI Model

```bash
# Start Ollama in a separate terminal
ollama serve

# In another terminal, pull the model (one-time)
ollama pull llama3
```

### 4. Configure Environment Variables

```bash
# Copy template to .env
cp .env.example .env

# Edit .env with your credentials
nano .env
```

**Important env variables to set:**

- `USER_NAME` - Your name for personalization
- `OLLAMA_HOST` - Where Ollama runs (default: http://localhost:11434)
- `OLLAMA_MODEL` - Model to use (default: llama3)
- `TELEGRAM_BOT_TOKEN` - For Telegram messaging (optional)
- `TELEGRAM_CHAT_ID` - Your Telegram chat ID (optional)
- `EMAIL_ADDRESS` / `EMAIL_PASSWORD` - Gmail SMTP credentials (optional)

## Running JARVIS

### Start JARVIS

```bash
python3 jarvis.py
```

### Voice Commands Examples

**System Control:**
- "Jarvis, open Safari"
- "Open Terminal and list files"

**Messaging:**
- "Send a message to John on Telegram: Hello!"
- "Send an email to mom@example.com subject Happy Birthday body Enjoy your day"

**Media:**
- "Play Never Gonna Give You Up on YouTube"
- "Play some lo-fi music"
- "Next song"

**Information:**
- "Search for AI news"
- "What's on my calendar?"

**Coding:**
- "Write a Python function to sort a list"
- "Execute this code: print('hello')"

**Files:**
- "What's in my Downloads folder?"
- "Read my notes.txt file"
- "Delete the temp file" _(requires confirmation)_

**System Commands:**
- "Execute ls -la" _(requires confirmation)_
- "Take a screenshot"

## Safety & Confirmations

JARVIS asks for confirmation before:
- Executing shell commands
- Deleting files
- Sending emails/messages
- Running system operations

Just say "yes" or "no" when prompted!

## Behavior Learning

JARVIS learns your preferences over time by:
- Tracking which apps you use most
- Remembering your preferred messaging platform
- Learning your favorite music sources
- Recording your interaction patterns
- Suggesting automations for repeated tasks

All preferences are stored in `data/preferences.json` (local, never sent anywhere).

## Troubleshooting

### "Ollama connection failed"
- Make sure `ollama serve` is running in a separate terminal
- Check `OLLAMA_HOST` in .env is correct (default: http://localhost:11434)

### "Speech recognition failed, falling back to text input"
- Microphone may not be available or configured
- You can still use text input (just type your command when prompted)
- Check microphone permissions in System Settings → Sound

### "No response from JARVIS"
- Check logs: `cat logs/jarvis_*.log`
- Verify Ollama model is installed: `ollama list`
- Try increasing timeouts in .env: `OLLAMA_TIMEOUT=180`

## Keyboard Shortcuts

- `Ctrl+C` - Exit JARVIS  
- `quit` or `exit` - Graceful shutdown  

## Features Breakdown

### A. Safety & Confirmations
- JARVIS filters all dangerous actions
- User must approve: delete, execute, send messages
- All actions logged to audit trail (`brain.get_audit_trail()`)

### B. Telegram Integration
- Send Telegram messages directly
- Receive commands via Telegram (future)
- Requires: `TELEGRAM_BOT_TOKEN` and `TELEGRAM_CHAT_ID`

### C. YouTube & Media
- Opens YouTube search in your browser
- Can control Spotify/Apple Music
- Integrates with system media player

### D. Preference Learning
- `data/preferences.json` - Stores all learned preferences
- `data/interactions.json` - Last 500 interactions
- Simple scoring system to recommend automations

### E. Complete Action Types

**Safe (no confirmation):**
- system_open_app
- browser_search, browser_navigate
- music_play, music_control
- youtube_play
- code_explain
- file_read

**Require Confirmation:**
- system_execute (shell commands)
- file_delete
- email_send
- telegram_send
- message_send_whatsapp

## Next Steps

1. **Copy .env.example to .env** and fill in your details
2. **Make sure Ollama is running**: `ollama serve`
3. **Start JARVIS**: `python3 jarvis.py`
4. **Try a simple command**: "Jarvis, hello"
5. **Try a complex command**: "Open Safari and search for Python tutorials"

## Advanced

### Custom Prompt Editing
Edit `core/brain.py` → `_create_prompt()` to customize JARVIS's personality

### Extending Skills
Add new skills in `skills/` directory following the pattern in `skills/telegram_handler.py`

### Adding New Integrations
1. Create new skill file in `skills/`
2. Add to `core/brain.py` skill imports
3. Update system prompt with new capabilities
4. Add environment variables to `.env.example`

## Support

Check logs for debugging:
```bash
tail -f logs/jarvis_*.log
```

Enable debug logging:
```bash
export DEBUG=True
export LOG_LEVEL=DEBUG
python3 jarvis.py
```

---

**Built with ❤️ - JARVIS: Your Personal AI Assistant**
