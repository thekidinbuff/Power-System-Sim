# Use Ubuntu 22.04 as base image to match VM
FROM ubuntu:22.04

# Install dependencies
RUN apt update && apt install -y python3-pip jq && pip3 install numpy

# Copy scripts into container
COPY power_simulator.sh sim.py /app/

# Set working directory
WORKDIR /app

# Ensure scripts are executable
RUN chmod +x power_simulator.sh sim.py

# Run the simulator
CMD ["./power_simulator.sh"]
