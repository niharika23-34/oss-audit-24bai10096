#!/bin/bash
# Script 1: System Identity Report
# Author: [Your Name] | Reg No: [Your Reg Number]
# Course: Open Source Software | Unit: 1 & 2
# Purpose: Displays a welcome screen showing system identity details,
#          including the Linux distribution, kernel version, logged-in user,
#          home directory, uptime, current date/time, and the OS license.

# --- Student Details (fill in before submission) ---
STUDENT_NAME="[Your Name]"
REG_NUMBER="[Your Registration Number]"
SOFTWARE_CHOICE="Git"

# --- Gather system information using command substitution $() ---
# uname -r returns the kernel release version string
KERNEL=$(uname -r)

# whoami returns the username of the currently logged-in user
USER_NAME=$(whoami)

# uptime returns system uptime; we strip the leading space and take everything after the first comma
# Some systems support uptime -p (pretty), others only support the basic form
# We try -p first and fall back to the basic form if it fails
UPTIME=$(uptime -p 2>/dev/null || uptime | awk -F',' '{print $1}' | sed 's/.*up /up /')

# HOME environment variable holds the logged-in user's home directory path
HOME_DIR=$HOME

# date command with a format string returns current date and time
CURRENT_DATE=$(date '+%A, %d %B %Y %H:%M:%S')

# Read the distribution name from /etc/os-release (standard on modern Linux distros)
# The -F= flag sets the field separator to '='; $2 prints the value after the '='
# tr -d '"' strips surrounding double quotes from the value
DISTRO=$(grep "^PRETTY_NAME" /etc/os-release 2>/dev/null | cut -d= -f2 | tr -d '"')

# Fallback: if /etc/os-release is unavailable (very old systems), use uname -s
if [ -z "$DISTRO" ]; then
    DISTRO=$(uname -s)
fi

# --- Display the system identity report ---
echo "========================================================"
echo "        Open Source Audit — System Identity Report      "
echo "========================================================"
echo ""
echo "  Student   : $STUDENT_NAME ($REG_NUMBER)"
echo "  Software  : $SOFTWARE_CHOICE"
echo ""
echo "  --- Linux System Information ---"
echo "  Distribution : $DISTRO"
echo "  Kernel       : $KERNEL"
echo "  Logged in as : $USER_NAME"
echo "  Home Dir     : $HOME_DIR"
echo "  Uptime       : $UPTIME"
echo "  Date & Time  : $CURRENT_DATE"
echo ""
# Linux (the kernel) is released under GNU GPL version 2.
# This means anyone can read, modify, and redistribute the source code,
# as long as they keep the same license on their changes.
echo "  --- OS License ---"
echo "  The Linux kernel is licensed under the GNU General Public License"
echo "  version 2 (GPL v2). This means the source code is freely available,"
echo "  anyone may modify it, and all modifications must remain open source."
echo ""
echo "========================================================"
echo "   Report generated on: $(date '+%d %B %Y at %H:%M')"
echo "========================================================"
