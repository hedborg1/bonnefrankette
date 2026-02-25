#!/bin/bash
# Plays a random sound when Claude finishes a task
PLUGIN_DIR="$(cd "$(dirname "$0")/.." && pwd)"

FILES=("$PLUGIN_DIR/sounds/task-done-1.mp3" "$PLUGIN_DIR/sounds/task-done-2.mp3")
RANDOM_FILE="${FILES[$RANDOM % ${#FILES[@]}]}"
afplay "$RANDOM_FILE" &
exit 0
