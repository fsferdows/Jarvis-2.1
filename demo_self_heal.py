import sys
import os
from pathlib import Path

# Add project root to path
sys.path.insert(0, str(Path('/Users/user/Desktop/Jarvis 2')))

from core.brain import JarvisBrain
from utils.logger import setup_logger

logger = setup_logger()
brain = JarvisBrain()

app_path = '/Users/user/Desktop/Jarvis 2/jarvis-mission-control'
app_name = 'mission-control'

print(f"🚀 [LOCAL AGI] Starting Autonomous Deployment for {app_name}...")
print(f"📍 Location: {app_path}")

# Trigger the autonomous pipeline
# This will try to deploy, fail validation (since no index.html at root and no dist folder yet), 
# then self-heal (run build), then redeploy.
result = brain._autonomous_deploy(app_path, app_name)

if result.get("success"):
    print("\n" + "="*50)
    print("✅ DEPLOYMENT SUCCESSFUL")
    print("="*50)
    print(result.get("message"))
else:
    print("\n" + "="*50)
    print("❌ DEPLOYMENT FAILED")
    print("="*50)
    print(result.get("error"))
