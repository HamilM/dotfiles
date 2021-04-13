ID=$(yabai -m query --windows | jq -c -r '.[] | (.id|tostring) + " - " + .app + " - " + .title' | choose | cut -f 1 -d ' ')
CUR_ID=$(yabai -m query --windows | jq '.[] | select(.focused == 1) | .id')
if [ -z "${CUR_ID}" ]; then
	terminal-notifier -message "Couldn't find a window ID, please select a window"
	exit
fi
yabai -m window "${ID}" --warp "${CUR_ID}"
