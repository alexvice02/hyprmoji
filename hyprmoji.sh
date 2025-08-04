emoji_list=(
    "😀 Smile"
    "😂 Laugh"
    "🥺 Pleading"
    "🔥 Fire"
    "👍 Thumbs Up"
    "💻 Computer"
)

tmpfile=$(mktemp)

for emoji in "${emoji_list[@]}"; do
    echo "$emoji" >> "$tmpfile"
done

chosen=$(cat "$tmpfile" | rofi -dmenu -p "Pick an emoji:")

emoji=$(echo "$chosen" | awk '{print $1}')


echo -n "$emoji" | wl-copy

rm "$tmpfile"