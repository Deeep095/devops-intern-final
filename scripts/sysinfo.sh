#!/bin/bash
set -euo pipefail

echo "Starting system information bash script..."

echo "Current user: $(whoami)"
echo "Current date: $(date)"
echo "Disk usage:"
df -h

