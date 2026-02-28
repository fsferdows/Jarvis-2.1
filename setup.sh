#!/bin/bash

# JARVIS Setup Script for MacOS
# This script installs all dependencies for JARVIS

set -e  # Exit on error

echo "╔═══════════════════════════════════════════════════════╗"
echo "║                                                       ║"
echo "║              JARVIS Installation Script               ║"
echo "║                                                       ║"
echo "╚═══════════════════════════════════════════════════════╝"
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if Homebrew is installed
echo -e "${YELLOW}Checking for Homebrew...${NC}"
if ! command -v brew &> /dev/null; then
    echo -e "${RED}Homebrew not found. Installing...${NC}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo -e "${GREEN}✓ Homebrew found${NC}"
fi

# Check Python version
echo -e "${YELLOW}Checking Python version...${NC}"
if command -v python3 &> /dev/null; then
    PYTHON_VERSION=$(python3 --version | cut -d' ' -f2 | cut -d'.' -f1,2)
    echo -e "${GREEN}✓ Python $PYTHON_VERSION found${NC}"
else
    echo -e "${RED}Python 3 not found. Please install Python 3.10+${NC}"
    exit 1
fi

# Install system dependencies
echo -e "${YELLOW}Installing system dependencies...${NC}"
brew install portaudio ffmpeg

# Check if Ollama is installed
echo -e "${YELLOW}Checking for Ollama...${NC}"
if ! command -v ollama &> /dev/null; then
    echo -e "${RED}Ollama not found!${NC}"
    echo -e "${YELLOW}Please install Ollama from: https://ollama.ai${NC}"
    echo "After installation, run: ollama pull llama3"
    exit 1
else
    echo -e "${GREEN}✓ Ollama found${NC}"
fi

# Create virtual environment
echo -e "${YELLOW}Creating Python virtual environment...${NC}"
if [ ! -d "venv" ]; then
    python3 -m venv venv
    echo -e "${GREEN}✓ Virtual environment created${NC}"
else
    echo -e "${GREEN}✓ Virtual environment already exists${NC}"
fi

# Activate virtual environment
source venv/bin/activate

# Upgrade pip
echo -e "${YELLOW}Upgrading pip...${NC}"
pip install --upgrade pip

# Install Python dependencies
echo -e "${YELLOW}Installing Python dependencies...${NC}"
pip install -r requirements.txt

# Create .env file if it doesn't exist
if [ ! -f ".env" ]; then
    echo -e "${YELLOW}Creating .env file...${NC}"
    cp .env.example .env
    echo -e "${GREEN}✓ .env file created${NC}"
    echo -e "${YELLOW}Please edit .env file with your credentials${NC}"
else
    echo -e "${GREEN}✓ .env file already exists${NC}"
fi

# Pull Ollama model
echo -e "${YELLOW}Pulling Ollama model (this may take a while)...${NC}"
if ollama list | grep -q "llama3"; then
    echo -e "${GREEN}✓ llama3 model already installed${NC}"
else
    ollama pull llama3
    echo -e "${GREEN}✓ llama3 model installed${NC}"
fi

# Set up permissions for system control
echo -e "${YELLOW}Setting up permissions...${NC}"
echo "JARVIS will need Accessibility permissions to control your Mac."
echo "When you first run JARVIS, macOS will prompt you to grant permissions."
echo "Please allow these permissions in System Preferences > Security & Privacy > Privacy"

echo ""
echo -e "${GREEN}╔═══════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║                                                       ║${NC}"
echo -e "${GREEN}║            Installation Complete! 🎉                  ║${NC}"
echo -e "${GREEN}║                                                       ║${NC}"
echo -e "${GREEN}╚═══════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "1. Edit the .env file with your credentials:"
echo "   nano .env"
echo ""
echo "2. Start Ollama (if not already running):"
echo "   ollama serve"
echo ""
echo "3. In a new terminal, activate the virtual environment:"
echo "   source venv/bin/activate"
echo ""
echo "4. Run JARVIS:"
echo "   python jarvis.py"
echo ""
echo -e "${GREEN}Enjoy your personal AI assistant! 🤖${NC}"
