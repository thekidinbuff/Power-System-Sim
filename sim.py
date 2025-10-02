#/usr/bin/env python3
import sys
import json
import numpy as np

# Inputs from command line
steps = int(sys.argv[1])  # Number of time steps
voltage = float(sys.argv[2])  # Voltage
max_load = float(sys.argv[3])  # Max power threshold

# Simulate current with noise
np.random.seed(42)  # Consistent results for testing
time = np.arange(steps)
current = np.random.normal(5, 1, steps)  # Normal distance for current
power = voltage * current  # Ohm’s Law: P = V * I

# Flag overloads
alerts = ["overload" if p > max_load else "normal" for p in power]

# Output
output = {
    "steps": steps,
    "time": time.tolist(),
    "voltage": voltage,
    "current": current.tolist(),
    "power": power.tolist(),
    "alerts": alerts
}

# Print JSON
print(json.dumps(output, indent=2))
