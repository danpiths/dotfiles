#!/bin/bash

set -euo pipefail

# THIS IS MACOS SPECIFIC

if ! command -v gum >/dev/null 2>&1; then
    echo "gum could not be found. Please install gum."
    exit 1
fi

# Check if the script is run with superuser privileges
if [[ $EUID -ne 0 ]]; then
   FOREGROUND="$COLOR_ERROR" gum style "This script must be run as root. Use sudo to run the script."
   exit 1
fi

# List all disk utilities
diskutil list

# Ask for the current location of the NTFS volume
ntfsVolLocation="$(gum input \
    --header "NTFS device identifier" \
    --placeholder "disk2s1" \
    --prompt "/dev/" \
    --char-limit 32)"

if [[ -z "$ntfsVolLocation" ]]; then
    FOREGROUND="$COLOR_ERROR" gum style "Device identifier cannot be empty."
    exit 1
fi

# Unmount the NTFS volume
if ! sudo umount "/dev/$ntfsVolLocation"; then
    FOREGROUND="$COLOR_ERROR" gum style "Failed to unmount /dev/$ntfsVolLocation"
    exit 1
fi

FOREGROUND="$COLOR_SUCCESS" gum style "Successfully unmounted /dev/$ntfsVolLocation"
