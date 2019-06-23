#!/bin/zsh
xrdb ~/.Xresources
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
source ~/.profile
wal -i ~/.config/i3/wallpaper.jpg -a 60
compton -b
pkill -0 dunst || dunst &
xset dmps $((60*5))
exec i3
