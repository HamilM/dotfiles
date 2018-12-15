#!/usr/bin/env bash
pushd .
cd $(dirname ${BASH_SOURCE[0]})
cat ./noto_emoji_map.txt | python ./rofi_emojis.py | cut -f 1 -d ':' | xclip -selection clipboard
popd
