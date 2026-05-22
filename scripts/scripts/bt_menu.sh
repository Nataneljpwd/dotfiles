#!/bin/zsh
source $HOME/scripts/bemenu_theme.sh

# Get list of devices
DEVICES=$(bluetoothctl devices | cut -d ' ' -f 2-)
POWER_STATE=$(bluetoothctl show | grep "Powered" | awk '{print $2}')

# Add Toggle and Scan options to the top
CHOICE=$(echo -e "Power Toggle (Current: $POWER_STATE)\nScan for Devices\n$DEVICES" | bemenu $BEMENU_OPTS -p "Bluetooth:")

if [[ "$CHOICE" == Power* ]]; then
    [ "$POWER_STATE" = "yes" ] && bluetoothctl power off || bluetoothctl power on
elif [[ "$CHOICE" == "Scan for Devices" ]]; then
    notify-send "Bluetooth" "Scanning..."
    bluetoothctl --timeout 10 scan on
elif [ ! -z "$CHOICE" ]; then
    MAC=$(echo "$CHOICE" | awk '{print $1}')
    # Submenu for the specific device
    ACTION=$(echo -e "Connect\nDisconnect\nPair\nTrust\nRemove" | bemenu $BEMENU_OPTS -p "$CHOICE:")
    case "$ACTION" in
        Connect) bluetoothctl connect "$MAC" ;;
        Disconnect) bluetoothctl disconnect "$MAC" ;;
        Pair) bluetoothctl pair "$MAC" ;;
        Trust) bluetoothctl trust "$MAC" ;;
        Remove) bluetoothctl remove "$MAC" ;;
    esac
fi
