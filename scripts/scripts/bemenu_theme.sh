#!/bin/zsh

# Force backend and renderer priority
export BEMENU_BACKEND="wayland"
export BEMENU_RENDERER_PRIORITY="wayland"

# Path to renderers (Gentoo Musl uses /usr/lib, FreeBSD uses /usr/local/lib)
if [ -d "/usr/local/lib/bemenu" ]; then
    export BEMENU_RENDER_PATH="/usr/local/lib/bemenu"
else
    export BEMENU_RENDER_PATH="/usr/lib/bemenu"
fi

# Tokyo Night Dark Theme
NB='#1a1b26' # Background
NF='#c0caf5' # Foreground
HB='#33467c' # Highlight BG
HF='#7aa2f7' # Highlight FG
TF='#7aa2f7' # Prompt FG

# Store flags in a simple string for maximum shell compatibility
# -c: Center, -l 15: vertical lines, -W 0.3: Width
export BEMENU_FLAGS="-c -l 15 -W 0.3 -i --fn 'MesloLGS NF 16' --nb $NB --nf $NF --hb $HB --hf $HF --tf $TF --fb $NB --ff $TF --ab $NB --af $NF --bdr $HF --border 2"
