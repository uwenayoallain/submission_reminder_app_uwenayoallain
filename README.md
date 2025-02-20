# Submission Reminder Application | Learning Project

This application helps track and send reminders for student assignment submissions.

## Setup Instructions

1. **Clone the repository**
   ```bash
   git clone https://github.com/uwenayoallain/submission_reminder_app_uwenayoallain.git
   cd submission_reminder_app_uwenayoallain
   ```

2. **Run the environment setup script**
   ```bash
   chmod +x create_environment.sh
   ./create_environment.sh
   ```
   
   When prompted, enter your name. The script will create a directory called `submission_reminder_yourname` with all necessary files.

3. **Navigate to the application directory**
   ```bash
   cd submission_reminder_yourname
   ```

4. **Run the application**
   ```bash
   ./startup.sh
   ```

## Application Structure

```
submission_reminder_yourname/
├── app/
│   └── reminder.sh          # Main reminder script
├── assets/
│   └── submissions.txt      # Student submission records
├── config/
│   └── config.env           # Environment variables
├── modules/
│   └── functions.sh         # Helper functions
└── startup.sh               # Application startup script
```

## How It Works

1. The `startup.sh` script verifies all components exist and launches the application
2. The application sources configuration from `config.env`
3. It reads student submission records from `assets/submissions.txt`
4. It uses helper functions from `modules/functions.sh` to process the data
5. It checks which students haven't submitted the specified assignment
6. It generates reminders for students who haven't submitted

## Customizing the Application

- To change the target assignment, edit the `ASSIGNMENT` variable in `config/config.env`
- To modify the deadline, change the `DAYS_REMAINING` variable in `config/config.env`
- To add more students, edit the `assets/submissions.txt` file following the format:
  ```
  student, assignment, submission status
  ```

## Troubleshooting

If you encounter any issues:
1. Make sure all scripts have executable permissions (`chmod +x script.sh`)
2. Verify that the file paths in `app/reminder.sh` are correct
3. Check that the `submissions.txt` file follows the correct format
