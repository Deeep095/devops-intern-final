#!/bin/bash
echo "Starting system information bash script..."
# set -euo pipefail

echo "Current user: $(whoami)"
echo "Current date: $(date)"
echo "Disk usage:"
df -h

