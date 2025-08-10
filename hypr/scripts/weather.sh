#!/bin/bash

CACHE_FILE="/tmp/weather_cache"
LOCK_FILE="/tmp/weather_cache.lock"
UPDATE_INTERVAL=600

# Always return something ASAP
if [[ -f "$CACHE_FILE" ]]; then
  CACHE_CONTENT=$(cat "$CACHE_FILE")
  echo "$CACHE_CONTENT"

  # Check staleness or if the cache contains "unknown"
  if [[ $(($(date +%s) - $(stat -c %Y "$CACHE_FILE"))) -ge $UPDATE_INTERVAL || "$CACHE_CONTENT" == *"Unknown"* ]]; then
    (
      exec 200>"$LOCK_FILE"
      flock -n 200 || exit 0

      {
        NEW_DATA=$(curl -s 'wttr.in?format=%c+%C+%t')
        [[ -n "$NEW_DATA" ]] && echo "$NEW_DATA" > "$CACHE_FILE"
      } &
    )
  fi
else
  # No cache file: fetch synchronously
  NEW_DATA=$(curl -s 'wttr.in?format=%c+%C+%t')
  echo "$NEW_DATA"
  (
    exec 200>"$LOCK_FILE"
    flock -n 200 || exit 0
    [[ -n "$NEW_DATA" ]] && echo "$NEW_DATA" > "$CACHE_FILE"
  ) &
fi
