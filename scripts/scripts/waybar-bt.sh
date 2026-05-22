#!/bin/sh
if [ -d /sys/class/power_supply/BAT0 ]; then
    CAP=$(cat /sys/class/power_supply/BAT0/capacity)
    STAT=$(cat /sys/class/power_supply/BAT0/status)
    [ "$STAT" = "Charging" ] && ICON="󱐋" || ICON="󰁹"
    echo "$ICON $CAP%"
else
    # FreeBSD: use sysctl and cut
    CAP=$(sysctl -n hw.acpi.battery.life 2>/dev/null)
    [ -n "$CAP" ] && echo "󰁹 $CAP%" || echo ""
fi
