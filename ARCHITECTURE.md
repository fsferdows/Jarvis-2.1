# JARVIS System Architecture

## System Overview

```
┌─────────────────────────────────────────────────────────────────┐
│                         USER INTERACTION                         │
│                    (Voice Input / Text Input)                    │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                        JARVIS CORE                               │
│  ┌───────────────┐  ┌──────────────┐  ┌────────────────────┐  │
│  │ Voice         │  │ AI Brain     │  │ Memory             │  │
│  │ Interface     │◄─┤ (Ollama)     │◄─┤ System             │  │
│  │               │  │              │  │                    │  │
│  │ - STT         │  │ - NLU        │  │ - Context          │  │
│  │ - TTS         │  │ - Decision   │  │ - History          │  │
│  │ - Wake Word   │  │ - Routing    │  │ - Search           │  │
│  └───────────────┘  └──────┬───────┘  └────────────────────┘  │
└─────────────────────────────┼────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                        SKILL MODULES                             │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────────────┐ │
│  │ System       │  │ Browser      │  │ Email                │ │
│  │ Control      │  │ Control      │  │ Handler              │ │
│  │              │  │              │  │                      │ │
│  │ - Apps       │  │ - Search     │  │ - SMTP               │ │
│  │ - Commands   │  │ - Navigate   │  │ - Send               │ │
│  │ - Screenshot │  │ - Selenium   │  │ - Compose            │ │
│  └──────────────┘  └──────────────┘  └──────────────────────┘ │
│                                                                  │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────────────┐ │
│  │ Music        │  │ Coding       │  │ File                 │ │
│  │ Player       │  │ Assistant    │  │ Manager              │ │
│  │              │  │              │  │                      │ │
│  │ - Spotify    │  │ - Generate   │  │ - Create             │ │
│  │ - Apple Music│  │ - Execute    │  │ - Read/Write         │ │
│  │ - Control    │  │ - Multi-lang │  │ - Move/Copy          │ │
│  └──────────────┘  └──────────────┘  └──────────────────────┘ │
│                                                                  │
│  ┌──────────────┐  ┌──────────────┐                            │
│  │ Message      │  │ Scheduler    │                            │
│  │ Handler      │  │              │                            │
│  │              │  │              │                            │
│  │ - iMessage   │  │ - Reminders  │                            │
│  │ - SMS        │  │ - Tasks      │                            │
│  │ - Telegram   │  │ - Recurring  │                            │
│  └──────────────┘  └──────────────┘                            │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                      SYSTEM INTEGRATION                          │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────────────┐ │
│  │ AppleScript  │  │ Shell        │  │ External             │ │
│  │              │  │ Commands     │  │ APIs                 │ │
│  │ - MacOS      │  │              │  │                      │ │
│  │   Control    │  │ - Terminal   │  │ - Spotify            │ │
│  │ - Apps       │  │ - Files      │  │ - Weather            │ │
│  │ - System     │  │ - Network    │  │ - Email              │ │
│  └──────────────┘  └──────────────┘  └──────────────────────┘ │
└─────────────────────────────────────────────────────────────────┘
```

## Data Flow

### 1. Voice Command Flow
```
User Speech → Microphone → STT (Google) → Text
                                            ↓
                                    Wake Word Detection
                                            ↓
                                    Command Extraction
                                            ↓
                                      AI Processing
                                            ↓
                                    Action Execution
                                            ↓
                                    TTS Response → Speaker
```

### 2. AI Processing Flow
```
User Command → Context + Memory
                     ↓
              Ollama LLM Processing
                     ↓
         ┌───────────┴───────────┐
         ↓                       ↓
   Response Text          Action JSON
         ↓                       ↓
    TTS Output            Skill Router
                                ↓
                         Execute Actions
                                ↓
                          Return Results
```

## Component Details

### Core Components

#### 1. Voice Interface (`core/voice.py`)
- **Speech-to-Text**: Uses Google Speech Recognition
- **Text-to-Speech**: Uses pyttsx3 for voice output
- **Wake Word Detection**: Listens for "Jarvis" keyword
- **Ambient Noise Calibration**: Auto-adjusts for environment

#### 2. AI Brain (`core/brain.py`)
- **Natural Language Understanding**: Powered by Ollama (llama3)
- **Intent Recognition**: Determines user's goal
- **Action Planning**: Converts intent to executable actions
- **Skill Routing**: Directs actions to appropriate modules

#### 3. Memory System (`core/memory.py`)
- **Conversation History**: Maintains context
- **Search Capability**: Find past interactions
- **Session Management**: Tracks session duration

#### 4. Task Scheduler (`core/scheduler.py`)
- **Reminders**: Time-based notifications
- **Recurring Tasks**: Periodic actions
- **Background Execution**: Non-blocking operations

### Skill Modules

Each skill module follows a consistent interface:
```python
def execute(action_type: str, params: Dict) -> Dict[str, Any]:
    # Execute the action
    # Return success/failure with results
```

#### System Control (`skills/system_control.py`)
- Open/Close applications
- Execute shell commands
- Take screenshots
- Control volume/brightness
- Power management (sleep, lock)

#### Browser Control (`skills/browser.py`)
- Web search (Google)
- URL navigation
- Selenium automation
- Page capture

#### Email Handler (`skills/email_handler.py`)
- Send emails via SMTP
- Support for Gmail, Outlook, etc.
- Attachment handling

#### Music Player (`skills/music_player.py`)
- Spotify integration
- Apple Music support
- Playback control (play, pause, next, etc.)
- Volume control

#### Coding Assistant (`skills/coding_assistant.py`)
- Code generation
- Multi-language execution (Python, JS, Bash)
- File creation
- Syntax checking

#### File Manager (`skills/file_manager.py`)
- CRUD operations on files/folders
- Directory listing
- File movement/copying
- Content reading/writing

#### Message Handler (`skills/message_handler.py`)
- iMessage support (via AppleScript)
- SMS capability
- Telegram integration (optional)

## Configuration

All settings are managed through environment variables (`.env`):

```
USER_NAME           → Personalization
OLLAMA_HOST         → AI service endpoint
OLLAMA_MODEL        → Which model to use
EMAIL_*             → Email credentials
SPOTIFY_*           → Music service API
VOICE_*             → TTS settings
WAKE_WORD           → Activation keyword
```

## Security

- **Local AI Processing**: All AI runs locally via Ollama
- **No Cloud Dependency**: Core functions work offline
- **Credential Protection**: Sensitive data in .env (gitignored)
- **Permission-based**: MacOS security prompts for system access

## Extension Points

The system is designed for easy extension:

1. **New Skills**: Add new modules in `skills/`
2. **New Actions**: Extend existing skill classes
3. **Custom Prompts**: Modify AI behavior in `brain.py`
4. **Alternative AI**: Swap Ollama for another LLM
5. **UI Options**: Add web interface in `web_ui/`

## Performance Considerations

- **Lazy Loading**: Skills loaded on demand
- **Async Operations**: Non-blocking I/O where possible
- **Resource Management**: Cleanup after operations
- **Error Handling**: Graceful degradation
- **Logging**: Comprehensive debugging info

## Dependencies

### System
- **macOS**: AppleScript for system control
- **Homebrew**: Package management
- **Ollama**: Local LLM server

### Python Packages
- **Speech**: SpeechRecognition, pyttsx3, pyaudio
- **AI**: Ollama, langchain
- **Automation**: Selenium, pyautogui, pyobjc
- **Communication**: smtplib, requests
- **Utils**: Rich, schedule, python-dotenv

## Future Enhancements

- [ ] Calendar integration (Google Calendar, Apple Calendar)
- [ ] Smart home control (HomeKit, Home Assistant)
- [ ] Multi-language support
- [ ] Mobile companion app
- [ ] Custom skill marketplace
- [ ] Voice training for better recognition
- [ ] Proactive suggestions
- [ ] Meeting transcription
- [ ] Document summarization
- [ ] Advanced context awareness
