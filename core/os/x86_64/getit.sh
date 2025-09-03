#!/bin/bash

# URL of the Arch Linux core repo index
INDEX_URL="https://mirrors.edge.kernel.org/archlinux/core/os/x86_64/"

# Get the list of files from the index page, omit .sig files
curl -s "$INDEX_URL" | grep -oP '(?<=href=")[^"]+' | grep -v '\.sig$' | while read -r filename; do
    # Skip directories
    if [[ "$filename" =~ /$ ]]; then
        continue
    fi

    # Check if file already exists locally
    if [ -f "$filename" ]; then
        echo "File '$filename' already exists. Skipping."
    else
        echo "Downloading '$filename'..."
        wget "${INDEX_URL}${filename}"
    fi
done
