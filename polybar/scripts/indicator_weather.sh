#!/usr/bin/env sh

WTTR_URL="wttr.in?format=%i"

# Fetch code (cached in /tmp to avoid frequent hits)
CACHE_FILE="/tmp/weather_code_cache"
LOCK_FILE="/tmp/weather_code_cache.lock"
UPDATE_INTERVAL=600

get_code() {
  if [ -f "$CACHE_FILE" ]; then
    code=$(cat "$CACHE_FILE")
    if [ -n "$code" ]; then
      echo "$code"
      # refresh async if stale
      if [ $(( $(date +%s) - $(stat -c %Y "$CACHE_FILE"))) -ge $UPDATE_INTERVAL ]; then
        (
          exec 200>"$LOCK_FILE"
          flock -n 200 || exit 0
          curl -s "$WTTR_URL" > "$CACHE_FILE"
        ) &
      fi
      return
    fi
  fi
  code=$(curl -s "$WTTR_URL")
  echo "$code"
  (
    exec 200>"$LOCK_FILE"
    flock -n 200 || exit 0
    [ -n "$code" ] && echo "$code" > "$CACHE_FILE"
  ) &
}

icon_for_code() {
  code="$1"
  hour=$(date +%H)
  case "$code" in
    113) icon="";;
    116) icon="";;
    119|122) icon="";;
    143|248|260) icon="";;
    176|293|296|299|302|305|308|353|356|359|263|266) icon="";;
    179|182|317|320|362|365) icon="";;
    185|281|284|311|314) icon="";;
    200|386|389) icon="";;
    227|230|323|326|329|332|335|338|368|371|392|395) icon="";;
    350) icon="";;
    *) icon="";;
  esac
  if [ "$hour" -lt 6 ] || [ "$hour" -ge 19 ]; then
    case "$code" in
      113) icon="";;
      116) icon="";;
    esac
  fi
  echo "$icon"
}

bg_for_code() {
  code="$1"
  hour=$(date +%H)
  # time-of-day base
  if [ "$hour" -ge 6 ] && [ "$hour" -lt 12 ]; then
    base="#80f5d56a"  # morning yellow
  elif [ "$hour" -ge 12 ] && [ "$hour" -lt 18 ]; then
    base="#80f0a34a"  # afternoon orange
  else
    base="#8063a8ff"  # night blue
  fi

  case "$code" in
    119|122) echo "#808b8b8b";;         # cloudy gray
    143|248|260) echo "#806e7f8a";;      # fog gray-blue
    176|293|296|299|302|305|308|353|356|359|263|266) echo "#805a8cff";; # rain blue
    179|182|317|320|362|365) echo "#8079a7ff";; # sleet blue
    185|281|284|311|314) echo "#805a7bd9";; # freezing rain
    200|386|389) echo "#80f2d35b";;      # thunder yellow
    227|230|323|326|329|332|335|338|368|371|392|395) echo "#80b5d8ff";; # snow blue
    350) echo "#80a0b9d9";;             # ice pellets
    *) echo "$base";;
  esac
}

code=$(get_code | tr -cd '0-9')
[ -n "$code" ] || code=0
icon=$(icon_for_code "$code")
bg=$(bg_for_code "$code")

printf "%%{B%s} %s %%{B-}" "$bg" "$icon"
