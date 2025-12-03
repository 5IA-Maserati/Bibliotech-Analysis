#!/bin/bash

# ===============================
# General Template Check Script
# ===============================
# This script runs all individual template checks located in check-templates/
# If any script fails, the general script exits with status 1.

# Folder containing all template check scripts
script_folder="check-templates"

# Loop through all .sh scripts in the folder
for script in "$script_folder"/*.sh; do
  # Skip if no scripts exist
  [ -e "$script" ] || continue

  # Make sure the script is executable
  chmod +x "$script"

  # Run the script
  echo "Running template check: $script"
  bash "$script"

  # If the script fails, exit immediately
  if [ $? -ne 0 ]; then
    echo "ERROR: Template check failed in $script"
    exit 1
  fi
done

echo "All template checks passed!"