#!/bin/zsh

OS=$(uname)

if [ "$OS" = "Linux" ]; then
    # Gentoo / Linux Logic
    SSID=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)
    ETH=$(nmcli device show | grep 'IP4.ADDRESS' -B 3 | grep 'ethernet' | head -n 1)
    
    if [ ! -z "$SSID" ]; then
        echo "{\"text\": \"  $SSID\", \"class\": \"wifi\"}"
    elif [ ! -z "$ETH" ]; then
        echo "{\"text\": \"󰈀  Wired\", \"class\": \"ethernet\"}"
    else
        echo "{\"text\": \"󰖪  Offline\", \"class\": \"disconnected\"}"
    fi

elif [ "$OS" = "FreeBSD" ]; then
    # FreeBSD Logic
    WLAN_INT=$(ifconfig | grep -B 3 "groups: wlan" | head -n 1 | cut -d: -f1)
    SSID=$(wpa_cli -i "$WLAN_INT" status | grep "^ssid=" | cut -d= -f2)
    ETH_CHECK=$(ifconfig -u | grep -E "em0|re0|igb0" | grep "status: active")

    if [ ! -z "$SSID" ]; then
        echo "{\"text\": \"  $SSID\", \"class\": \"wifi\"}"
    elif [ ! -z "$ETH_CHECK" ]; then
        echo "{\"text\": \"󰈀  Wired\", \"class\": \"ethernet\"}"
    else
        echo "{\"text\": \"󰖪  Offline\", \"class\": \"disconnected\"}"
    fi
fi
