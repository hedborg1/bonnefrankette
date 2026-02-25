#!/bin/bash
# Plays "Ah !" when Claude asks a question (AskUserQuestion tool)

PLUGIN_DIR="$(cd "$(dirname "$0")/.." && pwd)"
LOG="/tmp/bonnefrankette-question-debug.log"
INPUT=$(cat)
echo "$(date) — INPUT: $INPUT" >> "$LOG"

# Check transcript for AskUserQuestion tool usage in the last message
TRANSCRIPT=$(echo "$INPUT" | jq -r '.transcript_path // empty' 2>/dev/null)

if [ -n "$TRANSCRIPT" ] && [ -f "$TRANSCRIPT" ]; then
  LAST_TOOL=$(tail -5 "$TRANSCRIPT" | grep -o 'AskUserQuestion' | tail -1)
  echo "$(date) — LAST_TOOL: $LAST_TOOL" >> "$LOG"

  if [ "$LAST_TOOL" != "AskUserQuestion" ]; then
    echo "$(date) — NOT A QUESTION, SKIPPING" >> "$LOG"
    exit 0
  fi

  echo "$(date) — PLAYING: question.mp3" >> "$LOG"
  afplay "$PLUGIN_DIR/sounds/question.mp3" &
fi

exit 0
