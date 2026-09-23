#!/bin/sh

node="$(bspc query -N -n focused.window)"
[ -n "$node" ] || exit 0

extract_monitor_rectangle() {
    printf '%s' "$1" | tr -d '\n' | sed -n 's/.*"rectangle":{"x":\([-0-9]\+\),"y":\([-0-9]\+\),"width":\([-0-9]\+\),"height":\([-0-9]\+\)}.*/\1 \2 \3 \4/p'
}

extract_floating_rectangle() {
    printf '%s' "$1" | tr -d '\n' | sed -n 's/.*"floatingRectangle":{"x":\([-0-9]\+\),"y":\([-0-9]\+\),"width":\([-0-9]\+\),"height":\([-0-9]\+\)}.*/\1 \2 \3 \4/p'
}

if bspc query -N -n "${node}.floating.sticky.private" >/dev/null 2>&1; then
    bspc node "$node" -g sticky=off
    bspc node "$node" -g private=off
    bspc node "$node" -t tiled
    exit 0
fi

target_w=400
target_h=225
margin_x=20
margin_y=20

bspc node "$node" -t floating
bspc node "$node" -g sticky=on
bspc node "$node" -g private=on

node_tree="$(bspc query -T -n "$node" 2>/dev/null)"
monitor_tree="$(bspc query -T -m focused 2>/dev/null)"

set -- $(extract_floating_rectangle "$node_tree")
node_x="$1"
node_y="$2"
node_w="$3"
node_h="$4"

set -- $(extract_monitor_rectangle "$monitor_tree")
mon_x="$1"
mon_y="$2"
mon_w="$3"
mon_h="$4"

[ -n "$node_w" ] || exit 0
[ -n "$mon_w" ] || exit 0

resize_dx=$((target_w - node_w))
resize_dy=$((target_h - node_h))
bspc node "$node" -z bottom_right "$resize_dx" "$resize_dy"

node_tree="$(bspc query -T -n "$node" 2>/dev/null)"
set -- $(extract_floating_rectangle "$node_tree")
node_x="$1"
node_y="$2"
node_w="$3"
node_h="$4"

dest_x=$((mon_x + mon_w - node_w - margin_x))
dest_y=$((mon_y + mon_h - node_h - margin_y))

[ "$dest_x" -lt "$mon_x" ] && dest_x="$mon_x"
[ "$dest_y" -lt "$mon_y" ] && dest_y="$mon_y"

move_dx=$((dest_x - node_x))
move_dy=$((dest_y - node_y))
bspc node "$node" -v "$move_dx" "$move_dy"
