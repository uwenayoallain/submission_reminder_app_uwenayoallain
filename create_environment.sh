#!/bin/bash

# Script to set up the submission reminder application environment

echo "=== Submission Reminder App Environment Setup ==="
echo

# Ask for name
read -p "Please enter your name: " user_name

# Remove spaces and special characters from name
clean_name=$(echo "$user_name" | tr -cd '[:alnum:]_-')

# Create the main directory
base_directory="submission_reminder_${clean_name}"

echo "Setting up environment in: $base_directory"

# Create the directory if it doesn't exist
if [ -d "$base_directory" ]; then
    read -p "Directory already exists. Do you want to overwrite it? (y/n): " overwrite
    if [ "$overwrite" = "y" ] || [ "$overwrite" = "Y" ]; then
        rm -rf "$base_directory"
        mkdir -p "$base_directory"
    else
        echo "Setup aborted. Please try again with a different name."
        exit 1
    fi
else
    mkdir -p "$base_directory"
fi

echo "Base directory created successfully!"
