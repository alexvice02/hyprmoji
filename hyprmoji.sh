#!/usr/bin/env bash

emoji_list=(
  "😀 Smile"
  "😂 Laugh"
  "🥺 Pleading"
  "🔥 Fire"
  "👍 Thumbs Up"
  "💻 Computer"
)

ROFI_CMD=(rofi -dmenu -p "Pick an emoji:")
WAIT_CLOSE=0.03

read -r PREV_ADDR PREV_WS <<<"$(hyprctl activewindow -j \
                                | jq -r '.address, .workspace.id')"

PREV_ADDR=${PREV_ADDR:-""}
PREV_WS=${PREV_WS:-""}


chosen=$(printf '%s\n' "${emoji_list[@]}" | "${ROFI_CMD[@]}")
emoji=$(awk '{print $1}' <<<"$chosen")
[[ -z $emoji ]] && exit 0
while hyprctl clients -j \
        | jq -e '.[] | select(.class=="rofi" or .class=="Rofi")' >/dev/null
do
  sleep "$WAIT_CLOSE"
done

if [[ -n $PREV_WS ]]; then
  hyprctl dispatch workspace "$PREV_WS" 2>/dev/null || true
fi

printf '%s' "$emoji" | wl-copy

ydotool key -d 10 29:1 47:1 47:0 29:0