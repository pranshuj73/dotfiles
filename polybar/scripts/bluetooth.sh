#!/usr/bin/env sh

# Bluetooth status (requires bluetoothctl)
if ! command -v bluetoothctl >/dev/null 2>&1; then
  echo "bt n/a"
  exit 0
fi

if bluetoothctl show 2>/dev/null | grep -q "Powered: yes"; then
  if bluetoothctl info 2>/dev/null | grep -q "Connected: yes"; then
    echo "bt on"
  else
    echo "bt"
  fi
else
  echo "bt off"
fi
