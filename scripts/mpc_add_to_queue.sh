#!/usr/bin/env bash
FILE=$(mpc listall | rofi -i -dmenu)
[ -z "$FILE" ] && exit -1
mpc add "$FILE"
