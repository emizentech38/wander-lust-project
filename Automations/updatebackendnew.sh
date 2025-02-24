#!/bin/bash

# Retrieve the local host machine's IP address
ipv4_address=$(hostname -I | awk '{print $1}')

# Path to the backend .env file
file_to_find="../backend/.env.docker"

# Check if the file exists
if [ ! -f "$file_to_find" ]; then
    echo "ERROR: File not found."
    exit 1
fi

# Get the current FRONTEND_URL value (assuming it's on line 4)
current_url=$(sed -n "4p" "$file_to_find")

# Define the new expected URL
new_url="FRONTEND_URL=\"http://${ipv4_address}:5173\""

# Update the .env file if the IP address has changed
if [[ "$current_url" != "$new_url" ]]; then
    sed -i -e "s|FRONTEND_URL.*|$new_url|g" "$file_to_find"
    echo "Updated FRONTEND_URL to $new_url"
else
    echo "FRONTEND_URL is already up to date."
fi
