#!/bin/bash

# THIS IS MACOS SPECIFIC

# Check if the script is run with superuser privileges
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root. Use sudo to run the script."
   exit 1
fi

# Check if the ntfs-3g is installed
if ! command -v ntfs-3g &> /dev/null
then
    echo "ntfs-3g could not be found. Please install ntfs-3g."
    exit
fi

# Set the volume name from the argument or default to 'NTFS'
ntfsVolName=${1:-NTFS}

# Create the mount directory
sudo mkdir -p /Volumes/$ntfsVolName
if [ $? -ne 0 ]; then
    echo "Failed to create directory /Volumes/$ntfsVolName"
    exit 1
fi

# List all disk utilities
diskutil list

# Ask for the current location of the NTFS volume
read -p "Enter the current location for the mounted NTFS volume (e.g., disk2s1): " ntfsVolLocation

# Unmount the NTFS volume
sudo umount /dev/$ntfsVolLocation
if [ $? -ne 0 ]; then
    echo "Warning: /dev/$ntfsVolLocation might already be unmounted or failed to unmount. Continuing..."
fi

# Remount the NTFS volume using ntfs-3g
sudo ntfs-3g /dev/$ntfsVolLocation /Volumes/$ntfsVolName -olocal -oallow_other
if [ $? -ne 0 ]; then
    echo "Failed to remount /dev/$ntfsVolLocation at /Volumes/$ntfsVolName"
    exit 1
fi

echo "Successfully remounted /dev/$ntfsVolLocation at /Volumes/$ntfsVolName"
