#!/bin/bash

# ===============================
# Automatic Template Check for Feasibility Reports
# ===============================
# This script checks that all required headers are present in feasibility Markdown files
# Exit code 1 if any header is missing

# List of required headers
required_headers=(
  "## Study ID"
  "## Objective"
  "## Proposed Solution"
  "## Technical Feasibility"
  "## Economic Feasibility"
  "## Operational Feasibility"
  "## Risks"
  "## Recommendations / Next Steps"
  "## Version / Revision"
)

# Folder containing feasibility files
folder="feasibility"

# Loop through all .md files in the folder
for file in "$folder"/*.md; do
  [ -e "$file" ] || continue  # Skip if no files

  for header in "${required_headers[@]}"; do
    if ! grep -q "$header" "$file"; then
      echo "ERROR: $file is missing required header: $header"
      exit 1
    fi
  done
done

echo "All feasibility files passed header checks!"