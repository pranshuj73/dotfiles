#!/usr/bin/env bash
STATE_FILE="/tmp/caffeine_mode"
DATE=$(date "+%Y-%m-%d — %H:%M")

if [ -f "$STATE_FILE" ]; then
    echo "%{F#6ad1fc}$DATE%{F-}"
else
    echo "$DATE"
fi
