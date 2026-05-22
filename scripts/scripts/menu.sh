#!/bin/bash

source "$HOME/scripts/bemenu_theme.sh"

# 1. Define application directories for both OSs
APP_DIRS="/usr/share/applications /usr/local/share/applications"

# 2. Get Application Names (not filenames) from .desktop files
# This extracts 'Name=XXX', removes the 'Name=' part, and filters out CLI tools
APPS=$(grep -rh "^Name=" $APP_DIRS 2>/dev/null | cut -d= -f2- | grep -vEi "nvim|java|server|gcc|clang|url" | sort -u)

# 3. Define non-app entries
PROFILES="study\ndevelopment"
UTILS="network manager\nbluetooth manager (bt)"

# 4. Launch bemenu
SELECTED=$(echo -e "$PROFILES\n$UTILS\n$APPS" | bemenu $BEMENU_OPTS -p "Launcher:")

# 5. Handle Selection
case "$SELECTED" in
    "network manager") 
        exec $HOME/scripts/net_menu.sh ;;
    "bluetooth manager (bt)") 
        exec $HOME/scripts/bt_menu.sh ;;
    "study")
        # List only directories to keep it clean
        SUBJECT=$(ls -d $HOME/learning/*/ 2>/dev/null | xargs -n 1 basename | bemenu $BEMENU_OPTS -p "Course:")
        [ -z "$SUBJECT" ] && exit
        swaymsg "workspace 2; exec rnote $HOME/learning/$SUBJECT"
        swaymsg "workspace 3; exec firefox -P '$SUBJECT'"
        ;;
    "development")
        # List only directories to keep it clean
        PROJECT=$(ls -d $HOME/projects/*/ 2>/dev/null | xargs -n 1 basename | bemenu $BEMENU_OPTS -p "Project:")
        [ -z "$PROJECT" ] && exit
        swaymsg "workspace 1; exec kitty -d $HOME/projects/$PROJECT nvim"
        swaymsg "workspace 4; exec firefox -P '$PROJECT'"
        ;;
    "")
        exit 0
        ;;
    *)
        # 6. Resolve App Name to Exec command
        # Find the file where Name equals the selection, then extract the Exec line
        EXEC_CMD=$(grep -rl "^Name=$SELECTED$" $APP_DIRS 2>/dev/null | xargs grep -m 1 "^Exec=" | cut -d= -f2- | sed 's/%.//g' | head -n 1)
        
        if [ -z "$EXEC_CMD" ]; then
            # Fallback for raw commands
            swaymsg exec "$SELECTED"
        else
            swaymsg exec "$EXEC_CMD"
        fi
        ;;
esac
