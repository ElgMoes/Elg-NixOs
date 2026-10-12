#!/usr/bin/env bash

# Options
OPTIONS=" Sleep
 Logout
 Reboot
 Shutdown"

# Ask user with rofi
CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -i -p "Power Menu:" -theme ~/.config/rofi/config-powermenu.rasi)

case "$CHOICE" in
" Sleep")
  systemctl suspend
  ;;
" Logout")
  hyprctl dispatch 'hl.dsp.exit()'
  ;;
" Reboot")
  systemctl reboot
  ;;
" Shutdown")
  systemctl poweroff
  ;;
esac
