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
PERCENT_ROOT=$(echo "$ROOT_INFO" | grep -oP '\(\K[0-9]+(?=%\))')

disk=$PERCENT_ROOT

critical="green"

if (( disk >= 90 )); then
    critical="red"
elif (( disk >= 65 )); then
    critical="yellow"
fi

echo "{\"text\":\"\",\"class\":\"${critical}\"}"
