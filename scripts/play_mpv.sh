#!/usr/bin/env bash
set -x

if [ -z "$1" ]; then
FILE_NAME=$(find -L ./ -type f | sed -n 's/\(.mkv$\)/\1/p'  | rofi -dmenu -async-pre-read -p "📁 - Pick a file to play" -fullscreen -font "monospace 20")
else
FILE_NAME=$1
fi
if [ -z "$FILE_NAME" ]; then
	echo "No file chosen!"
	exit
fi

BASE_FILE=$(basename "$1")
BASE_FILE="${BASE_FILE%.*}"
NUM_SUBS=$(find ./ -iname "*.srt"  | grep "$BASE_FILE" | wc -l)

if [ $NUM_SUBS -eq 0 ]; then 
    #SUB_LANG=$(curl https://www.opensubtitles.org/addons/export_languages.php 2>&- | sed -n -r 's/^([a-z]{3})[[:space:]]+([[:lower:]]{2}[[:space:]]+)?([[:upper:]].*)[[:space:]]+[0-1][[:space:]]+[0-1][[:space:]]*$/(\1)\t\3/gp' | sed  -r 's/[[:space:]]*$//' | rofi -dmenu -i -fullscreen -font "monospace 20" -p "🔤 - Pick a language" | sed -n -r 's/^.*\(([a-z]{3})\).*$/\1/p')
    #SUB_LANG=$(printf "heb\neng" | rofi -dmenu -p "🔤 - Pick a language" -fullscreen -font "monospace 20")
    SUB_LANG=heb,eng
    if [ -z "$SUB_LANG" ]; then
	    echo "No language chosen!"
	    exit
    fi
    #echo Language $SUB_LANG
    #echo Watching $FILE_NAME

    SUB_FILE=$(subdl --download=none --lang=$SUB_LANG "$FILE_NAME" | grep ".srt" | rofi -dmenu -matching fuzzy -i -p "🎥 - Pick a substitle file" -fullscreen -font "monospace 20")
    echo "Picked subtitle file: $SUB_FILE"
    if [ -z "$SUB_FILE" ]; then
	    echo "No subtitle chosen!"
	    exit
    fi
    SUB_ID=$(echo $SUB_FILE | sed -n 's/^#\([0-9]\+\) .*$/\1/p')
    echo "Sub ID: $SUB_ID"
    subdl --download=$SUB_ID --existing=abort --lang $SUB_LANG --output="{m}.{L}.{I}.{S}" "$FILE_NAME" 
fi

NUM_SUBS=$(find ./ -iname "*.srt"  | grep "$BASE_FILE" | wc -l)
if [ $NUM_SUBS -eq 1 ]; then
    SUB_FILENAME=$(find ./ -iname "*.srt"  | grep "$BASE_FILE")
elif [ $NUM_SUBS -gt 1 ]; then
    SUB_FILENAME=$(find ./ -iname "*.srt"  | grep "$BASE_FILE" | rofi -dmenu -p "Pick a file" -fullscreen -font "monospace 20") 
else
    echo "No subtitles found! Or Download failed!"
fi

if [ -z "$SUB_FILENAME" ]; then
    echo "Error, no subtitle filename received!"
    exit
fi
echo "Actual subfile name: $SUB_FILENAME"
mpv "$FILE_NAME" --sub-file "$SUB_FILENAME"
