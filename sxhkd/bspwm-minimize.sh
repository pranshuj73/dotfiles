#!/bin/sh

stash_file="${XDG_RUNTIME_DIR:-/tmp}/bspwm-minimized-node"

if [ -r "$stash_file" ]; then
    node="$(cat "$stash_file")"
    if [ -n "$node" ] \
        && bspc query -N -n "$node" >/dev/null 2>&1 \
        && bspc query -N -n "${node}.hidden" >/dev/null 2>&1; then
        bspc node "$node" -g hidden=off
        bspc node "$node" -d focused --follow
        exit 0
    fi
    rm -f "$stash_file"
fi

node="$(bspc query -N -n focused.window)"
[ -n "$node" ] || exit 0

printf '%s\n' "$node" > "$stash_file"
bspc node "$node" -g hidden=on
