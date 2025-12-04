#!/bin/bash

# ===============================
# General Template Check for Markdown Files
# ===============================
# This script checks that required headers are present in Markdown files
# It decides the headers to check based on the folder
# Only checks files passed as arguments
# Reports all errors, exit code 1 if any header is missing

if [ "$#" -eq 0 ]; then
  echo "No files provided. Exiting."
  exit 0
fi

errors=0

for file in "$@"; do
  # Skip non-markdown files
  [[ "$file" != *.md ]] && continue

  # Determine required headers based on folder
  case "$file" in
    feasibility/*)
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
      ;;
    research/interviews/*)
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
      ;;
    requirements/*)
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
      ;;
    research/surveys/*)
      required_headers=(
        "## Survey ID"
        "## Survey Title"
        "## Objective"
        "## Target Audience"
        "## Survey Questions"
        "## Notes / Instructions"
        "## Expected Outcome"
      )
      ;;
    *)
      # Skip unknown folders
      continue
      ;;
  esac

  # Check headers
  for header in "${required_headers[@]}"; do
    if ! grep -q "$header" "$file"; then
      echo "ERROR: $file is missing required header: $header"
      errors=$((errors + 1))
    fi
  done
done

if [ $errors -ne 0 ]; then
  echo "$errors error(s) found."
  exit 1
else
  echo "All checked files passed header checks!"
fi