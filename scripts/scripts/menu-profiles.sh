#!/bin/bash
source ~/.config/scripts/bemenu_opts.sh
mode=$(echo -e "󰗚 Learning\n󰲒 Development" | bemenu $BEMENU_OPTS -p "Mode:")
if [[ "$mode" == *"Learning"* ]]; then
    proj=$(ls -1 "$HOME/learning" | bemenu $BEMENU_OPTS)
    [[ -n "$proj" ]] && (swaymsg "workspace 1; exec firefox -P '$proj'"; swaymsg "workspace 2; exec rnote")
else
    list=$(for d in "$HOME/projects"/*/; do n=$(basename "$d"); b=$(git -C "$d" rev-parse --abbrev-ref HEAD 2>/dev/null || echo "no-git"); echo "$n [$b]"; done)
    sel=$(echo -e "$list" | bemenu $BEMENU_OPTS); name=$(echo "$sel" | awk '{print $1}')
    [[ -n "$name" ]] && (swaymsg "workspace 3; exec kitty --directory $HOME/projects/$name"; swaymsg "workspace 4; exec firefox -P '$name' 'google.com/search?q=$name'")
fi
