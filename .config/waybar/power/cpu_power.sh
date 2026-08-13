#!/bin/bash

# Read CPU power consumption
# Try multiple methods to get accurate CPU power

# Method 1: Intel RAPL (most accurate)
if [ -f /sys/class/powercap/intel-rapl:0/energy_uj ]; then
    # Read current energy value
    ENERGY_NOW=$(cat /sys/class/powercap/intel-rapl:0/energy_uj 2>/dev/null)
    
    # Read energy value from 1 second ago
    sleep 0.1
    ENERGY_AFTER=$(cat /sys/class/powercap/intel-rapl:0/energy_uj 2>/dev/null)
    
    if [ -n "$ENERGY_NOW" ] && [ -n "$ENERGY_AFTER" ]; then
        # Calculate power (energy difference over time)
        # energy_uj is in microjoules, so difference / 1000000 = joules
        # Power = joules / time (0.1 seconds)
        DIFF=$((ENERGY_AFTER - ENERGY_NOW))
        if [ "$DIFF" -ge 0 ]; then
            # Convert to watts (approximate)
            POWER=$((DIFF * 10 / 1000000))
            printf '{"text": "󰻠", "alt": "%sW", "tooltip": "CPU Power: %sW"}\n' "$POWER" "$POWER"
            exit 0
        fi
    fi
fi

# Method 2: AMD RAPL
if [ -f /sys/class/powercap/intel-rapl:0/energy_uj ]; then
    POWER=$(cat /sys/class/powercap/intel-rapl:0/energy_uj 2>/dev/null)
    POWER=$((POWER / 1000000))
    printf '{"text": "󰻠", "alt": "%sW", "tooltip": "CPU Power: %sW"}\n' "$POWER" "$POWER"
    exit 0
fi

# Method 3: Try turbostat
if command -v turbostat &> /dev/null; then
    POWER=$(turbostat --quiet --show PkgWatt --num_iterations 1 2>/dev/null | tail -1 | awk '{print $1}')
    if [ -n "$POWER" ] && [ "$POWER" != "0.00" ]; then
        printf '{"text": "󰻠", "alt": "%sW", "tooltip": "CPU Power: %sW"}\n' "$POWER" "$POWER"
        exit 0
    fi
fi

# Method 4: Try sensors
if command -v sensors &> /dev/null; then
    POWER=$(sensors 2>/dev/null | grep -i "power" | grep -i "package" | head -1 | awk '{print $NF}' | sed 's/W//')
    if [ -n "$POWER" ] && [ "$POWER" != "N/A" ]; then
        printf '{"text": "󰻠", "alt": "%sW", "tooltip": "CPU Power: %sW"}\n' "$POWER" "$POWER"
        exit 0
    fi
fi

# If all methods fail
printf '{"text": "󰻠", "alt": "N/A", "tooltip": "CPU Power: N/A"}\n'
