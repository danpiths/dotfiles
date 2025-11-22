#!/bin/bash

# THIS IS MACOS SPECIFIC

# Check if the script is run with superuser privileges
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root. Use sudo to run the script."
   exit 1
fi

# List all disk utilities
diskutil list

# Ask for the current location of the NTFS volume
read -p "Enter the current location for the mounted NTFS volume (e.g., disk2s1): " ntfsVolLocation

# Unmount the NTFS volume
sudo umount /dev/$ntfsVolLocation
if [ $? -ne 0 ]; then
    echo "Failed to unmount /dev/$ntfsVolLocation"
    exit 1
fi

echo "Successfully unmounted /dev/$ntfsVolLocation"
