#!/bin/bash
# Toggle mute for all audio hooks (shared with connardva)
MUTE_FLAG="/tmp/connardva-muted"

if [ -f "$MUTE_FLAG" ]; then
  rm "$MUTE_FLAG"
  echo "🔊 unmuted"
else
  touch "$MUTE_FLAG"
  echo "🔇 muted"
fi
