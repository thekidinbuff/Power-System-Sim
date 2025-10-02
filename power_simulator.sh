#!/bin/bash

# Configurable parameters (tweak these)
SIM_STEPS=100
VOLTAGE=120
MAX_LOAD=1000
OUTPUT_DIR="/app/output"
OUTPUT_FILE="$OUTPUT_DIR/sim_output.json"
LOG_FILE="$OUTPUT_DIR/sim_log.txt"

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"
if [ $? -ne 0 ]; then
    echo "Error: Failed to create output directory!" >&2
    exit 1
fi

# Ensure sim.py exists
if [ ! -f "sim.py" ]; then
    echo "Error: sim.py not found!" | tee -a "$LOG_FILE"
    exit 1
fi

# Run Python simulator
echo "Running simulation: $SIM_STEPS steps, Voltage=$VOLTAGE V, Max Load=$MAX_LOAD W" | tee -a "$LOG_FILE"
python3 sim.py "$SIM_STEPS" "$VOLTAGE" "$MAX_LOAD" > "$OUTPUT_FILE"

# Check for errors
if [ $? -ne 0 ]; then
    echo "Error: Simulation failed!" | tee -a "$LOG_FILE"
    exit 1
fi

# Parse output for alerts
OVERLOAD_COUNT=$(grep -c "overload" "$OUTPUT_FILE")
if [ "$OVERLOAD_COUNT" -gt 0 ]; then
    echo "ALERT: $OVERLOAD_COUNT overload(s) detected!" | tee -a "$LOG_FILE"
    # Placeholder for email/SMS (we’ll hook to OCI Notifications later)
    # Example: mail -s "Power Sim Alert" your@email.com < "$LOG_FILE"
else
    echo "Simulation complete: No overloads detected." | tee -a "$LOG_FILE"
fi

# Basic report
TOTAL_STEPS=$(jq '.steps' "$OUTPUT_FILE")
echo "Processed $TOTAL_STEPS steps. Output saved to $OUTPUT_FILE" | tee -a "$LOG_FILE"
