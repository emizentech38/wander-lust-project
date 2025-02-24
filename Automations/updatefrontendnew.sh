#!/bin/bash

# Retrieve the host machine's local IP address
ipv4_address=$(hostname -I | awk '{print $1}')

# Path to the .env file
file_to_find="../frontend/.env.docker"

# Check if the file exists
if [ ! -f "$file_to_find" ]; then
    echo "ERROR: File not found."
    exit 1
fi

# Check the current VITE_API_PATH value
current_url=$(cat $file_to_find)

# Update the .env file if the IP address has changed
if [[ "$current_url" != "VITE_API_PATH=\"http://${ipv4_address}:31100\"" ]]; then
    sed -i -e "s|VITE_API_PATH.*|VITE_API_PATH=\"http://${ipv4_address}:31100\"|g" "$file_to_find"
    echo "Updated VITE_API_PATH to http://${ipv4_address}:31100"
else
    echo "VITE_API_PATH is already up to date."
fi
