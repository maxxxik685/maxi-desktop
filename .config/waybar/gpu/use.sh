#!/bin/bash

USAGE=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits 2>/dev/null)

[ -z "$USAGE" ] && USAGE="0"

printf '{"text": "󰢮", "alt": "%s%%", "tooltip": "GPU Usage: %s%%"}\n' \
  "$USAGE" "$USAGE"
