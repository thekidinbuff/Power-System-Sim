# Power-System-Simulator
# Power System Simulator
Simulates electrical power loads with realistic noise, containerized for OCI deployment.

## Features
- Dynamic power simulation using Bash and Python.
- JSON output with overload alerts.
- Dockerized: `us-ashburn-1.ocir.io/idbgc80c49pc/power-sim:latest`.

## Run Locally
```bash
docker run --rm -v $(pwd)/output:/app/output power-sim:latest
