#!/usr/bin/env bash
killall waybar
pkill waybar
sleep 0.5

# -----------------------------------------------------
# Set theme
# -----------------------------------------------------
themestyle="/elg;/elg/default"

IFS=';' read -ra arrThemes <<<"$themestyle"
echo ":: Theme: ${arrThemes[0]}"

# Check if theme exists, else take default theme
if [ ! -f ~/.config/waybar/themes${arrThemes[1]}/style.css ]; then
    themestyle="/default;/default"
fi

# -----------------------------------------------------
# Loading the configuration
# -----------------------------------------------------
config_file="config"
style_file="style.css"

# -----------------------------------------------------
# Starting waybar
# -----------------------------------------------------
nohup waybar -c ~/.config/waybar/themes${arrThemes[0]}/$config_file -s ~/.config/waybar/themes${arrThemes[1]}/$style_file &
