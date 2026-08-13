#!/bin/bash

read -r USED TOTAL < <(nvidia-smi --query-gpu=memory.used,memory.total --format=csv,noheader,nounits 2>/dev/null | tr ',' ' ')

if [ -z "$USED" ]; then
    USED=0
    TOTAL=1
fi

PERC=$(( USED * 100 / TOTAL ))

printf '{"text": "󰘚", "alt": "%s%%", "tooltip": "VRAM: %sMB / %sMB (%s%%)"}\n' \
  "$PERC" "$USED" "$TOTAL" "$PERC"
