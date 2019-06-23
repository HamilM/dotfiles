#!/usr/bin/env bash
set -x
OUTPUT_DIR="~/music"
BROWSER=firefox
for win in $(xdotool search --all --onlyvisible --name "$BROWSER"); do
    xdotool key --window "$win" CTRL+l CTRL+Insert
    url=$(xclip -o | sed -r -n '/youtube.com\/watch?/p')
    [ -n "$url" ] && break
done
if [ -z "$url" ]; then
    pkill -0 dunst && notify-send "No $BROWSER window found with visible youtube tab open!"
    exit
fi
pkill -0 dunst && notify-send "New download starting"
#Xdialog --inputbox "Please type in the youtube url to be downloaded" 100 100 2>$FILE
TITLE=$(youtube-dl --get-title "$url")
youtube-dl --max-downloads 1 -x -i -f 'bestaudio' "$url" -o "$OUTPUT_DIR/%(uploader)s/%(title)s.%(etx)s"

if [ $? -ne 0 ]; then
    notify-send "Failed to download!"
    exit
fi

pkill -0 dunst && notify-send "Song $TITLE downloaded successfully!"
rm $FILE
