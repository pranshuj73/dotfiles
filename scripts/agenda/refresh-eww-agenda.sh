#!/bin/bash

agenda_output=$("/home/volty/.scripts/agenda/cal.sh" update)
escaped=$(printf '%s' "$agenda_output" | sed -e 's/\\/\\\\/g' -e 's/"/\\"/g')

eww update cal_agenda="$escaped"

notify-send "EWW Agenda Updated" "The EWW agenda has been refreshed with the latest data."
