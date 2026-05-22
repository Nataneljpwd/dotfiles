#!/bin/sh

# FONT: Increased to 18 for high visibility in the center
FONT='MesloLGS NF 18'

# COLORS: Deep Midnight Theme
BG='#11111b'      # Background
FG='#cdd6f4'      # Text
ACCENT='#89b4fa'  # Blue Accent
CURSOR='#f38ba8'  # Pinkish/Red Prompt

# FLAGS EXPLAINED:
# -c            : Centers the menu on the screen
# -H 45         : Line height (makes it feel "roomy")
# -W 0.35       : Width factor (35% of the screen width)
# -l 10         : Shows 10 items in a vertical list
# -p ' '       : Search icon prompt
# --m 0         : Monitor 0 (ensure it's on primary)
# --border-size : Adds a subtle border around the box
export BEMENU_BACKEND="wayland"

export BEMENU_OPTS="
  -c 
  -l 10 
  -W 0.35 
  -H 45 
  --fn '$FONT' 
  --border-size 2 
  --border-radius 15 
  --inner-pad 20 
  --ignorecase 
  -p ' ' 
  --nb '$BG' --nf '$FG' 
  --hb '$BG' --hf '$ACCENT' 
  --fb '$BG' --ff '$FG' 
  --cb '$BG' --cf '$CURSOR' 
  --sb '$BG' --sf '$ACCENT' 
  --ab '$BG' --af '$FG' 
  --tb '$BG' --tf '$CURSOR'
"
