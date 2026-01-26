#!/usr/bin/env bash

battery=$(upower -e | grep BAT)
level=$(upower -i "$battery" | awk '/percentage:/ {gsub(/%/,""); print $2}')
state=$(upower -i "$battery" | awk '/state:/ {print $2}')

if [[ "$state" == "discharging" && "$level" -lt 100 ]]; then
    hyprctl dispatch exec "wezterm start --always-new-process  --class BatteryPopup -- bash -c \"\
        echo '###############################################'; \
        echo '##              LOW BATTERY ALERT            ##'; \
        echo '###############################################'; \
        echo; \
        echo 'Battery level: ${level}%'; \
        echo 'Plug in your charger.'; \
        echo; \
        read -n 1 -s -r -p 'Press any key to dismiss...'\""
fi

