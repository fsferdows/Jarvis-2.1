import re

with open("utils/telegram_listener.py", "r") as f:
    content = f.read()

# I am going to find the double `actions = response.get("actions", [])`
parts = content.split('            actions = response.get("actions", [])')
if len(parts) >= 3:
    # there are two of them (or parts >=3 means at least 2 occurrences)
    new_content = parts[0] + '            actions = response.get("actions", [])' + parts[2]
    with open("utils/telegram_listener.py", "w") as f:
        f.write(new_content)
    print("Fixed!")
else:
    print("Not found twice.")
