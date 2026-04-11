#!/usr/bin/env bash

DIR="$HOME/.config/polybar"

# Terminate already running bar instances
pkill -9 polybar 2>/dev/null || true

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch the bar
polybar -q -r main -c "$DIR"/config.ini &
