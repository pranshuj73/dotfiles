#!/bin/sh

node="$(bspc query -N -n focused.window)"
[ -n "$node" ] || exit 0

if bspc query -N -n "${node}.floating.sticky.private" >/dev/null 2>&1; then
    bspc node "$node" -g sticky=off
    bspc node "$node" -g private=off
    bspc node "$node" -t tiled
    exit 0
fi

bspc node "$node" -t floating
bspc node "$node" -g sticky=on
bspc node "$node" -g private=on
