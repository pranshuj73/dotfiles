#!/usr/bin/env bash

DIR="$HOME/.config/polybar"

# Ask running bars to quit cleanly (don't block if IPC is stuck)
timeout 1s polybar-msg cmd quit >/dev/null 2>&1 || true

# Ensure all instances are gone
pkill -x polybar >/dev/null 2>&1
pkill -x polybar-msg >/dev/null 2>&1

# Wait briefly for shutdown (timeout 2s)
for _ in {1..20}; do
  pgrep -u "$UID" -x polybar >/dev/null || break
  sleep 0.1
done

# Launch the bar
polybar -q main -c "$DIR"/config.ini &
