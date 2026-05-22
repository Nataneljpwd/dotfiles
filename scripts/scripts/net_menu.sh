#!/bin/zsh
source $HOME/scripts/bemenu_theme.sh
OS=$(uname)

if [ "$OS" = "Linux" ]; then
    # Gentoo / Linux Logic (NetworkManager)
    TOGGLE=$(echo -e "Toggle WiFi (On/Off)\nScan for Networks" | bemenu $BEMENU_OPTS -p "WiFi Status:")
    
    if [[ "$TOGGLE" == "Toggle WiFi (On/Off)" ]]; then
        STATE=$(nmcli radio wifi)
        [ "$STATE" = "enabled" ] && nmcli radio wifi off || nmcli radio wifi on
        exit
    fi

    # List SSIDs
    STATION=$(nmcli -t -f "SSID,SECURITY,BARS" device wifi list | sed 's/:/  /g' | bemenu $BEMENU_OPTS -p "Select WiFi:")
    SSID=$(echo "$STATION" | awk '{print $1}')
    
    if [ ! -z "$SSID" ]; then
        nmcli device wifi connect "$SSID" --ask
    fi

elif [ "$OS" = "FreeBSD" ]; then
    # FreeBSD Logic (wpa_supplicant)
    INTERFACE=$(route get default | grep interface | awk '{print $2}')
    [ -z "$INTERFACE" ] && INTERFACE="wlan0"
    
    ACTION=$(echo -e "Connect to Known\nScan/Manual Connect\nDisconnect" | bemenu $BEMENU_OPTS -p "FreeBSD Net:")
    
    case "$ACTION" in
        "Connect to Known")
            ID=$(wpa_cli -i $INTERFACE list_networks | tail -n +2 | bemenu $BEMENU_OPTS | awk '{print $1}')
            wpa_cli -i $INTERFACE select_network $ID
            ;;
        "Scan/Manual Connect")
            SSID=$(wpa_cli -i $INTERFACE scan_results | tail -n +3 | awk '{print $5}' | bemenu $BEMENU_OPTS)
            PASS=$(echo "" | bemenu $BEMENU_OPTS -p "Password (leave blank if open):")
            # Minimal logic to add network via wpa_cli
            ID=$(wpa_cli -i $INTERFACE add_network)
            wpa_cli -i $INTERFACE set_network $ID ssid "\"$SSID\""
            wpa_cli -i $INTERFACE set_network $ID psk "\"$PASS\""
            wpa_cli -i $INTERFACE enable_network $ID
            ;;
        "Disconnect")
            wpa_cli -i $INTERFACE disconnect
            ;;
    esac
fi
