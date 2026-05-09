#!/usr/bin/env bash
STATE_FILE="/tmp/caffeine_mode"

if [ -f "$STATE_FILE" ]; then
    rm -f "$STATE_FILE"
    xset s on
    xset +dpms
else
    touch "$STATE_FILE"
    xset s off
    xset -dpms
fi
