#!/usr/bin/env bash
# ~/wallpaper

CONFIG_DIR="$HOME/.config"
COLORS_DIR="$CONFIG_DIR/elg/colours.txt"
WALLPAPER_DIR="$CONFIG_DIR/elg/wallpapers"
BLURPAPER_DIR="$WALLPAPER_DIR/.blurred"
SMALLPAPER_DIR="$WALLPAPER_DIR/.small"
HYPRPAPER_CONF="$CONFIG_DIR/hypr/hyprpaper.conf"

# Determine image size
cols=$(tput cols)
lines=$(tput lines)
preview_cols=$((cols * 6 - 48))
preview_lines=$((lines - 2))

export cols lines preview_cols preview_lines

# Pick a wallpaper
chosen=$(find "$WALLPAPER_DIR" \
  -type d \( -name ".small" -o -name ".blurred" \) -prune -o \
  -type f \( -iname '*.jpg' -o -iname '*.png' -o -iname '*.jpeg' \) -print |
  fzf --preview "
kitty +kitten icat --transfer-mode=stream --use-window-size $((cols / 2)),$((lines / 2)),$preview_cols,$preview_lines --clear {} 2>/dev/null
" --preview-window=right:60%)
filename="${chosen#"$WALLPAPER_DIR/"}"
subdir="${filename%/*}"
basename="${filename##*/}"

[ -z "$chosen" ] && exit 0 # Exit if nothing selected

# copy wallpaper to sddm
cp "$chosen" /usr/share/sddm/themes/elgsddm/backgrounds/current_wallpaper.jpg

# Write new config for hyprpaper
cat >"$HYPRPAPER_CONF" <<EOF
wallpaper {
    monitor = DP-1
    path    = $chosen 
    fit_mode = cover   # optional
}

wallpaper {
    monitor = HDMI-A-1
    path    = $chosen 
    fit_mode = cover   # optional
}

# Misc options
ipc = true
splash = false
EOF

echo "$chosen" >"$CONFIG_DIR/elg/cache/current_wallpaper"
echo "* { current-image: url($chosen, height); }" >"$CONFIG_DIR/elg/cache/current_wallpaper.rasi"
echo "Chose wallpaper $filename at $chosen"
echo "Applying wallpaper"

if [ ! -e "$SMALLPAPER_DIR/$subdir/small_$basename" ]; then
  mkdir -p "$SMALLPAPER_DIR/$subdir"
  echo "Generating small version"
  magick "$chosen" \
    -resize 1280x720\> \
    -quality 85 \
    "$SMALLPAPER_DIR/$subdir/small_$basename"
fi
cp "$SMALLPAPER_DIR/$subdir/small_$basename" "$CONFIG_DIR/elg/cache/small_wallpaper.jpg"

if [ ! -e "$BLURPAPER_DIR/$subdir/blurred_$basename" ]; then
  mkdir -p "$BLURPAPER_DIR/$subdir"
  echo "Generating blurred version"
  magick "$chosen" -resize 640x360\> -gaussian-blur 0x8 "$BLURPAPER_DIR/$subdir/blurred_$basename"
fi
cp "$BLURPAPER_DIR/$subdir/blurred_$basename" "$CONFIG_DIR/elg/cache/blurred_wallpaper.jpg"

mapfile -t colors < <(
  magick "$chosen" -resize 100x100 -colors 6 -unique-colors txt:- |
    grep -o '#[0-9A-Fa-f]\{6\}'
)

# pad with last color until 6
while [ "${#colors[@]}" -lt 6 ]; do
  colors+=("${colors[-1]}")
done

printf "%s\n" "${colors[@]}" >"$COLORS_DIR"

# Create individual color blocks
i=0
for color in $(cat "$CONFIG_DIR/elg/colours.txt"); do
  magick -size 100x100 xc:"$color" "$CONFIG_DIR/elg/block_$i.png"
  i=$((i + 1))
done

# Combine them horizontally
magick montage "$CONFIG_DIR"/elg/block_*.png -tile 6x1 -geometry +0+0 "$CONFIG_DIR/elg/palette.png"

# Clean up blocks
rm "$CONFIG_DIR/elg/block_*.png"

magick "$chosen" -resize 100x100 -colors 6 -unique-colors txt:- |
  grep -o '#[0-9A-Fa-f]\{6\}' |
  awk '{
    hex=$0;
    r=strtonum("0x" substr(hex,2,2));
    g=strtonum("0x" substr(hex,4,2));
    b=strtonum("0x" substr(hex,6,2));
    1# Full opacity
    printf " @define-color color%d rgba(%d,%d,%d,1.0);\n", NR, r, g, b;
    # Half opacity
    printf " @define-color color%dl rgba(%d,%d,%d,0.5);\n", NR, r, g, b;
}' | tee "$CONFIG_DIR/waybar/themes/elg/default/style.css" "$CONFIG_DIR/swaync/colors.css"
echo "@import '../style.css';" >>"$CONFIG_DIR/waybar/themes/elg/default/style.css"

# Set new colors
INPUT="$COLORS_DIR"
OUTPUT="$CONFIG_DIR/hypr/colors.conf"
OUTPUT_LUA="$CONFIG_DIR/hypr/colors.lua"

cat >"$OUTPUT_LUA" <<EOF
local colors = {
EOF

# read all hex values into an array, stripping '#'
mapfile -t colors < <(grep -Eo '#?[0-9A-Fa-f]{6}' "$INPUT" | tr -d '#')

# write colors in Hyprland format
for i in "${!colors[@]}"; do
  index=$((i + 1))
  echo "\$color$index = rgba(${colors[$i]}FF)" >>"$OUTPUT"
  echo "  color$index = \"rgba(${colors[$i]}FF)\"," >>"$OUTPUT_LUA"
done

cat >>"$OUTPUT_LUA" <<EOF
}

return colors
EOF

# Rofi
OUTPUT_ROFI="$CONFIG_DIR/rofi/colors.rasi"
echo "* {" >"$OUTPUT_ROFI"

# Extract all hex colors into an array
mapfile -t colors < <(grep -o '#[0-9A-Fa-f]\{6\}' "$COLORS_DIR")

# Generate the RGBA lines
awk -v n="${#colors[@]}" '
BEGIN {
    split("", color)
}
{
    color[NR] = $0
}
END {
    for (i = 1; i <= n; i++) {
        hex = color[i]
        sub(/^#/, "", hex)
        r = strtonum("0x" substr(hex, 1, 2))
        g = strtonum("0x" substr(hex, 3, 2))
        b = strtonum("0x" substr(hex, 5, 2))
        printf "    color%d: rgba(%d,%d,%d,1.0);\n", i, r, g, b
        printf "    color%dl: rgba(%d,%d,%d,0.75);\n", i, r, g, b
    }
}' < <(printf "%s\n" "${colors[@]}") >>"$OUTPUT_ROFI"

echo "}" >>"$OUTPUT_ROFI"

# Reload swaync
pkill swaync
nohup swaync &

# Reload hyprland
hyprctl reload

# Reload hyprpaper
pkill hyprpaper
nohup hyprpaper >/dev/null 2>&1 &

# Reload waybar
sh "$CONFIG_DIR/waybar/launch.sh"

notify-send "Wallpaper changed" "$(basename "$chosen")"
echo "Wallpaper changed"

if gum confirm "Do you want to update sddm?"; then
  echo
  echo "Updating sddm wallpaper"

  # copy wallpaper to sddm
  sudo cp "$chosen" /usr/share/sddm/themes/elgsddm/backgrounds/current_wallpaper.jpg

  echo
  echo "Updated sddm"
elif [ $? -eq 130 ]; then
  exit 130
else
  echo
  echo "All done!"
  exit
fi
