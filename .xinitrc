#!/bin/zsh
xrdb ~/.Xresources
source ~/.profile
wal -i ~/.config/i3/wallpaper.jpg -a 60
compton -b
pkill -0 dunst || dunst &
xset dmps $((60*5))
sleep 1
autorandr 
sxhkd &
dwm_status &
exec dwm
#exec i3
