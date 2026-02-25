#!/bin/bash
# Plays "Pouah ! Ca puir !" on the first prompt of each Claude session

PLUGIN_DIR="$(cd "$(dirname "$0")/.." && pwd)"

# Check if we already greeted in this Claude session
# Use parent PID (Claude process) to track session
PPID_FILE="/tmp/bonnefrankette-greeted-$(ps -o ppid= -p $PPID 2>/dev/null | tr -d ' ')"

if [ ! -f "$PPID_FILE" ]; then
  touch "$PPID_FILE"
  afplay "$PLUGIN_DIR/sounds/greeting.mp3" &
fi

exit 0
