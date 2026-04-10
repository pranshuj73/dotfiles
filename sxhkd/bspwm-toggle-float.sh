#!/bin/sh

node="$(bspc query -N -n focused.window)"
[ -n "$node" ] || exit 0

if bspc query -N -n "${node}.floating" >/dev/null 2>&1; then
    bspc node "$node" -t tiled
else
    bspc node "$node" -t floating
fi
