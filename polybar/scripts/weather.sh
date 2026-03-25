#!/usr/bin/env bash

CACHE_FILE="/tmp/weather_cache"
LOCK_FILE="/tmp/weather_cache.lock"
UPDATE_INTERVAL=600
WTTR_URL="wttr.in?format=%i|%t"

icon_for_code() {
  local code="$1"
  local hour icon
  hour=$(date +%H)
  case "$code" in
    113) icon="";; # Clear/Sunny
    116) icon="";; # Partly cloudy
    119|122) icon="";; # Cloudy/Overcast
    143|248|260) icon="";; # Mist/Fog/Freezing fog
    176|293|296|299|302|305|308|353|356|359|263|266) icon="";; # Rain/Drizzle/Showers
    179|182|317|320|362|365) icon="";; # Sleet
    185|281|284|311|314) icon="";; # Freezing rain/drizzle
    200|386|389) icon="";; # Thunder rain
    227|230|323|326|329|332|335|338|368|371|392|395) icon="";; # Snow
    350) icon="";; # Ice pellets
    *) icon="";;
  esac
  # Night variants for clear/partly
  if [[ "$hour" -lt 6 || "$hour" -ge 19 ]]; then
    case "$code" in
      113) icon="";;
      116) icon="";;
    esac
  fi
  echo "$icon"
}

output_from_cache() {
  local cached="$1"
  local code temp icon
  code="${cached%%|*}"
  temp="${cached#*|}"
  code=$(echo "$code" | tr -cd '0-9')
  icon=$(icon_for_code "$code")
  echo "${icon}  ${temp}"
}

# Always return something ASAP
if [[ -f "$CACHE_FILE" ]]; then
  CACHE_CONTENT=$(cat "$CACHE_FILE")
  if [[ "$CACHE_CONTENT" != *"|"* || "$CACHE_CONTENT" != *[0-9]* ]]; then
    CACHE_CONTENT=""
  else
    output_from_cache "$CACHE_CONTENT"
  fi

  # Check staleness or if the cache contains "Unknown"
  if [[ -z "$CACHE_CONTENT" || $(($(date +%s) - $(stat -c %Y "$CACHE_FILE"))) -ge $UPDATE_INTERVAL || "$CACHE_CONTENT" == Unknown* ]]; then
    (
      exec 200>"$LOCK_FILE"
      flock -n 200 || exit 0

      {
        NEW_DATA=$(curl -s "$WTTR_URL")
        [[ -n "$NEW_DATA" && "$NEW_DATA" == *"|"* ]] && echo "$NEW_DATA" > "$CACHE_FILE"
      } &
    )
  fi
else
  # No cache file: fetch synchronously
  NEW_DATA=$(curl -s "$WTTR_URL")
  if [[ -n "$NEW_DATA" && "$NEW_DATA" == *"|"* ]]; then
    output_from_cache "$NEW_DATA"
  else
    output_from_cache "Unknown|"
  fi
  (
    exec 200>"$LOCK_FILE"
    flock -n 200 || exit 0
    [[ -n "$NEW_DATA" && "$NEW_DATA" == *"|"* ]] && echo "$NEW_DATA" > "$CACHE_FILE"
  ) &
fi
