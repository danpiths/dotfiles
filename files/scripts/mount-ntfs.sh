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

# Check if the ntfs-3g is installed
if ! command -v ntfs-3g >/dev/null 2>&1; then
    FOREGROUND="$COLOR_ERROR" gum style "ntfs-3g could not be found. Please install ntfs-3g."
    exit 1
fi

ntfsVolName="${1:-}"
if [[ -z "$ntfsVolName" ]]; then
    ntfsVolName="$(gum input \
        --header "NTFS volume name" \
        --placeholder "NTFS" \
        --value "NTFS")"
fi

if [[ -z "$ntfsVolName" ]]; then
    FOREGROUND="$COLOR_ERROR" gum style "Volume name cannot be empty."
    exit 1
fi

gum style \
    --border normal \
    --padding "1 2" \
    --margin "1 0" \
    "Mount point preview: /Volumes/$ntfsVolName"

# Create the mount directory
if ! sudo mkdir -p "/Volumes/$ntfsVolName"; then
    FOREGROUND="$COLOR_ERROR" gum style "Failed to create directory /Volumes/$ntfsVolName"
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
    FOREGROUND="$COLOR_WARNING" gum style "Warning: /dev/$ntfsVolLocation might already be unmounted or failed to unmount. Continuing..."
fi

# Remount the NTFS volume using ntfs-3g
if ! sudo ntfs-3g "/dev/$ntfsVolLocation" "/Volumes/$ntfsVolName" -olocal -oallow_other; then
    FOREGROUND="$COLOR_ERROR" gum style "Failed to remount /dev/$ntfsVolLocation at /Volumes/$ntfsVolName"
    exit 1
fi

FOREGROUND="$COLOR_SUCCESS" gum style "Successfully remounted /dev/$ntfsVolLocation at /Volumes/$ntfsVolName"
