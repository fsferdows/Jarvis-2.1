# 🔍 JARVIS Debug Guide - Fixing Non-Responsive Issues

## Issues Fixed ✅

### 1. **Model Name Error** (Line 69)
**Problem:** `{settings.OLLAMA3}` doesn't exist in the settings  
**Fix:** Changed to `{settings.OLLAMA_MODEL}` which correctly reads from `.env`  
**Status:** ✅ FIXED

### 2. **Duplicate Exception Handlers** (Lines 175-188)
**Problem:** Two `except Exception` blocks causing Python syntax error  
```python
# BROKEN (causes syntax error):
except Exception as e:
    # first handler
except EOFError:
    pass
except Exception as e:  # ❌ ERROR: duplicate exception type
    # second handler
```

**Fix:** Consolidated to single exception handler with specific error type checks  
```python
# FIXED:
except KeyboardInterrupt:
    break
except EOFError:
    break
except Exception as e:  # ✅ One handler for all other exceptions
    # Handle specific error types
```
**Status:** ✅ FIXED

### 3. **Missing Debug Output**
**Problem:** No visibility into where the program stops  
**Fix:** Added `[DEBUG]` print statements at each critical stage:
- When listening for input
- When processing commands
- When calling Ollama
- When outputting voice
- When errors occur

**Status:** ✅ FIXED

---

## Debug Output Walkthrough

When you run JARVIS now, you'll see this flow:

```
[DEBUG] TEXT_ONLY_MODE enabled - waiting for text input...
→ 
[You type a command here]

[DEBUG] Processing command: 'what time is it'
Working on that now, Boss. Please stand by...
[DEBUG] Calling Ollama AI Brain for processing...
[DEBUG] Ollama responded in 2.34s
JARVIS: It's currently 3:45 PM...
[Completed in 2.3s]
[DEBUG] Starting voice output...
[JARVIS speaks the response]
[DEBUG] Voice output complete - ready for next command
```

---

## How to Use Debug Mode

### Option 1: Run with Full Debug Output
```bash
python3 jarvis.py
```
All `[DEBUG]` messages will print to terminal showing you exactly where it is.

### Option 2: Check Logs Only
```bash
tail -f logs/jarvis_*.log
```
This shows detailed logging without the debug terminal output.

### Option 3: Combine Both (Recommended for Troubleshooting)
```bash
# Terminal 1: Ollama
ollama serve

# Terminal 2: JARVIS with logs visible
python3 jarvis.py 2>&1 | tee debug_output.txt
```
This logs everything to both terminal AND a file.

---

## Debug Checkpoints

### 🔴 Stops at "Listening..." 
**Meaning:** Waiting for input (working normally)  
**Action:** Speak or type your command

### 🔴 Stops at "[DEBUG] Processing command..."
**Meaning:** Command received, now calling Ollama  
**Action:** Wait for Ollama to respond (1-4 seconds)  
**If stuck:** Check if `ollama serve` is running in another terminal

### 🔴 Stops at "[DEBUG] Calling Ollama..."
**Meaning:** Ollama is taking too long  
**Action:** Wait longer or check Ollama health:
```bash
curl http://localhost:11434/api/tags
```

### 🔴 Stops at "[DEBUG] Starting voice output..."
**Meaning:** Response ready, speaking now  
**Action:** Listen for JARVIS voice output  
**If no sound:** Check `core/voice.py` has `say` command available

### 🔴 Gets "[DEBUG] Exception in main loop"
**Meaning:** An error occurred (details follow)  
**Action:** Read the error message and check logs  
**Status:** JARVIS will attempt to recover and keep listening

---

## Key Configuration Settings

All in `.env` file:

```bash
# AI Model
OLLAMA_MODEL=llama3          # The model to use
OLLAMA_HOST=http://localhost:11434  # Where Ollama runs
OLLAMA_TIMEOUT=120           # Max seconds to wait for response

# Input Mode
TEXT_ONLY_MODE=True          # Set to False for microphone input
RECOGNIZER_LISTEN_TIMEOUT=5  # Seconds to listen for speech
RECOGNIZER_PHRASE_TIME_LIMIT=8  # Max phrase length (seconds)

# Voice Output
VOICE_RATE=175               # Speech speed (words per minute)
VOICE_VOLUME=0.9             # Volume (0.0-1.0)

# Personality
PERSONALITY_MODE=witty       # professional, witty, friendly, sarcastic
```

---

## Common Issues & Solutions

### Issue: "OLLAMA_MODEL: KeyError"
**Cause:** Missing OLLAMA_MODEL in .env or settings.py  
**Solution:** Make sure .env has `OLLAMA_MODEL=llama3` or your chosen model

### Issue: Program crashes with "settings has no attribute OLLAMA3"
**Status:** ✅ FIXED in this update - was using wrong setting name

### Issue: "Syntax Error in jarvis.py"
**Status:** ✅ FIXED - duplicate exception handlers removed

### Issue: Hangs after greeting
**Cause:** Usually one of:
1. `ollama serve` not running
2. Voice input waiting for speech (when microphone enabled)
3. Ollama timeout (slow network or large model)

**Debug:** 
- Check Ollama: `curl http://localhost:11434/api/tags`
- Check TEXT_ONLY_MODE in .env (should be True for text input)
- Check logs: `tail -f logs/jarvis_*.log`

### Issue: "[DEBUG] No command received (timeout...)"
**Meaning:** Normal - waiting for speech or text input  
**Solution:** Type your command or speak louder

### Issue: Voice output not working
**Cause:** macOS `say` command not available  
**Status:** JARVIS falls back to printing voice text to console  
**Check:**
```bash
which say      # Should show /usr/bin/say
say "test"     # Should speak
```

---

## Testing Each Component

### Test 1: Ollama Connection
```bash
curl http://localhost:11434/api/tags
# Should show list of available models
```

### Test 2: Voice Output
```bash
python3 -c "from core.voice import VoiceInterface; v = VoiceInterface(); v.speak('Hello Boss')"
# Should speak the phrase
```

### Test 3: Settings Loading
```bash
python3 -c "from config.settings import Settings; s = Settings(); print(f'Model: {s.OLLAMA_MODEL}'); print(f'Text Mode: {s.TEXT_ONLY_MODE}')"
```

### Test 4: Brain Processing
```bash
python3 -c "from core.brain import JarvisBrain; b = JarvisBrain(); result = b.process_command('what time is it', {}); print(result['message'])"
# Should get AI response (if Ollama is running)
```

### Test 5: Full JARVIS Flow
```bash
python3 jarvis.py
# Should show:
# 1. Banner with model name
# 2. [DEBUG] TEXT_ONLY_MODE enabled
# 3. Ready for input
# 4. Processes your command with debug output
```

---

## Performance Metrics

Watch these in debug output:

```
[DEBUG] Ollama responded in 2.34s
↑ This is AI thinking time. Normal: 1-5 seconds
```

- **< 1 second:** Very fast (simple query)
- **1-3 seconds:** Normal (typical response)
- **3-5 seconds:** Slower (complex query)
- **> 5 seconds:** Timeout or stuck (check Ollama)

---

## If JARVIS Still Stops

### Step 1: Run diagnostic
```bash
python3 -c "
from config.settings import Settings
from core.voice import VoiceInterface
from core.brain import JarvisBrain
import sys

print('=== JARVIS DIAGNOSTIC ===')
try:
    s = Settings()
    print(f'✓ Settings loaded')
    print(f'  - Model: {s.OLLAMA_MODEL}')
    print(f'  - Text Only: {s.TEXT_ONLY_MODE}')
except Exception as e:
    print(f'✗ Settings error: {e}')
    sys.exit(1)

try:
    v = VoiceInterface()
    print(f'✓ Voice Interface ready')
    print(f'  - Microphone Available: {v.microphone_available}')
except Exception as e:
    print(f'✗ Voice error: {e}')

try:
    b = JarvisBrain()
    print(f'✓ Brain ready')
except Exception as e:
    print(f'✗ Brain error: {e}')

print('=== All components ready ===')
"
```

### Step 2: Check logs
```bash
tail -n 50 logs/jarvis_*.log
# Look for ERROR or WARNING lines
```

### Step 3: Run with minimal config
```bash
# Simplest test
python3 -c "
from jarvis import JarvisAssistant
j = JarvisAssistant()
j.startup()
# Should greet you and not crash
"
```

---

## Summary of Fixes Applied

| Issue | Fix | Status |
|-------|-----|--------|
| OLLAMA3 undefined | Changed to OLLAMA_MODEL | ✅ FIXED |
| Duplicate exception handlers | Consolidated to single handler | ✅ FIXED |
| No debug output | Added [DEBUG] prints throughout | ✅ ADDED |
| No error recovery | Added error type checking | ✅ IMPROVED |
| No audio fallback messaging | Added audio error detection | ✅ ADDED |

---

## Ready to Run

```bash
# Terminal 1
ollama serve

# Terminal 2
python3 jarvis.py
```

JARVIS will now show you exactly where it is at every step! 🎯

**[DEBUG] outputs show you the program flow**  
**System is fully operational and ready to assist!** ✨

