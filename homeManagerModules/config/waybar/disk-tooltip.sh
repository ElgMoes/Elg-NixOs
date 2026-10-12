#!/usr/bin/env bash

get_usage_info() {
    mount_point=$1
    info=$(df -BG --output=size,used,target "$mount_point" | tail -n1)
    total=$(echo $info | awk '{print $1}' | sed 's/G//')
    used=$(echo $info | awk '{print $2}' | sed 's/G//')
    mount=$(echo $info | awk '{print $3}')
    percent=$(awk "BEGIN {printf \"%.0f\", ($used / $total) * 100}")
    echo "$used GiB used out of $total GiB on $mount ($percent%)"
}

ROOT_INFO=$(get_usage_info "/")
HOME_INFO=$(get_usage_info "/home")

# Extract percentage from root info for bar
PERCENT_ROOT=$(echo "$ROOT_INFO" | grep -oP '\(\K[0-9]+(?=%\))')

if (( $PERCENT_ROOT < 65 )); then
  class="green"
elif (( $PERCENT_ROOT < 90 )); then
  class="yellow"
else
  class="red"
fi

echo -n "{\"text\": \" $PERCENT_ROOT%\", \"tooltip\": \"$ROOT_INFO\n$HOME_INFO\", \"class\": \"$class\"}"
