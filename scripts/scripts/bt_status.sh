#!/bin/zsh

# Define timeout duration (0.5 seconds is plenty for local controller queries)
T_OUT="timeout 5"

# 1. Check if the controller is powered on
# We redirect stderr to dev/null so timeout/permission errors don't break the JSON
POWER_CHECK=$($T_OUT bluetoothctl show 2>/dev/null | grep "Powered: yes")

if [ -z "$POWER_CHECK" ]; then
    echo "{\"text\": \"󰂲 Off\", \"class\": \"disabled\"}"
    exit 0
fi

# 2. Get info of the currently connected device
# bluetoothctl info without a MAC address usually returns the "selected" (connected) device
DEVICE_INFO=$($T_OUT bluetoothctl info 2>/dev/null)

# If no device is connected, the output will be empty or contain "Missing device address"
if [ -z "$DEVICE_INFO" ] || [[ "$DEVICE_INFO" == *"Missing device address"* ]]; then
    echo "{\"text\": \" Idle\", \"class\": \"on\"}"
else
    # Extract Alias (Name) and Battery
    NAME=$(echo "$DEVICE_INFO" | grep "Alias" | cut -d ' ' -f 2-)
    BATT=$(echo "$DEVICE_INFO" | grep "Battery Percentage" | awk -F '[()]' '{print $2}')

    if [ ! -z "$BATT" ]; then
        echo "{\"text\": \" $NAME $BATT%\", \"class\": \"connected\"}"
    else
        echo "{\"text\": \" $NAME\", \"class\": \"connected\"}"
    fi
fi
