#!/usr/bin/env sh

# Simple weather summary (requires curl)
if ! command -v curl >/dev/null 2>&1; then
  echo "weather n/a"
  exit 0
fi

out=$(curl -sf "wttr.in/?format=1" 2>/dev/null)
if [ -n "$out" ]; then
  echo "  $out"
else
  echo "weather n/a"
fi
