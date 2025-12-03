#!/bin/bash

# ===============================
# Automatic Template Check for Interview Reports
# ===============================
# This script checks that all required headers are present in interview Markdown files
# Exit code 1 if any header is missing

# List of required headers for Interview template
required_headers=(
  "## Interview ID"
  "## Objective"
  "## Participant"
  "## Date"
  "## Interview Questions"
  "## Notes / Observations"
  "## Key Insights"
  "## Follow-up Actions"
)

# Folder containing interview files
folder="research/interviews"

# Loop through all .md files in the folder
for file in "$folder"/*.md; do
  # Skip if no files exist
  [ -e "$file" ] || continue

  # Check each required header
  for header in "${required_headers[@]}"; do
    if ! grep -q "$header" "$file"; then
      echo "ERROR: $file is missing required header: $header"
      exit 1
    fi
  done
done

echo "All interview files passed header checks!"
