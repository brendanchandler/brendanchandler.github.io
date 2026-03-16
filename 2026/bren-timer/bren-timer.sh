#!/usr/bin/env bash
# timer - sleep until a specific time, then show a zenity dialog
#
# Usage: timer HH:MM [message]
#   HH:MM    target time (24-hour format)
#   message  optional custom message to display

set -euo pipefail

if [[ $# -lt 1 ]]; then
    echo "Usage: $0 HH:MM [message]" >&2
    exit 1
fi

TARGET_TIME="$1"
CUSTOM_MSG="${2:-}"

# Compute seconds until target time
TARGET_EPOCH=$(date -d "$TARGET_TIME" +%s)
NOW_EPOCH=$(date +%s)
SLEEP_SECS=$(( TARGET_EPOCH - NOW_EPOCH ))

if [[ $SLEEP_SECS -le 0 ]]; then
    echo "Error: '$TARGET_TIME' is in the past (or now)." >&2
    exit 1
fi

# Human-readable duration
fmt_duration() {
    local secs=$1
    local h=$(( secs / 3600 ))
    local m=$(( (secs % 3600) / 60 ))
    local s=$(( secs % 60 ))
    if   [[ $h -gt 0 ]]; then printf "%dh %dm %ds" $h $m $s
    elif [[ $m -gt 0 ]]; then printf "%dm %ds" $m $s
    else                       printf "%ds" $s
    fi
}

DURATION=$(fmt_duration "$SLEEP_SECS")

echo "Timer set for $TARGET_TIME (sleeping ${DURATION})..."
sleep "$SLEEP_SECS"

# Build the dialog message
DIALOG_MSG="Time is up! (timer was for ${DURATION})"
if [[ -n "$CUSTOM_MSG" ]]; then
    DIALOG_MSG="${CUSTOM_MSG}

Timer was for ${DURATION} (until ${TARGET_TIME})."
fi

zenity --warning \
    --title="Timer" \
    --text="$DIALOG_MSG" \
    --width=300
