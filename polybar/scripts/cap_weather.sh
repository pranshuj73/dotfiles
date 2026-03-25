#!/usr/bin/env sh

WTTR_URL="wttr.in?format=%i"
CACHE_FILE="/tmp/weather_code_cache"
LOCK_FILE="/tmp/weather_code_cache.lock"
UPDATE_INTERVAL=600

get_code() {
  if [ -f "$CACHE_FILE" ]; then
    code=$(cat "$CACHE_FILE")
    if [ -n "$code" ]; then
      echo "$code"
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

bg_for_code() {
  code="$1"
  hour=$(date +%H)
  if [ "$hour" -ge 6 ] && [ "$hour" -lt 12 ]; then
    base="#80f5d56a"
  elif [ "$hour" -ge 12 ] && [ "$hour" -lt 18 ]; then
    base="#80f0a34a"
  else
    base="#8063a8ff"
  fi

  case "$code" in
    119|122) echo "#808b8b8b";;
    143|248|260) echo "#806e7f8a";;
    176|293|296|299|302|305|308|353|356|359|263|266) echo "#805a8cff";;
    179|182|317|320|362|365) echo "#8079a7ff";;
    185|281|284|311|314) echo "#805a7bd9";;
    200|386|389) echo "#80f2d35b";;
    227|230|323|326|329|332|335|338|368|371|392|395) echo "#80b5d8ff";;
    350) echo "#80a0b9d9";;
    *) echo "$base";;
  esac
}

code=$(get_code | tr -cd '0-9')
[ -n "$code" ] || code=0
bg=$(bg_for_code "$code")

printf "%%{F%s}%%{F-}" "$bg"
