# 🚀 Getting Started with JARVIS

**Welcome, Fs Ferdows!** This guide will help you set up and start using your personal JARVIS AI assistant in under 10 minutes.

---

## 📋 What You'll Need

Before starting, make sure you have:

- ✅ **MacBook Air M1** (running macOS 11.0 or later)
- ✅ **Ollama installed** (you mentioned you have this)
- ✅ **Microphone** (built-in or external)
- ✅ **Internet connection** (for initial setup)
- ✅ **~5GB free disk space** (for AI models)

---

## 🎯 Step-by-Step Installation

### Step 1: Verify Ollama is Installed

```bash
# Check Ollama version
ollama --version

# If not installed, download from: https://ollama.ai
# Or install via Homebrew:
brew install ollama
```

### Step 2: Run the Automated Setup

JARVIS includes a setup script that does everything for you:

```bash
cd /Users/user/Desktop/Jarvis
./setup.sh
```

This will:
- ✓ Install system dependencies (portaudio, ffmpeg)
- ✓ Create Python virtual environment
- ✓ Install all Python packages (~100 dependencies)
- ✓ Pull the llama3 AI model (~4GB)
- ✓ Create your .env configuration file

**⏱️ Expected time**: 5-10 minutes (depends on internet speed)

### Step 3: Configure Your Settings (Optional)

The basic configuration works out of the box, but you can customize:

```bash
# Edit the .env file
nano .env
```

**Recommended settings for beginners:**
```bash
USER_NAME="Fs Ferdows"
OLLAMA_MODEL="llama3"
WAKE_WORD="jarvis"
```

**Optional settings** (add these for full functionality):

**For Email:**
```bash
EMAIL_ADDRESS="your.email@gmail.com"
EMAIL_PASSWORD="your-app-specific-password"  # See note below
```

> **Gmail Users**: Use an App Password, not your regular password:
> 1. Go to Google Account → Security → 2-Step Verification
> 2. App passwords → Generate password for "Mail"
> 3. Use this password in .env

**For Music (Spotify):**
```bash
SPOTIFY_CLIENT_ID="your-client-id"
SPOTIFY_CLIENT_SECRET="your-client-secret"
```

> Get these from: https://developer.spotify.com/dashboard

### Step 4: Test Your Installation

Before running JARVIS, let's verify everything is working:

```bash
# Make sure you're in the Jarvis directory
cd /Users/user/Desktop/Jarvis

# Run the test suite
python3 test_jarvis.py
```

You should see:
- ✅ All tests passed!
- ✅ Ollama is running
- ✅ Configuration loaded

If you see errors, check the **TROUBLESHOOTING.md** file.

---

## 🎤 Starting JARVIS

### Terminal 1: Start Ollama (Required)

```bash
# Start the Ollama service
ollama serve
```

**Keep this terminal running.** You should see:
```
Listening on 127.0.0.1:11434 (version ...)
```

### Terminal 2: Launch JARVIS

Open a new terminal window:

```bash
cd /Users/user/Desktop/Jarvis

# Activate virtual environment
source venv/bin/activate

# Run JARVIS
python jarvis.py
```

You'll see a beautiful ASCII art banner and JARVIS will greet you! 🎉

---

## 🎯 Your First Commands

Once JARVIS is running, try these commands:

### 1. Test Basic Response
**Say:** "Jarvis, hello!"  
**Expected:** JARVIS responds with a greeting

### 2. System Control
**Say:** "Jarvis, what time is it?"  
**Expected:** JARVIS tells you the current time

### 3. Open an Application
**Say:** "Jarvis, open Safari"  
**Expected:** Safari launches

### 4. Web Search
**Say:** "Jarvis, search for Python tutorials"  
**Expected:** Browser opens with Google search results

### 5. File Management
**Say:** "Jarvis, what files are in my Downloads folder?"  
**Expected:** JARVIS lists your Downloads

### 6. Music (if Spotify/Music app is installed)
**Say:** "Jarvis, play some music"  
**Expected:** Music starts playing

### 7. Code Generation
**Say:** "Jarvis, write a Python function to reverse a string"  
**Expected:** JARVIS generates the code

---

## 💡 Important Tips

### Speaking to JARVIS

1. **Always start with the wake word**: "Jarvis, [your command]"
2. **Speak clearly** at a normal pace
3. **Be specific** about what you want
4. **Wait for response** before next command

### Microphone Setup

**First time users**: macOS will ask for microphone permissions
- Click **"Allow"** when prompted
- If you missed it: System Preferences → Security & Privacy → Microphone

### If JARVIS Can't Hear You

1. Check microphone is working:
   - System Preferences → Sound → Input
   - Speak and watch the input level bars

2. Reduce background noise
3. Move closer to the microphone
4. Try speaking a bit louder

### Performance Optimization

**For faster responses:**
```bash
# Switch to a lighter model
ollama pull mistral

# Update .env
OLLAMA_MODEL="mistral"
```

**For better coding:**
```bash
# Use the code-specialized model
ollama pull codellama

# Update .env
OLLAMA_MODEL="codellama"
```

---

## 📚 Learning Resources

### Essential Docs (in order of importance)

1. **EXAMPLES.md** - 50+ voice command examples
2. **QUICKSTART.md** - Fast reference guide
3. **TROUBLESHOOTING.md** - Solutions to common issues
4. **ARCHITECTURE.md** - How it all works

### Command Cheat Sheet

```bash
# Start JARVIS workflow
./setup.sh              # First time only
ollama serve            # Terminal 1, always
python jarvis.py        # Terminal 2, to run JARVIS

# Useful commands
python test_jarvis.py   # Test system
python welcome.py       # Show welcome banner
nano .env               # Edit configuration

# Stop JARVIS
Ctrl+C                  # In JARVIS terminal
# Or say: "Jarvis, quit"
```

---

## 🎨 Customization Ideas

### Change Wake Word

Don't like "Jarvis"? Change it!

```bash
# Edit .env
WAKE_WORD="computer"  # Or: hey jarvis, ok computer, etc.
```

### Adjust Voice Speed

```bash
# Edit .env
VOICE_RATE=200  # Higher = faster (default: 175)
```

### Change Voice Gender

```bash
# Edit .env
VOICE_GENDER="female"  # or "male"
```

---

## 🔒 Privacy & Security

**Your data stays on your Mac:**
- ✅ All AI processing happens locally
- ✅ No cloud services for core functionality
- ✅ Conversation logs stored locally only
- ✅ You control all credentials

**Exception**: These features use internet:
- Voice-to-text (Google Speech Recognition API)
- Web browsing and search
- Sending emails
- Weather (if you add weather API)

---

## ⚡ Quick Troubleshooting

### "Cannot connect to Ollama"
```bash
# Check if Ollama is running
ps aux | grep ollama

# If not, start it
ollama serve
```

### "Could not understand audio"
- Speak closer to microphone
- Reduce background noise
- Check microphone permissions

### "Permission denied" errors
```bash
# Make scripts executable
chmod +x setup.sh test_jarvis.py welcome.py
```

### JARVIS is too slow
```bash
# Switch to faster model
ollama pull mistral
# Update OLLAMA_MODEL="mistral" in .env
```

For more issues, see **TROUBLESHOOTING.md**

---

## 🎉 You're All Set!

You now have a fully functional JARVIS assistant! Here's what to do next:

### Day 1: Basics
- Try 10 different commands from EXAMPLES.md
- Get comfortable with voice interaction
- Test system control features

### Week 1: Explore
- Set up email credentials for full functionality
- Try the coding assistant
- Customize wake word and voice settings

### Week 2: Master
- Create complex multi-step commands
- Set up reminders and scheduling
- Add your own custom skills

---

## 🆘 Getting Help

**Resources:**
- 📖 TROUBLESHOOTING.md - Common issues
- 📖 EXAMPLES.md - Command examples
- 📖 ARCHITECTURE.md - Technical details

**Need immediate help?**
1. Check the logs: `tail -f logs/jarvis_*.log`
2. Run tests: `python test_jarvis.py`
3. Re-run setup: `./setup.sh`

---

## 🚀 Advanced: Next Steps

Once you're comfortable with JARVIS:

### Add New Capabilities
- Explore `skills/` directory
- Create custom skills
- Extend existing functionality

### Integration Ideas
- Connect to Google Calendar
- Add smart home control
- Integrate with Notion/Evernote
- Add weather updates

### Automation
- Create morning routine
- Auto-organize files
- Scheduled reminders
- Proactive notifications

---

**Ready to begin?**

```bash
# Run this now:
./setup.sh
```

Then open two terminals:
1. `ollama serve`
2. `python jarvis.py`

**Say: "Jarvis, let's get started!"**

Welcome to the future! 🤖✨

---

*Built specifically for Fs Ferdows with ❤️*
