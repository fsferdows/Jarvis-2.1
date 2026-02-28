# JARVIS Real-Time Voice Interaction Guide

## 🎙️ Voice Timeline - What You'll Hear

### Scenario 1: Just Say "Jarvis"
```
You say/type:  "jarvis"
               ↓ [Instant response]
JARVIS speaks: "Yes Boss"
               ↓ [Ready for command]
```

### Scenario 2: "Jarvis, Hello"
```
You say/type:  "jarvis hello"
               ↓ [Extracts "hello"]
JARVIS speaks: "One moment, I'm thinking..." [IMMEDIATELY]
               ↓ [Processes for 5-30 seconds]
JARVIS speaks: "Hello! I'm JARVIS, your personal AI assistant"
               ↓ [Ready for next command]
```

### Scenario 3: Command Directly (No Wake Word)
```
You type:      "what time is it"
               ↓ [No wake word needed]
JARVIS speaks: "Checking that for you..." [IMMEDIATELY]
               ↓ [Processes for 5-30 seconds]
JARVIS speaks: "The current time is 3:45 PM"
               ↓ [Ready for next command]
```

### Scenario 4: "Hey Jarvis" Variant
```
You say:       "hey jarvis tell me a joke"
               ↓ [Extracts "tell me a joke"]
JARVIS speaks: "One moment, I'm thinking..." [IMMEDIATELY]
               ↓ [Processes for 5-30 seconds]
JARVIS speaks: "Why did the scarecrow win an award? Because he was outstanding in his field!"
               ↓ [Ready for next command]
```

## 📋 Complete Flow Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                    JARVIS STARTUP                           │
├─────────────────────────────────────────────────────────────┤
│  JARVIS: "[Professional greeting spoken aloud]"             │
│  → [Ready prompt]                                           │
└─────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────┐
│                   USER INPUT PHASE                          │
├─────────────────────────────────────────────────────────────┤
│  You type/speak: "jarvis what time is it"                   │
│                                                              │
│  [System checks if wake word present]                       │
│  ✓ Yes - Extract command: "what time is it"                │
│  ✗ No - Use as-is                                           │
└─────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────┐
│            IMMEDIATE VOICE FEEDBACK PHASE                   │
├─────────────────────────────────────────────────────────────┤
│  🔊 JARVIS SPEAKS IMMEDIATELY:                              │
│     "One moment, I'm thinking..."                           │
│                                                              │
│  ⏱️  Total delay: < 500ms (very fast response)              │
│                                                              │
│  🎯 Why: Let user know we heard them and are processing    │
└─────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────┐
│              PROCESSING PHASE (Background)                  │
├─────────────────────────────────────────────────────────────┤
│  While JARVIS is processing (5-30 seconds):                 │
│  ✓ User can type next command (if in text mode)            │
│  ✓ Display shows status                                    │
│  ✓ No blocking - system is responsive                      │
│                                                              │
│  System sends request to Ollama:                            │
│  POST http://localhost:11434/api/generate                   │
│  {                                                          │
│    "model": "llama3:latest",                               │
│    "prompt": "What time is it?",                            │
│    "stream": false                                          │
│  }                                                          │
└─────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────┐
│          RESPONSE DELIVERY PHASE (Voice)                    │
├─────────────────────────────────────────────────────────────┤
│  Ollama responds with AI-generated answer                   │
│                                                              │
│  🔊 JARVIS SPEAKS RESPONSE:                                 │
│     "The current time is 3:45 PM"                           │
│                                                              │
│  📺 Text also displayed:                                    │
│     JARVIS: The current time is 3:45 PM                     │
│     [Completed in 12.5s]                                    │
│                                                              │
│  ⏱️  Voice delivery: Immediate as response received         │
└─────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────┐
│                  READY FOR NEXT COMMAND                     │
├─────────────────────────────────────────────────────────────┤
│  → [Back to input prompt]                                   │
│                                                              │
│  System is ready for next command immediately              │
└─────────────────────────────────────────────────────────────┘
```

## 🎯 Wake Word Recognition Matrix

| Input | Recognized | Response | Next |
|-------|-----------|----------|------|
| "jarvis" | Yes - wake word only | "Yes Boss" | Wait for next input |
| "hey jarvis" | Yes - wake word only | "Yes Boss" | Wait for next input |
| "jarvis hello" | Yes - extract "hello" | Process "hello" | JARVIS responds |
| "hey jarvis what time" | Yes - extract "what time" | Process "what time" | JARVIS responds |
| "hello" | No - no wake word | Process "hello" | JARVIS responds |
| "what is 2+2" | No - no wake word | Process "what is 2+2" | JARVIS responds |

## 🔊 Voice Output Timing

```
User Input    Processing Feedback    Response Time    Total Time
"jarvis"      (none)                 0.5s (immediate) 0.5s ⚡
"jarvis cmd"  0.3s (immediate)       5-30s (Ollama)   5-30s
"hello"       0.3s (immediate)       5-30s (Ollama)   5-30s
```

## 🆘 What to Do If...

### "JARVIS isn't responding to 'Jarvis'"
```
Try:
→ jarvis
→ hey jarvis
→ hello jarvis

Debug:
1. Check debug output: "[DEBUG] Wake word detected"
2. Verify you're using lowercase: "jarvis" not "JARVIS"
3. Verify TEXT_ONLY_MODE=True in .env if using text input
```

### "JARVIS speaks but then stops"
```
Solution:
1. Ensure SPEECH_OUTPUT_ENABLED=True in .env
2. Test: say "Hello" in terminal (should produce sound)
3. Check volume is not muted
4. Restart JARVIS: python3 jarvis.py
```

### "Processing feedback is silent"
```
Check:
1. SPEECH_OUTPUT_ENABLED=True
2. Ollama is running: ollama serve
3. Model available: ollama ls (should show llama3:latest)
4. Network connection to localhost:11434 working
```

### "Wake word extraction not working"
```
Examples that work:
→ jarvis hello        ✓
→ jarvis play music   ✓
→ hey jarvis time     ✓

Examples that don't:
→ jarvishello         ✗ (no space)
→ JARVIS HELLO        ~ (works, but converted to lowercase)
```

## ✨ Quick Features Summary

| Feature | Status | Behavior |
|---------|--------|----------|
| Wake word detection | ✅ | Responds to "jarvis", "hey jarvis" etc |
| Wake word only | ✅ | Says "Yes Boss" if only wake word |
| Command extraction | ✅ | Removes wake word, processes command |
| Immediate feedback | ✅ | Speaks processing message instantly |
| Real-time response | ✅ | Speaks response as soon as ready |
| Text input | ✅ | Type commands (no microphone) |
| Voice output | ✅ | Always speaks (configurable) |
| Professional voice | ✅ | Daniel voice at 175 WPM |

---

**Ready to use!** Just run: `python3 jarvis.py`
