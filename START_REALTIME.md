# JARVIS Real-Time Voice - Quick Start

## 🚀 Start JARVIS (2 Steps)

### Step 1: Start Ollama
```bash
ollama serve
```

### Step 2: Run JARVIS
```bash
python3 jarvis.py
```

## 🎤 How to Talk to JARVIS

### Just Say "Jarvis"
```
→ jarvis

JARVIS: Yes Boss

→
```

### Ask a Question (with wake word)
```
→ jarvis what time is it

JARVIS: One moment, I'm thinking...
[5-30 seconds of processing]
JARVIS: The current time is 3:45 PM

→
```

### Ask Without Wake Word
```
→ tell me a joke

JARVIS: One moment, I'm thinking...
[Processing]
JARVIS: Why did the programmer quit? No arrays!

→
```

### Hey Jarvis Variant
```
→ hey jarvis play music

JARVIS: One moment, I'm thinking...
[Processing]
JARVIS: Playing your favorite playlist...

→
```

## ✨ What's New

| Feature | Behavior |
|---------|----------|
| **Wake Word Detection** | Responds to "jarvis", "hey jarvis" |
| **Wake Word Response** | Says "Yes Boss" if you just say the wake word |
| **Real-Time Feedback** | Speaks processing message immediately |
| **Command Extraction** | Removes wake word automatically |
| **Voice Output** | Speaks all responses aloud |
| **Text Input** | Type commands (no microphone needed) |

## 🔧 Configuration Check

Verify these are in `.env`:
```ini
TEXT_ONLY_MODE=True
SPEECH_OUTPUT_ENABLED=True
OLLAMA_MODEL=llama3:latest
```

## 📊 Voice Timeline

```
You input:     "jarvis what time is it"
                ↓
JARVIS speaks: "One moment, I'm thinking..." [INSTANT]
                ↓
JARVIS processes (5-30 seconds)
                ↓
JARVIS speaks: "The current time is 3:45 PM" [IMMEDIATE]
                ↓
Ready for next: "→"
```

## ✅ Testing

```bash
# Test everything works
python3 test_main_loop.py

# Should see: All tests passed ✓
```

## 🆘 Troubleshooting

| Issue | Solution |
|-------|----------|
| No voice output | Check `SPEECH_OUTPUT_ENABLED=True` |
| Wake word not recognized | Use lowercase: "jarvis hello" (not "JARVIS HELLO") |
| Ollama timeout | Run `ollama serve` in another terminal |
| Model not found | Run `ollama pull llama3` |

## 📚 Documentation

- `REALTIME_VOICE_GUIDE.md` - Visual guide with examples
- `REALTIME_IMPLEMENTATION.md` - Technical details
- `LOOP_FIX_SUMMARY.md` - Background on fixes

---

**Ready to use!** Type `python3 jarvis.py` and start talking.
