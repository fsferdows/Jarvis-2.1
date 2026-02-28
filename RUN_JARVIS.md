# 🤖 JARVIS - Personal Mac Assistant

## Complete Setup & Running Instructions

---

## ✅ What JARVIS Can Do

- 🎤 Listen to your voice commands (or text input)
- 🧠 Process commands with AI (Ollama)
- 🔊 **Speak responses back to you** (TTS enabled)
- 💻 Control your Mac (open apps, files, etc.)
- 🌐 Search the web
- 📧 Send emails
- 🎵 Play music
- 📱 Telegram messages
- And much more!

---

## 🚀 Quick Start (3 Steps)

### **Step 1: Setup Ollama** (One-time setup)

If you don't have Ollama installed:

```bash
# Install Ollama for Mac
brew install ollama

# Download the llama3 model (one time, ~4GB)
ollama pull llama3:latest
```

### **Step 2: Start Ollama in Background**

```bash
# Terminal 1: Start Ollama service
ollama serve
```

It should show:

```
Ollama is running on http://localhost:11434
```

### **Step 3: Run JARVIS**

```bash
# Terminal 2: Open a new terminal
cd "/Users/user/Desktop/Jarvis 2"

# Activate virtual environment
source venv_fresh/bin/activate

# Run JARVIS
python jarvis.py
```

---

## 📝 How to Use JARVIS

Once JARVIS starts, you'll see:

```
╭─────────────────────────────────────────────────────────────────╮
│                    🤖 JARVIS - AI Assistant                     │
│              Personal AI for Fs Ferdows on macOS                │
│                                                                 │
│ ✓ Voice input enabled (text-only mode)                          │
│ ✓ TTS/Voice output ENABLED - I will speak responses             │
│ ✓ AI Brain connected to Ollama                                  │
│ ✓ Personality Mode: witty                                       │
╰─────────────────────────────────────────────────────────────────╯

→ hello jarvis
```

### **Example Commands:**

```
→ hello
JARVIS: Hello! I'm JARVIS, your AI assistant. How can I help you today?
[JARVIS speaks this back to you]

→ what time is it
JARVIS: It is 3:45 PM.
[JARVIS speaks this back to you]

→ open safari
JARVIS: Opening Safari.
[Opens Safari on your Mac, then speaks]

→ search weather in karachi
JARVIS: Searching the web for: weather in karachi.
[Opens search in browser]

→ exit
[Closes JARVIS]
```

---

## 🔊 Voice Settings (Speech Output)

Your TTS is configured as:

```bash
# In .env:
SPEECH_OUTPUT_ENABLED=True      # ✅ Voice output is ON
AUTO_SPEAK=True                  # ✅ Auto-speak all responses
VOICE_RATE=175                   # Speed (words per minute)
VOICE_GENDER=male                # Voice type
TTS_ENGINE=system                # Uses macOS 'say' command
```

### **Test Voice Output:**

```bash
# Make sure you can hear your Mac speakers
say "Hello, JARVIS voice is working"
```

If you hear the voice, TTS is working! ✅

---

## 🎯 Configuration Options

Edit `.env` file to customize:

```bash
# Personal Settings
USER_NAME=Fs Ferdows              # Your name (JARVIS will use this)
USER_EMAIL=your.email@example.com # Your email

# AI Settings
OLLAMA_MODEL=llama3:latest        # Which AI model to use
OLLAMA_TIMEOUT=120                # Max seconds to wait for response

# Input Settings
TEXT_ONLY_MODE=True               # Use text input (not microphone)
WAKE_WORD_REQUIRED=False          # Don't require "Hey Jarvis"

# Output Settings
SPEECH_OUTPUT_ENABLED=True        # ✅ Speak responses
VOICE_RATE=175                    # ✅ Speech speed
VOICE_GENDER=male                 # ✅ Voice type
AUTO_SPEAK=True                   # ✅ Always speak

# Personality
PERSONALITY_MODE=witty            # Options: professional, witty, friendly
EMOTION_LEVEL=0.8                 # How emotional (0-1)
```

---

## 🛠️ Troubleshooting

### **Problem: JARVIS doesn't speak back**

**Check 1: Is TTS enabled?**

```bash
grep SPEECH_OUTPUT_ENABLED .env
# Should show: SPEECH_OUTPUT_ENABLED=True
```

**Check 2: Can your Mac speak?**

```bash
say "Test"
# You should hear a voice
```

**Check 3: Restart JARVIS**

```bash
# Kill the current process (Ctrl+C)
# Then restart:
python jarvis.py
```

---

### **Problem: "Ollama not responding"**

**Check 1: Is Ollama running?**

```bash
curl http://localhost:11434/api/tags
# Should show your models
```

**Check 2: Start Ollama**

```bash
ollama serve
# In another terminal, verify:
ollama ls
# Should show: llama3:latest
```

---

### **Problem: "Command not working"**

**Check 1: Try simple commands first**

```
→ hello
→ what time is it
→ tell me a joke
```

**Check 2: Check Ollama status**

```bash
# Terminal with Ollama should show:
# "generated response"
# "total duration: 5.2s"
```

---

## 🚀 Full Terminal Commands (Copy-Paste)

### **First Time Setup:**

```bash
# Install Ollama
brew install ollama

# Download AI model
ollama pull llama3:latest

# Verify installation
ollama ls
```

### **Every Time You Use JARVIS:**

**Terminal 1 - Start Ollama:**

```bash
ollama serve
```

**Terminal 2 - Start JARVIS:**

```bash
cd "/Users/user/Desktop/Jarvis 2"
source venv_fresh/bin/activate
python jarvis.py
```

---

## 📊 What's Enabled for You

| Feature                | Status     | How it Works                              |
| ---------------------- | ---------- | ----------------------------------------- |
| **Text Input**         | ✅ Enabled | Type commands instead of speaking         |
| **TTS (Voice Output)** | ✅ Enabled | JARVIS speaks responses using macOS 'say' |
| **AI Brain**           | ✅ Ollama  | Uses llama3:latest model                  |
| **Personality**        | ✅ Witty   | JARVIS has personality and humor          |
| **Learning**           | ✅ Enabled | JARVIS remembers your preferences         |
| **Offline Fallback**   | ✅ Enabled | Works even if Ollama fails                |

---

## 🎤 Voice Configuration Details

**macOS Voice (TTS):**

- Using: `say` command (built-in macOS)
- Voice: Daniel (professional male)
- Speed: 175 words per minute
- Volume: 90%

**To change voice:**

```bash
# List available voices:
say -v ?

# Examples:
say -v Victoria "Hello"    # Female
say -v Daniel "Hello"      # Male (current)
say -v Alex "Hello"        # Upbeat
```

To change permanently, edit `.env`:

```bash
# Add this line or modify:
VOICE_PREFERENCE=Victoria  # (then add to voice.py)
```

---

## 🔐 Security Notes

✅ **Your Setup:**

- Ollama runs locally (no data sent to cloud)
- Commands processed on your Mac
- No internet required (except for web search)

---

## 📚 Next Steps

Once JARVIS is running smoothly:

1. **Customize Personality** - Edit `PERSONALITY_MODE` in `.env`
2. **Add Skills** - Configure email, Telegram, Spotify in `.env`
3. **Learn More** - Check `core/brain.py` for what JARVIS can do
4. **Create Automations** - Set up recurring tasks with `core/scheduler.py`

---

## ✨ Summary

You now have a **fully functional Mac personal assistant** that:

✅ Listens to your commands  
✅ **Speaks responses back to you** (TTS enabled)  
✅ Controls your Mac  
✅ Uses local AI (Ollama)  
✅ Runs completely offline

**Ready to run:**

```bash
ollama serve  # Terminal 1
python jarvis.py  # Terminal 2
```

Enjoy your personal JARVIS! 🤖

---

**Last Updated:** February 7, 2026  
**Status:** ✅ Ready to Use
