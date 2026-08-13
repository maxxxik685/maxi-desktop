#!/bin/bash

# Read GPU power consumption from nvidia-smi
POWER=$(nvidia-smi --query-gpu=power.draw --format=csv,noheader,nounits 2>/dev/null)

[ -z "$POWER" ] && POWER="N/A"

printf '{"text": "󰢮", "alt": "%sW", "tooltip": "GPU Power: %sW"}\n' \
  "$POWER" "$POWER"
