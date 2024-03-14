#!/bin/bash

# Function to log messages with different levels
log_message() {
    local level=$1
    local message=$2
    case "$level" in
    INFO) echo "[INFO] $message" ;;
    WARN) echo "[WARN] $message" ;;
    ERROR) echo "[ERROR] $message" ;;
    *) echo "[UNKNOWN] $message" ;;
    esac
}

# Check if a directory argument is provided
if [ "$#" -ne 1 ]; then
    log_message ERROR "Usage: $0 <directory>"
    exit 1
fi

# The directory to check, provided as an argument
PARENT_DIR=$1

# Check if the provided directory exists
if [ ! -d "$PARENT_DIR" ]; then
    log_message ERROR "Directory not found: $PARENT_DIR"
    exit 1
fi

# Arrays to keep track of committed and uncommitted directories
committed_dirs=()
uncommitted_dirs=()

# Loop through each subdirectory in the provided directory
for d in "$PARENT_DIR"/*; do
    if [ -d "$d" ]; then
        # Change to the directory
        cd "$d"

        # Check if it's a Git repository
        if [ -d ".git" ]; then
            log_message INFO "Checking Git status in $d..."

            # Check the git status
            if git diff-index --quiet HEAD --; then
                # No changes
                log_message INFO "Everything is committed in $d."
                committed_dirs+=("$d")
            else
                # Uncommitted changes
                log_message WARN "Uncommitted changes in $d."
                uncommitted_dirs+=("$d")
            fi
        else
            log_message WARN "$d is not a Git repository."
        fi

        # Go back to the parent directory
        cd ..
    fi
done

echo
echo '----------------------------------------'
echo
echo "Git Status Check Complete."

# Print the lists of committed and uncommitted directories
echo "Committed Directories:"
for d in "${committed_dirs[@]}"; do
    echo " - $d"
done

echo "Directories with Uncommitted Changes:"
for d in "${uncommitted_dirs[@]}"; do
    echo " - $d"
done
