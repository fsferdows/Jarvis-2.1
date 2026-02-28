# 🚀 START HERE: Running JARVIS with Real-Time & Personality

## 30-Second Quick Start

### 1. Install Ollama (if not already done)
```bash
brew install ollama
```

### 2. Start Ollama Server (in Terminal 1)
```bash
ollama serve
```

### 3. In Terminal 2, Pull Fast Model
```bash
ollama pull mistral
```

### 4. Set Environment Variables
```bash
export USER_NAME="Your Name"
export OLLAMA_MODEL=mistral
export PERSONALITY_MODE=witty
export FAST_MODE=True
```

### 5. Run JARVIS
```bash
cd /Users/user/Desktop/Jarvis
python3 jarvis.py
```

**Done!** JARVIS is now running with real-time responses (2-5s) and witty personality. 🎉

---

## Full Setup (5 Minutes)

### Prerequisites
- Ollama running: `ollama serve`
- Python 3.9+
- Microphone (optional, text fallback works)

### Step 1: Create .env File
```bash
cd /Users/user/Desktop/Jarvis
cp .env.example .env
```

### Step 2: Edit .env with Your Settings
```bash
nano .env
```

**Minimum required:**
```
USER_NAME=Your Name
OLLAMA_HOST=http://localhost:11434
OLLAMA_MODEL=mistral
PERSONALITY_MODE=witty
```

**For Telegram (optional):**
```
TELEGRAM_BOT_TOKEN=your_token_here
TELEGRAM_CHAT_ID=your_chat_id_here
```

### Step 3: Install Dependencies (if not done)
```bash
python3 -m pip install -r requirements.txt
```

### Step 4: Run JARVIS
```bash
python3 jarvis.py
```

---

## First Commands to Try

Once JARVIS is running, try these:

### Simple Commands (2-3s response)
```
"Jarvis, open Safari"
"What time is it?"
"Play some music"
```

### Complex Commands (4-5s response)
```
"Search for Python tutorials and open the first result"
"Send a message to John on Telegram: Hello there!"
"Explain how machine learning works"
```

### Personality Commands
```
"Tell me a joke"
"What's your personality?"
"You seem very witty today"
```

### Testing
```
"Hello Jarvis"
"Quit"
```

---

## Configuration Options

### Personality Modes
Change in `.env` or export:
```bash
# Witty (default) - Smart with humor
export PERSONALITY_MODE=witty

# Friendly - Warm and encouraging
export PERSONALITY_MODE=friendly

# Professional - Formal and business-like
export PERSONALITY_MODE=professional

# Sarcastic - Edgy and playful
export PERSONALITY_MODE=sarcastic
```

### Response Speed
```bash
# For fastest responses (2-3s)
export MAX_RESPONSE_TIME=3
export COMPACT_PROMPTS=True

# For better quality (4-5s)
export MAX_RESPONSE_TIME=5
export COMPACT_PROMPTS=False
```

### Emotion Level
```bash
# More emotional (0.0-1.0)
export EMOTION_LEVEL=0.8  # Default
export EMOTION_LEVEL=1.0  # Very emotional
export EMOTION_LEVEL=0.5  # Less emotional
```

---

## Troubleshooting

### "Cannot connect to Ollama"
**Fix:** Make sure `ollama serve` is running in a separate terminal

### "Speech recognition failed"
**Fix:** Not a problem! Just type your command instead. It will still work.

### "Responses are too slow (>5s)"
**Fix:** 
1. Use faster model: `ollama pull mistral`
2. Set `OLLAMA_MODEL=mistral` in .env
3. Enable `FAST_MODE=True`

### "JARVIS sounds repetitive"
**Fix:** Enable variation in .env:
```
USE_VARIATION=True
EMOTION_LEVEL=0.8
```

---

## Model Recommendations

### For Speed (2-3s)
```bash
ollama pull mistral        # 7B model, fast
ollama pull neural-chat    # 7B model, also fast
```

### For Quality (4-5s)
```bash
ollama pull llama3         # 8B model, good balance
ollama pull llama3:13b     # 13B model, better quality
```

### For Best Quality (5-10s)
```bash
ollama pull llama3:70b     # 70B model, very smart
```

---

## Voice Commands Examples

### System Control
- "Open Terminal"
- "Open Safari and search for AI"
- "Take a screenshot"

### Messaging
- "Send email to john@example.com subject Meeting body See you at 3pm"
- "Send Telegram message: Hello team!"
- "Text Sarah: Running late"

### Media
- "Play some jazz music"
- "Play the latest Marvel movie on YouTube"
- "Next song"
- "Pause music"

### Information
- "What's the weather?"
- "Who won the World Cup?"
- "Explain quantum computing"

### File Management
- "What's in my Downloads folder?"
- "Read my notes.txt file"
- "Create a new TODO list"

---

## Advanced Configuration

### Custom Prompt for Faster Responses
Edit `.env`:
```
COMPACT_PROMPTS=True    # Uses shorter system prompt
```

### Personality at Runtime
Create a script:
```python
from core.brain import JarvisBrain

brain = JarvisBrain()

# Change personality
brain.personality.change_personality('sarcastic')

# Process command
response = brain.process_command("Hello")
print(response["message"])
```

### View Learned Preferences
```bash
cat /Users/user/Desktop/Jarvis/data/preferences.json
```

### View Interaction History
```bash
cat /Users/user/Desktop/Jarvis/data/interactions.json
```

---

## Full Feature List

✅ Real-time responses (2-5 seconds)
✅ 4 personality modes
✅ Emotional understanding
✅ Opens apps and executes commands
✅ Sends emails, Telegram, WhatsApp
✅ Plays YouTube and Spotify
✅ Browses web and searches
✅ Reads and manages files
✅ Executes and explains code
✅ Learns your preferences
✅ Logs all actions safely
✅ Voice recognition with text fallback
✅ macOS voice output
✅ Confirmation for dangerous actions

---

## Next Steps

1. ✅ Run JARVIS: `python3 jarvis.py`
2. ✅ Try commands above
3. ✅ Explore different personality modes
4. ✅ Configure for your needs in `.env`
5. ✅ Optional: Set up Telegram for messaging

---

## Documentation

For more details, see:
- `REAL_TIME_GUIDE.md` - Real-time optimization
- `SETUP_COMPLETE.md` - Full setup guide
- `IMPLEMENTATION_SUMMARY.md` - Feature overview
- `.env.example` - All configuration options

---

## Support

Having issues?
1. Check `logs/jarvis_*.log`
2. Enable debug mode: `export LOG_LEVEL=DEBUG`
3. Check `TROUBLESHOOTING.md`

---

## Ready to Go!

You now have a **personal AI assistant that:**
- Responds in real-time (2-5 seconds)
- Behaves like a human with emotions
- Has distinct personality
- Learns from your behavior
- Can do everything on your Mac

**Enjoy JARVIS!** 🤖✨

Run: `python3 jarvis.py`
