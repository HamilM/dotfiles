#!/usr/bin/env bash

if ! pkill -0 mpd; then
    pkill -0 dunst && notify-send "MPD is not running!"
    exit -1
fi


INDEX=$(mpc playlist | rofi -i -dmenu -format 'i')
[ -z "$INDEX" ] && exit -1
INDEX=$(($INDEX + 1))
mpc play "$INDEX"
