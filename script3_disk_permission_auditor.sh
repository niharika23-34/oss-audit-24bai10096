#!/bin/bash
# Script 3: Disk and Permission Auditor
# Author: [Your Name] | Reg No: [Your Reg Number]
# Course: Open Source Software | Unit: 2
# Purpose: Loops through a list of important system directories and reports
#          the disk usage and permission/owner details of each.
#          Also checks if Git's configuration directory exists and shows its permissions.

# --- Define the list of directories to audit ---
# These are standard Linux filesystem locations used by most distributions.
DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp" "/usr/share" "/var")

echo "========================================================"
echo "        Disk and Permission Auditor"
echo "========================================================"
echo ""
printf "%-20s %-30s %-10s\n" "Directory" "Permissions (mode owner group)" "Size"
echo "------------------------------------------------------------------------"

# --- Loop through each directory in the DIRS array ---
# The for loop iterates over every item in the array.
# "${DIRS[@]}" expands the full array while preserving items with spaces in their names.
for DIR in "${DIRS[@]}"; do

    # Check if the directory exists using the -d test operator
    if [ -d "$DIR" ]; then
        # ls -ld lists the directory itself (not its contents)
        # awk '{print $1, $3, $4}' extracts: permissions, owner, group
        PERMS=$(ls -ld "$DIR" | awk '{print $1, $3, $4}')

        # du -sh gives a human-readable size (-h) for a single directory (-s)
        # 2>/dev/null suppresses "permission denied" errors for protected directories
        # cut -f1 takes only the first column (the size figure, not the path)
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)

        # If du was blocked by permissions, report as "restricted"
        if [ -z "$SIZE" ]; then
            SIZE="restricted"
        fi

        # printf formats the output in aligned columns for readability
        printf "%-20s %-30s %-10s\n" "$DIR" "$PERMS" "$SIZE"
    else
        # Directory does not exist on this system
        printf "%-20s %-30s\n" "$DIR" "[does not exist on this system]"
    fi
done

echo ""
echo "========================================================"
echo "        Git Configuration Directory Check"
echo "========================================================"
echo ""

# --- Check if Git's configuration directory exists ---
# On most Linux systems Git stores its system-wide config in /etc/gitconfig
# and the user-level config in ~/.gitconfig or ~/.config/git/

# /etc/gitconfig is the system-wide Git configuration file
GIT_SYSTEM_CONFIG="/etc/gitconfig"

# ~/.config/git is the XDG-standard user-level Git configuration directory
GIT_USER_CONFIG_DIR="$HOME/.config/git"

# ~/.gitconfig is the older user-level Git configuration file
GIT_USER_CONFIG_FILE="$HOME/.gitconfig"

# Check for the system-wide configuration file
if [ -f "$GIT_SYSTEM_CONFIG" ]; then
    echo "Git system config found: $GIT_SYSTEM_CONFIG"
    # ls -l shows permissions, owner, and size of the file
    echo "Permissions:"
    ls -l "$GIT_SYSTEM_CONFIG"
else
    echo "Git system config ($GIT_SYSTEM_CONFIG) not found."
    echo "This is normal if Git has never been configured system-wide."
fi

echo ""

# Check for the user-level configuration directory
if [ -d "$GIT_USER_CONFIG_DIR" ]; then
    echo "Git user config directory found: $GIT_USER_CONFIG_DIR"
    echo "Permissions:"
    ls -ld "$GIT_USER_CONFIG_DIR"
elif [ -f "$GIT_USER_CONFIG_FILE" ]; then
    echo "Git user config file found: $GIT_USER_CONFIG_FILE"
    echo "Permissions:"
    ls -l "$GIT_USER_CONFIG_FILE"
else
    echo "No user-level Git configuration found at $GIT_USER_CONFIG_FILE"
    echo "Run 'git config --global user.name \"Your Name\"' to create one."
fi

echo ""

# Check if the git binary itself is present and show its location
if command -v git &>/dev/null; then
    GIT_BIN=$(command -v git)
    echo "Git binary location : $GIT_BIN"
    echo "Permissions on binary:"
    ls -l "$GIT_BIN"
    echo ""
    echo "Installed Git version: $(git --version)"
else
    echo "Git is not installed on this system."
fi

echo ""
echo "========================================================"
echo "   Audit complete: $(date '+%d %B %Y %H:%M:%S')"
echo "========================================================"
