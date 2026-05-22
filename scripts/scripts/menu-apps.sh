#!/usr/bin/env bash
source ~/.config/scripts/bemenu_opts.sh

OS=$(uname)
[[ "$OS" == "Linux" ]] && APP_DIR="/usr/share/applications" || APP_DIR="/usr/local/share/applications"
TERM_CMD="kitty" # Change to your preferred terminal

# 1. Generate clean list, excluding unwanted "junk" apps
# Add any words you want to hide to the 'grep -v' section
list=$(grep -h "^Name=" $APP_DIR/*.desktop | sed 's/Name=//g' | \
      grep -vE "Java|OpenJDK|Server|Policy|Console|Profile" | sort -u)

selected=$(echo -e "$list" | bemenu $BEMENU_OPTS)

if [ -n "$selected" ]; then
    # Find the desktop file for the selected name
    file=$(grep -l "Name=$selected" $APP_DIR/*.desktop | head -n 1)
    
    # Extract Exec command
    cmd=$(grep "^Exec=" "$file" | head -1 | sed 's/Exec=//g' | sed 's/%.//g')
    
    # Check if the app requires a terminal
    is_term=$(grep "^Terminal=true" "$file")

    if [ -z "$is_term" ]; then
        swaymsg exec "$cmd"
    else
        # If it's a terminal app (like Neovim), wrap it in your terminal
        swaymsg exec "$TERM_CMD -e $cmd"
    fi
fi
