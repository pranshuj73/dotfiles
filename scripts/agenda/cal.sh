#!/bin/bash

CACHE_FILE="/tmp/gcal_agenda"
SCRIPT_PATH="$HOME/.scripts/agenda/cal.py"
VENV_PATH="$HOME/.scripts/agenda/venv"
MAX_AGE=$((12 * 60 * 60))      # 12 hours
UPDATE_COOLDOWN=$((5 * 60))    # 5 minutes

mode="$1"  # can be empty or "update"

should_refresh=true

if [[ -f "$CACHE_FILE" ]]; then
    file_age=$(( $(date +%s) - $(stat -c %Y "$CACHE_FILE") ))
    line_count=$(wc -l < "$CACHE_FILE")

    if [[ "$mode" == "update" ]]; then
        # If cache is fresh (<5min) AND multi-line, skip refresh
        if [[ $file_age -lt $UPDATE_COOLDOWN && $line_count -gt 1 ]]; then
            should_refresh=false
        fi
    else
        # Normal mode, refresh only if older than 12 hours
        if [[ $file_age -lt $MAX_AGE ]]; then
            should_refresh=false
        fi
    fi
fi

if $should_refresh; then
    source "$VENV_PATH/bin/activate"
    python "$SCRIPT_PATH" | tee "$CACHE_FILE"
    deactivate
else
    cat "$CACHE_FILE"
fi
