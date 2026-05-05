#!/bin/bash

set -euo pipefail

if ! command -v git >/dev/null 2>&1; then
  echo "git could not be found. Please install git."
  exit 1
fi

if ! command -v gum >/dev/null 2>&1; then
  echo "gum could not be found. Please install gum."
  exit 1
fi

if ! command -v gt >/dev/null 2>&1; then
  echo "gt could not be found. Please install Graphite CLI."
  exit 1
fi

current_branch="$(git branch --show-current)"

if [[ -z "$current_branch" ]]; then
  echo "Could not determine the current branch. Are you in a Git repository on a branch?"
  exit 1
fi

branch_body="$current_branch"
conventional_prefixes=(
  feat
  fix
  chore
  docs
  refactor
  test
  ci
  build
  perf
  style
  release
  revert
  hotfix
  bugfix
)

for prefix in "${conventional_prefixes[@]}"; do
  if [[ "$branch_body" == "$prefix/"* ]]; then
    branch_body="${branch_body#"$prefix/"}"
    break
  fi
done

if [[ -z "$branch_body" ]]; then
  echo "Branch name body is empty after removing the existing convention prefix."
  exit 1
fi

options=()
for prefix in "${conventional_prefixes[@]}"; do
  options+=("$prefix/$branch_body")
done

gum style \
  --border normal \
  --padding "1 2" \
  --margin "1 0" \
  "Current branch: $current_branch" \
  "Preview format: <type>/$branch_body"

new_branch="$(printf '%s\n' "${options[@]}" | gum filter \
  --height 12 \
  --header "Select the new branch name" \
  --placeholder "Fuzzy search branch convention..." \
  --fuzzy \
  --limit 1)"

if [[ -z "$new_branch" ]]; then
  echo "No branch name selected."
  exit 1
fi

if [[ "$new_branch" == "$current_branch" ]]; then
  echo "Branch is already named $new_branch."
  exit 0
fi

FOREGROUND="$COLOR_ACCENT" gum style "Renaming $current_branch -> $new_branch"
gt rename "$new_branch"
