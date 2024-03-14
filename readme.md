# Git Status Check Script

This script, `git_status_check.sh`, is designed to check the Git status of all subdirectories within a given parent directory. It assumes each subdirectory is a separate Git repository. The script identifies repositories that have uncommitted changes and those that are fully committed.

## Features

- Checks each subdirectory in the given directory to see if it's a Git repository.
- Reports the status of each repository, indicating whether there are uncommitted changes.
- Provides a summary of committed repositories and those that need revisiting.

## Usage

To use the script, follow these steps:

1. Save the script as `git_status_check.sh`.
2. Make the script executable:
    ```bash
    chmod +x git_status_check.sh
    ```
3. Run the script with the parent directory as an argument:
    ```bash
    ./git_status_check.sh /path/to/parent-directory
    ```


## Output

- The script will list each subdirectory it checks, along with its Git status.
- At the end of the script, two lists are printed:
- `Committed Directories`: Directories where all changes are committed.
- `Directories with Uncommitted Changes`: Directories that have uncommitted changes.

## Requirements

- Bash shell
- Git
