#!/bin/bash

# ===============================
# Automatic Template Check for Requirements
# ===============================
# This script checks that all required headers are present in requirement Markdown files
# Exits with status 1 if any header is missing

# List of required headers for Requirement template
required_headers=(
  "## Requirement ID"
  "## Title"
  "## Description"
  "## Rationale"
  "## Type"
  "## Priority"
  "## Dependencies"
  "## Acceptance Criteria"
  "## Version / Revision"
)

# Folder containing requirement files
folder="requirements"

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

echo "All requirement files passed header checks!"