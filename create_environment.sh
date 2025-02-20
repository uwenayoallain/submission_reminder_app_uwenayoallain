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
    
    # Create config.env file
    cat > "$base_dir/config/config.env" << 'EOFENV'
#!/bin/bash

# Environment variables for the reminder application
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=3
EOFENV
    
    # Create functions.sh file
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
    
    echo "Created submissions.txt, config.env, and functions.sh files."
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
echo "=== Functions Setup Complete ==="
