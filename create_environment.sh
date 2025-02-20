#!/bin/bash

# Script to set up the submission reminder application environment

# Function to create directories
create_directories() {
    local base_dir=$1
    
    echo "Creating directory structure..."
    # Create main directories
    mkdir -p "$base_dir/assets"
    mkdir -p "$base_dir/config"
    mkdir -p "$base_dir/modules"
    
    echo "Directory structure created successfully!"
}

# Implement file creation function
create_files() {
    local base_dir=$1
    
    echo "Creating and populating files..."
    
    # Create submissions.txt with header and existing entries plus 5 more students
    cat > "$base_dir/assets/submissions.txt" << 'EOFTXT'
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
John, Shell Navigation, not submitted
Sarah, Git Basics, submitted
Michael, Shell Scripting, not submitted
Emma, Shell Navigation, not submitted
David, Shell Basics, submitted
Olivia, Git, not submitted
EOFTXT
    
    echo "Created submissions.txt file with additional students."
}

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

# Create the directory structure
create_directories "$base_directory"

# Create files
create_files "$base_directory"

echo
echo "=== Initial Setup Complete ==="
