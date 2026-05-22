#!/bin/sh
if [ "$(uname)" = "Linux" ]; then
    ssid=$(nmcli -t -f ACTIVE,SSID dev wifi | grep '^yes' | cut -d: -f2)
    [ -n "$ssid" ] && echo "  $ssid" || echo "󰈀 Wired"
else
    # FreeBSD: Assumes wlan0 for WiFi
    ssid=$(ifconfig wlan0 | grep 'ssid' | awk '{print $2}')
    [ -n "$ssid" ] && echo "  $ssid" || echo "󰈀 Wired"
fi
