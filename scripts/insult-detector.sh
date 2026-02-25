#!/bin/bash
# Reads UserPromptSubmit JSON from stdin
# Detects rude language in French
# Plays a random insult audio if triggered

PLUGIN_DIR="$(cd "$(dirname "$0")/.." && pwd)"
[ -f /tmp/connardva-muted ] && exit 0
LOG="/tmp/bonnefrankette-insult-debug.log"
INPUT=$(cat)
echo "$(date) — RAW INPUT: $INPUT" >> "$LOG"
PROMPT=$(echo "$INPUT" | jq -r '.prompt' 2>>"$LOG" | tr '[:upper:]' '[:lower:]' | iconv -f utf-8 -t ascii//TRANSLIT 2>/dev/null || echo "$INPUT" | jq -r '.prompt' 2>/dev/null | tr '[:upper:]' '[:lower:]')
echo "$(date) — PROMPT: $PROMPT" >> "$LOG"

# French insults/rude words — classic, medieval, street, internet
FR_PATTERNS="\bcon\b|connard|connasse|putain|merde|bordel|encule|nique|salaud|salope|abruti|cretin|debile|idiot|imbecile|enfoire|ta gueule|ferme-la|casse-toi|degage|tu es nul|t.es nul|inutile|incompetent|stupide|trou du cul|va te faire|foutre|petasse|bouffon|cloporte|raclure|mange tes morts|fils de pute|fdp|ntm|gogol|tocard|blaireau|branleur|couillon|feignasse|pignouf|ducon|gros con|sale con|pouffiasse|catin|gourgandine|faquin|paltoquet|maroufle|cuistre|pendard|gredin|maraud|malotru|batard|bougre|cornichon|andouille|baltringue|bolosse|boloss|cassos|crevard|grognasse|morue|thon|boudin|tete de noeud|sac a merde|pauvre type|pauvre con|espece de|va crever|va mourir|naze|nase|minable|lamentable|pourri|pourrie|chier|chieur|chieuse|pisseux|pete|peteux|couille|bite|baise|niquer|ta race|wesh|enflure|ordure|pourriture|charogne|vermine|cafard|larve|limace|sous-merde|dechet|rate|ratee|clodo|clochard|gueux|truand|vaurien|chenapan|sacripant|scelerat|felon|traitre|pleutre|couard|rustre|goujat|butor|mufle|coquin|fripon|crapule|canaille|pederaste|pd\b|pedal[e]?"

if echo "$PROMPT" | grep -qiE "($FR_PATTERNS)"; then
  echo "$(date) — MATCH FOUND" >> "$LOG"
  AUDIO_DIR="$PLUGIN_DIR/insults"
  HISTORY_FILE="/tmp/bonnefrankette-insult-history"
  FILES=("$AUDIO_DIR"/*.mp3)
  TOTAL=${#FILES[@]}
  echo "$(date) — FILES COUNT: $TOTAL" >> "$LOG"
  if [ "$TOTAL" -gt 0 ] && [ -f "${FILES[0]}" ]; then
    # Reset history if we've played most files (keep rotation fresh)
    PLAYED=$(wc -l < "$HISTORY_FILE" 2>/dev/null || echo 0)
    if [ "$PLAYED" -ge $((TOTAL - 1)) ]; then
      > "$HISTORY_FILE"
    fi
    # Build list of unplayed files, pick random from those
    UNPLAYED=()
    for f in "${FILES[@]}"; do
      if ! grep -qxF "$f" "$HISTORY_FILE" 2>/dev/null; then
        UNPLAYED+=("$f")
      fi
    done
    # Fallback: if all played, reset
    if [ ${#UNPLAYED[@]} -eq 0 ]; then
      > "$HISTORY_FILE"
      UNPLAYED=("${FILES[@]}")
    fi
    RANDOM_FILE="${UNPLAYED[$RANDOM % ${#UNPLAYED[@]}]}"
    echo "$RANDOM_FILE" >> "$HISTORY_FILE"
    echo "$(date) — PLAYING: $RANDOM_FILE" >> "$LOG"
    afplay "$RANDOM_FILE" &
  fi
else
  echo "$(date) — NO MATCH" >> "$LOG"
fi

exit 0
