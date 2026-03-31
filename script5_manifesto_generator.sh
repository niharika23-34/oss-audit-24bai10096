#!/bin/bash
# Script 5: Open Source Manifesto Generator
# Author: [Your Name] | Reg No: [Your Reg Number]
# Course: Open Source Software | Unit: 5
# Purpose: Asks the user three interactive questions and generates a personalised
#          open source philosophy statement, saving it to a .txt file.
#
# Concepts demonstrated:
#   - read: for capturing interactive user input
#   - String concatenation: combining variables into a paragraph
#   - File redirection (> and >>): writing output to a file
#   - date command: embedding a timestamp in the output
#   - Aliases (commented example below): shorthand commands for convenience

# --- Alias concept demonstration ---
# An alias is a shorthand name for a longer command.
# In a running shell session you might use:
#   alias today='date "+%d %B %Y"'
# After setting that alias, typing 'today' runs the full date command.
# Aliases are often placed in ~/.bashrc so they persist across sessions.
# We cannot use them inside a script (aliases are not inherited by subshells),
# but the concept is the same as defining a variable that holds a command string.

echo "========================================================"
echo "        Open Source Manifesto Generator"
echo "========================================================"
echo ""
echo "You will be asked three questions."
echo "Your answers will be used to generate a personal"
echo "open source philosophy statement."
echo ""

# --- Collect user input with the read command ---
# -p displays a prompt string before waiting for input
# The answer is stored in the named variable

# Question 1: A tool the user relies on
read -p "1. Name one open-source tool you use every day: " TOOL

# Question 2: Their definition of freedom in one word
read -p "2. In one word, what does 'freedom' mean to you? " FREEDOM

# Question 3: Something they would build and share openly
read -p "3. Name one thing you would build and share freely with the world: " BUILD

echo ""

# --- Check that all three answers were provided ---
# -z tests whether a string is empty (zero length)
if [ -z "$TOOL" ] || [ -z "$FREEDOM" ] || [ -z "$BUILD" ]; then
    echo "Error: All three questions must be answered."
    echo "Please re-run the script and provide answers to all questions."
    exit 1
fi

# --- Get the current date for the document header ---
# date '+%d %B %Y' formats as: day month year (e.g. 31 March 2025)
DATE=$(date '+%d %B %Y')

# --- Determine the output filename ---
# whoami returns the current username; the filename will be unique per user
OUTPUT="manifesto_$(whoami).txt"

# --- Write the manifesto to the output file ---
# The > operator creates the file (or overwrites it if it exists)
# The >> operator appends to the file without overwriting

# Write the title and header first (> creates / overwrites the file)
echo "========================================" > "$OUTPUT"
echo "   My Open Source Manifesto" >> "$OUTPUT"
echo "   Generated on: $DATE" >> "$OUTPUT"
echo "   Author: $(whoami)" >> "$OUTPUT"
echo "========================================" >> "$OUTPUT"
echo "" >> "$OUTPUT"

# --- Compose the personalised philosophy paragraph ---
# String concatenation: we build the paragraph by placing variable values
# inline within double-quoted strings. Bash expands $VARIABLE inside double quotes.

echo "I believe in the power of open source software." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "Every day, I rely on $TOOL — a tool built not for profit, but for people." >> "$OUTPUT"
echo "Its source code is open, its community is global, and its existence proves that" >> "$OUTPUT"
echo "the most powerful things in the world can be built without walls or paywalls." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "To me, freedom means $FREEDOM — and that is exactly what open source delivers." >> "$OUTPUT"
echo "Freedom to look inside the tools I depend on. Freedom to change what doesn't work." >> "$OUTPUT"
echo "Freedom to share what I build, without asking permission." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "One day, I will build $BUILD and share it freely with anyone who can use it." >> "$OUTPUT"
echo "Not because I have to, but because that is how the best software in the world" >> "$OUTPUT"
echo "has always been made — by people who understood that knowledge grows when shared." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "Open source is not just a licensing model. It is a commitment to a world where" >> "$OUTPUT"
echo "technology belongs to those who use it — not only to those who sell it." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  — $(whoami), $DATE" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "========================================" >> "$OUTPUT"

# --- Confirm and display the result ---
echo "Manifesto saved to: $OUTPUT"
echo ""
echo "--- Contents of $OUTPUT ---"
echo ""

# cat reads and prints the contents of the file to the terminal
cat "$OUTPUT"

echo ""
echo "========================================================"
