#!/bin/bash

TEMP=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits 2>/dev/null)

[ -z "$TEMP" ] && TEMP="0"

# Determine icon based on temperature
if [ "$TEMP" -lt 50 ]; then
    ICON=""  # Cold
elif [ "$TEMP" -lt 75 ]; then
    ICON=""  # Normal
else
    ICON=""  # Hot
fi

printf '{"text": "%s", "alt": "%s°C", "tooltip": "GPU Temperature: %s°C"}\n' \
  "$ICON" "$TEMP" "$TEMP"
