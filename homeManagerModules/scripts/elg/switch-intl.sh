#!/usr/bin/env bash

CONFIG="$HOME/.config/hypr/conf/keyboard.conf"
KEY="kb_variant"
VALUE="intl"

# Check if kb_variant is set to intl
if grep -q "^\s*${KEY}\s*=\s*${VALUE}" "$CONFIG"; then
  # Turn it off (empty value)
  sed -i "s/^\(\s*${KEY}\s*=\s*\)${VALUE}/\1/" "$CONFIG"
  notify-send "Keyboard intl" "intl disabled"
else
  # Turn it on
  sed -i "s/^\(\s*${KEY}\s*=\s*\)$/\1${VALUE}/" "$CONFIG"
  notify-send "Keyboard intl" "intl enabled"
fi
