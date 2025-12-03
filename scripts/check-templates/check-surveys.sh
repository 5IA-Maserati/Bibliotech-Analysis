#!/bin/bash

# ===============================
# Automatic Template Check for Survey Reports
# ===============================
# This script checks that all required headers are present in survey Markdown files
# Exits with status 1 if any header is missing

# List of required headers for Survey template
required_headers=(
  "## Survey ID"
  "## Survey Title"
  "## Objective"
  "## Target Audience"
  "## Survey Questions"
  "## Notes / Instructions"
  "## Expected Outcome"
)

# Folder containing survey files
folder="research/surveys"

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

echo "All survey files passed header checks!"