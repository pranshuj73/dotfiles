#!/bin/bash

MAGIC="special:magic"

HAS_WINDOW=$(hyprctl clients -j | jq '[.[] | select(.workspace.name=="'"$MAGIC"'")] | length')

if [ "$HAS_WINDOW" -eq 0 ]; then
    # stash: move focused window into magic (silent)
    hyprctl dispatch movetoworkspacesilent $MAGIC
else
    # restore: grab window in magic
    WIN=$(hyprctl clients -j | jq -r '.[] | select(.workspace.name=="'"$MAGIC"'") | .address' | head -n1)
    ACTIVE_WS=$(hyprctl activeworkspace -j | jq -r .id)

    # silently move back, then explicitly focus
    hyprctl dispatch movetoworkspacesilent "$ACTIVE_WS,address:$WIN"
    hyprctl dispatch focuswindow address:$WIN
fi

