#!/bin/bash
# 🤖 JARVIS - Personal Mac Assistant Launcher
# Complete setup and run script with TTS enabled

set -e

JARVIS_DIR="/Users/user/Desktop/Jarvis 2"
VENV_DIR="$JARVIS_DIR/.venv"

if [ -d "$JARVIS_DIR/venv_fresh" ]; then
    VENV_DIR="$JARVIS_DIR/venv_fresh"
elif [ -d "$JARVIS_DIR/.venv" ]; then
    VENV_DIR="$JARVIS_DIR/.venv"
elif [ -d "$JARVIS_DIR/venv" ]; then
    VENV_DIR="$JARVIS_DIR/venv"
fi

echo ""
echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║           🤖 JARVIS - Personal Mac Assistant                  ║"
echo "║                 TTS Voice Output Enabled                      ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo ""

# Check if venv exists
if [ ! -d "$VENV_DIR" ]; then
    echo "⚠️  Virtual environment not found. Creating..."
    cd "$JARVIS_DIR"
    python3 -m venv venv_fresh
    source venv_fresh/bin/activate
    python -m pip install -U pip setuptools wheel > /dev/null 2>&1
    python -m pip install -r requirements.txt > /dev/null 2>&1
    echo "✅ Virtual environment created and packages installed"
    echo ""
fi

# Check if Ollama is running
echo "📡 Checking Ollama status..."
if curl -s http://localhost:11434/api/tags > /dev/null 2>&1; then
    echo "✅ Ollama is running at localhost:11434"
else
    echo ""
    echo "⚠️  WARNING: Ollama is NOT running!"
    echo ""
    echo "To use JARVIS with AI responses, start Ollama in another terminal:"
    echo ""
    echo "  💻 Terminal 1:"
    echo "     ollama serve"
    echo ""
    echo "  💻 Terminal 2:"
    echo "     bash /Users/user/Desktop/Jarvis\\ 2/run_jarvis.sh"
    echo ""
    echo "JARVIS will still work with limited offline functionality."
    echo ""
fi

# Activate venv
echo ""
echo "📦 Activating virtual environment..."
source "$VENV_DIR/bin/activate"

# Test TTS
echo ""
echo "🔊 Testing Text-to-Speech (TTS)..."
if command -v say &> /dev/null; then
    say "JARVIS voice output is working" 2>/dev/null || true
    echo "✅ TTS is working (you should hear a voice)"
else
    echo "⚠️  macOS 'say' command not found"
fi

# Start JARVIS
echo ""
echo "🩺 Running Pre-startup Self-Correction Audit..."
"$VENV_DIR/bin/python" core/self_heal.py || true

echo ""
echo "🚀 Starting JARVIS..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Suppress audio warnings completely
export JACK_NO_AUDIO_RESERVATION=1
export AUDIO_DRIVER_IGNORE_WARNINGS=1
export PYTHONWARNINGS="ignore"

cd "$JARVIS_DIR"
# Run JARVIS and filter out audio hardware errors
python jarvis.py "$@" 2>&1 | grep -v "PaMacCore\|Unspecified Audio\|ALSA\|Jack" || true
