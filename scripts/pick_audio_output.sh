#!/usr/bin/env zsh
if [ 1 -eq $(pactl list cards short | wc -l ) ]; then
	CARD=$(pactl list cards short | awk '{print $2}')
else
	CARD=$(pactl list cards short | awk '{print $2}' | rofi -dmenu -mesg 'Pick a soung card:')
fi

if [ -z "${CARD}" ]; then echo "No card found!"; exit; fi

PROFILE=$(pactl list cards | sed -n "/Name: $CARD/,/^Card #/p" | sed -n -r '/^[[:space:]]+output:/p'   | grep -v input | sed -r -e 's/^[[:space:]]+output://g' -e 's/:/:\t/' | nl -w 2 | rofi -dmenu -sidebar-mode -mesg 'Pick an output profile: ' | sed -r -n 's/^[[:space:]]*[0-9]+[[:space:]]*([^:]+):.*$/\1/p')
if [ -z "${PROFILE}" ]; then echo "No profile selected! exiting..." ; exit; fi

PROFILE=output:${PROFILE}

pactl set-card-profile $CARD $PROFILE
