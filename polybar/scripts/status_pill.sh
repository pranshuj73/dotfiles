#!/usr/bin/env sh

battery_pct() {
  for b in /sys/class/power_supply/BAT*; do
    [ -r "$b/capacity" ] || continue
    cat "$b/capacity"
    return 0
  done
  echo "n/a"
}

battery_state() {
  for b in /sys/class/power_supply/BAT*; do
    [ -r "$b/status" ] || continue
    cat "$b/status"
    return 0
  done
  echo "Unknown"
}

volume_pct() {
  if command -v wpctl >/dev/null 2>&1; then
    vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null | awk '{v=$2*100; printf("%.0f", v)}')
    [ -n "$vol" ] && echo "$vol" || echo "0"
    return
  fi
  echo "0"
}

volume_muted() {
  if command -v wpctl >/dev/null 2>&1; then
    wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null | grep -q "\\[MUTED\\]"
    return $?
  fi
  return 1
}

wifi_name() {
  if command -v iwgetid >/dev/null 2>&1; then
    ssid=$(iwgetid -r 2>/dev/null)
    [ -n "$ssid" ] && echo "$ssid" && return
  fi
  if command -v nmcli >/dev/null 2>&1; then
    ssid=$(nmcli -t -f active,ssid dev wifi 2>/dev/null | awk -F: '$1=="yes" {print $2; exit}')
    [ -n "$ssid" ] && echo "$ssid" && return
  fi
  echo "off"
}

bt_state() {
  if ! command -v bluetoothctl >/dev/null 2>&1; then
    echo ""
    return
  fi
  if bluetoothctl show 2>/dev/null | grep -q "Powered: yes"; then
    if bluetoothctl info 2>/dev/null | grep -q "Connected: yes"; then
      echo "on"
    else
      echo ""
    fi
  else
    echo ""
  fi
}

bat=$(battery_pct)
state=$(battery_state)
vol=$(volume_pct)
bt=$(bt_state)
wifi=$(wifi_name)

bat_icon=""
if [ "$bat" != "n/a" ]; then
  if [ "$bat" -le 10 ]; then bat_icon=""
  elif [ "$bat" -le 25 ]; then bat_icon=""
  elif [ "$bat" -le 50 ]; then bat_icon=""
  elif [ "$bat" -le 80 ]; then bat_icon=""
  else bat_icon=""
  fi
fi

if [ "$state" = "Charging" ]; then
  step=$(( $(date +%s) % 5 ))
  case "$step" in
    0) bat_icon="";;
    1) bat_icon="";;
    2) bat_icon="";;
    3) bat_icon="";;
    4) bat_icon="";;
  esac
fi

case "$state" in
  Charging) bat_label="${bat_icon} ${bat}%+";;
  Full) bat_label="${bat_icon} ${bat}%";;
  Discharging) bat_label="${bat_icon} ${bat}%";;
  *) bat_label="${bat_icon} ${bat}%";;
esac

vol_icon=""
if volume_muted; then
  vol_icon=""
else
  if [ "$vol" -le 30 ]; then vol_icon=""
  elif [ "$vol" -le 60 ]; then vol_icon=""
  else vol_icon=""
  fi
fi

parts="$bat_label  ${vol_icon} ${vol}%"
if [ -n "$bt" ]; then
  parts="$parts   ${bt}"
fi
parts="$parts   ${wifi}"

printf "%s" "$parts"
