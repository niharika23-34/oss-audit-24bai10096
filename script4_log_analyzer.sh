#!/bin/bash
# Script 4: Log File Analyzer
# Author: [Your Name] | Reg No: [Your Reg Number]
# Course: Open Source Software | Unit: 2 & 5
# Usage: ./script4_log_analyzer.sh /var/log/syslog [keyword]
#        Example: ./script4_log_analyzer.sh /var/log/syslog error
#        Example: ./script4_log_analyzer.sh /var/log/auth.log WARNING
# Purpose: Reads a log file line by line, counts how many lines contain a
#          specified keyword (case-insensitive), prints the last 5 matching lines,
#          and retries with a default log file if the provided one is empty.

# --- Read command-line arguments ---
# $1 is the first argument (the log file path), passed when calling the script
LOGFILE=$1

# $2 is the second argument (the keyword to search for)
# If no keyword is given, default to "error" using the := default-value syntax
KEYWORD=${2:-"error"}

# Counter variable to track how many matching lines are found
COUNT=0

# Temporary file to store matching lines so we can print the last 5 at the end
MATCH_FILE="/tmp/log_matches_$$.txt"

# $$ is the process ID — appending it makes the temp filename unique per run
# so multiple instances of the script don't conflict with each other

echo "========================================================"
echo "        Log File Analyzer"
echo "========================================================"
echo ""

# --- Validate that a log file argument was provided ---
if [ -z "$LOGFILE" ]; then
    echo "Error: No log file specified."
    echo "Usage: $0 <logfile> [keyword]"
    echo "Example: $0 /var/log/syslog error"
    exit 1
fi

# --- Check that the file exists and is a regular file (-f) ---
if [ ! -f "$LOGFILE" ]; then
    echo "Error: File '$LOGFILE' not found or is not a regular file."
    exit 1
fi

# --- Do-while style retry: if the file is empty, fall back to a known log file ---
# In bash there is no do-while keyword, so we simulate it with a loop and break.
RETRY=0
while true; do
    # wc -l counts the number of lines in the file
    LINE_COUNT=$(wc -l < "$LOGFILE")

    if [ "$LINE_COUNT" -gt 0 ]; then
        # File has content — break out of the retry loop and proceed
        break
    fi

    # File is empty
    RETRY=$((RETRY + 1))

    if [ "$RETRY" -ge 2 ]; then
        # Tried twice — give up
        echo "Error: '$LOGFILE' is empty and no fallback log file was found."
        exit 1
    fi

    # First retry: try a common fallback log file
    echo "Warning: '$LOGFILE' is empty. Trying fallback log files..."

    # Try common log file locations in order
    for FALLBACK in /var/log/syslog /var/log/messages /var/log/kern.log; do
        if [ -f "$FALLBACK" ] && [ "$(wc -l < "$FALLBACK")" -gt 0 ]; then
            echo "Using fallback: $FALLBACK"
            LOGFILE="$FALLBACK"
            break
        fi
    done
done

echo "Log file : $LOGFILE"
echo "Keyword  : $KEYWORD (case-insensitive)"
echo "Lines    : $(wc -l < "$LOGFILE") total"
echo ""
echo "Scanning..."
echo ""

# --- Read the log file line by line using a while-read loop ---
# IFS= prevents leading/trailing whitespace from being stripped from each line
# -r prevents backslash sequences from being interpreted
while IFS= read -r LINE; do

    # if-then inside the loop: check if the current line contains the keyword
    # grep -iq performs a case-insensitive (-i) quiet (-q) search
    # -q means grep returns an exit code (0=found, 1=not found) without printing anything
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        # Increment the counter each time a match is found
        COUNT=$((COUNT + 1))

        # Append the matching line to the temporary file
        echo "$LINE" >> "$MATCH_FILE"
    fi

done < "$LOGFILE"
# The < "$LOGFILE" at the end redirects the file as input to the while loop

# --- Print the summary ---
echo "========================================================"
echo "  Search Summary"
echo "========================================================"
echo "  Log file  : $LOGFILE"
echo "  Keyword   : '$KEYWORD'"
echo "  Matches   : $COUNT line(s) found"
echo "========================================================"
echo ""

# --- Print the last 5 matching lines (if any were found) ---
if [ "$COUNT" -gt 0 ]; then
    echo "Last 5 matching lines:"
    echo "----------------------"
    # tail -5 reads the last 5 lines from the temp file
    tail -5 "$MATCH_FILE"
    echo ""
else
    echo "No lines containing '$KEYWORD' were found in this log file."
    echo ""
fi

# --- Clean up the temporary file ---
# rm -f removes the file without asking for confirmation (-f = force)
rm -f "$MATCH_FILE"

echo "========================================================"
echo "  Analysis complete: $(date '+%d %B %Y %H:%M:%S')"
echo "========================================================"
