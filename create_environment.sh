#!/bin/env bash
# Submission Reminder App Environment Setup Script

# Function to create the required directory structure
create_directories() {
    local base_dir="$1"
    echo "Creating directory structure in '$base_dir'..."
    for dir in assets config modules app; do
        mkdir -p "$base_dir/$dir"
    done
    echo "Directory structure created successfully!"
}

# Function to create and populate application files
create_files() {
    local base_dir="$1"
    echo "Creating and populating application files..."

    # Create submissions.txt with header and student entries
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

    # Create config.env with environment variables
    cat > "$base_dir/config/config.env" << 'EOFENV'
#!/bin/bash

# Environment variables for the reminder application
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=3
EOFENV

    # Create modules/functions.sh (unchanged from original)
    cat > "$base_dir/modules/functions.sh" << 'EOFFUNC'
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
EOFFUNC

    # Create reminder.sh which displays assignment info and calls check_submissions
    cat > "$base_dir/app/reminder.sh" << 'EOFREM'
#!/bin/bash

# Source environment variables and helper functions
source ../config/config.env
source ../modules/functions.sh

# Path to the submissions file
submissions_file="../assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file
EOFREM

    # Create startup.sh as the entry point for the application
    cat > "$base_dir/startup.sh" << 'EOFSTART'
#!/bin/bash

# Startup script for submission reminder application
echo "Starting Submission Reminder Application..."
echo "===========================================" 

# Verify all components exist
if [ ! -f "./app/reminder.sh" ]; then
    echo "Error: reminder.sh not found in app directory!"
    exit 1
fi

if [ ! -d "./config" ] || [ ! -f "./config/config.env" ]; then
    echo "Error: configuration files not found!"
    exit 1
fi

if [ ! -d "./modules" ] || [ ! -f "./modules/functions.sh" ]; then
    echo "Error: module files not found!"
    exit 1
fi

if [ ! -d "./assets" ] || [ ! -f "./assets/submissions.txt" ]; then
    echo "Error: assets files not found!"
    exit 1
fi

# Make scripts executable if they're not already
chmod +x ./app/reminder.sh
chmod +x ./modules/functions.sh

# Change to app directory and execute the reminder script
cd app
./reminder.sh
cd ..

echo "===========================================" 
echo "Application execution complete."
EOFSTART

    # Set executable permissions on key scripts
    chmod +x "$base_dir/startup.sh" "$base_dir/app/reminder.sh" "$base_dir/modules/functions.sh" "$base_dir/config/config.env"
    echo "Created all application files and set appropriate permissions."
}

echo "=== Submission Reminder App Environment Setup ==="
echo

# Prompt for user's name and sanitize it (removing spaces and special characters)
read -rp "Please enter your name: " user_name
clean_name=$(echo "$user_name" | tr -cd '[:alnum:]_-')

# Define the base directory name
base_directory="submission_reminder_${clean_name}"
echo "Setting up environment in: '$base_directory'"

# Create or overwrite the directory based on user confirmation
if [ -d "$base_directory" ]; then
    read -rp "Directory already exists. Do you want to overwrite it? (y/n): " overwrite
    if [[ "$overwrite" =~ ^[Yy]$ ]]; then
        rm -rf "$base_directory"
        mkdir -p "$base_directory"
    else
        echo "Setup aborted. Please try again with a different name."
        exit 1
    fi
else
    mkdir -p "$base_directory"
fi

# Run setup functions
create_directories "$base_directory"
create_files "$base_directory"

echo
echo "=== Setup Complete ==="
echo "You can now run the application with:"
echo "  cd $base_directory"
echo "  ./startup.sh"
