#!/usr/bin/env bash
if ! pkill -0 mpd; then
    pkill -0 dunst && notify-send "MPD is not running!"
    exit -1
fi
FILE=$(mpc listall | rofi -i -dmenu)
[ -z "$FILE" ] && exit -1
mpc add "$FILE"
