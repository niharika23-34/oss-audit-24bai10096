#!/bin/bash
# Script 2: FOSS Package Inspector
# Author: [Your Name] | Reg No: [Your Reg Number]
# Course: Open Source Software | Unit: 2
# Purpose: Checks whether a given open-source package is installed on the system,
#          displays version and license details, and prints a philosophy note
#          about the package using a case statement.

# --- Set the package to inspect ---
# Change this to match your chosen software's package name.
# On Debian/Ubuntu systems: git, vlc, firefox, mysql-server, etc.
# On RHEL/Fedora systems:   git, vlc, firefox, mysql, httpd, etc.
PACKAGE="git"

echo "========================================================"
echo "        FOSS Package Inspector"
echo "========================================================"
echo ""
echo "Checking installation status of: $PACKAGE"
echo ""

# --- Detect which package manager is available on this system ---
# Different Linux distributions use different package managers.
# We check for rpm (Red Hat / Fedora / CentOS) first, then dpkg (Debian / Ubuntu).

if command -v rpm &>/dev/null; then
    # --- RPM-based system (RHEL, Fedora, CentOS, openSUSE) ---
    # rpm -q checks if the package is installed; &>/dev/null suppresses all output
    if rpm -q "$PACKAGE" &>/dev/null; then
        echo "[INSTALLED] $PACKAGE is installed on this system."
        echo ""
        echo "--- Package Details ---"
        # rpm -qi shows detailed package info; grep -E filters for Version, License, Summary
        rpm -qi "$PACKAGE" | grep -E "^(Version|License|Summary|URL)"
    else
        echo "[NOT FOUND] $PACKAGE is NOT installed on this system."
        echo "To install on an RPM-based system, run:"
        echo "  sudo dnf install $PACKAGE     (Fedora/RHEL 8+)"
        echo "  sudo yum install $PACKAGE     (CentOS/RHEL 7)"
    fi

elif command -v dpkg &>/dev/null; then
    # --- Debian-based system (Ubuntu, Debian, Linux Mint) ---
    # dpkg -l lists installed packages; grep looks for our package name
    # 2>/dev/null suppresses error messages if the package is not in the database
    if dpkg -l "$PACKAGE" 2>/dev/null | grep -q "^ii"; then
        echo "[INSTALLED] $PACKAGE is installed on this system."
        echo ""
        echo "--- Package Details ---"
        # dpkg -s shows status and metadata; grep -E filters relevant fields
        dpkg -s "$PACKAGE" 2>/dev/null | grep -E "^(Version|Homepage|Description|Maintainer)"
    else
        echo "[NOT FOUND] $PACKAGE is NOT installed on this system."
        echo "To install on a Debian-based system, run:"
        echo "  sudo apt-get install $PACKAGE"
    fi

else
    # Neither rpm nor dpkg found — try to check using the binary directly
    echo "No RPM or DEB package manager found. Checking via command name..."
    if command -v "$PACKAGE" &>/dev/null; then
        echo "[FOUND] $PACKAGE binary is available. Version:"
        "$PACKAGE" --version 2>/dev/null | head -1
    else
        echo "[NOT FOUND] $PACKAGE could not be located on this system."
    fi
fi

echo ""
echo "========================================================"
echo "        Open Source Philosophy Notes"
echo "========================================================"
echo ""

# --- Case statement: print a philosophy note for known FOSS packages ---
# The case statement matches the value of $PACKAGE against a list of patterns.
# Each pattern ends with ;; to break out of the case block.
case "$PACKAGE" in
    git)
        echo "Package  : Git"
        echo "License  : GPL v2"
        echo "Note     : Linus Torvalds built Git in 2005 after BitKeeper — the proprietary"
        echo "           version control tool used by the Linux kernel — revoked its free license."
        echo "           Rather than surrender to a closed tool, he spent two weeks building Git."
        echo "           It is now the global standard for version control and is entirely open source."
        ;;
    httpd | apache2)
        echo "Package  : Apache HTTP Server"
        echo "License  : Apache 2.0"
        echo "Note     : Apache built the open web. The Apache License permits commercial use"
        echo "           without requiring companies to open their own modifications — a pragmatic"
        echo "           choice that helped spread open source into enterprise environments."
        ;;
    mysql | mysql-server)
        echo "Package  : MySQL"
        echo "License  : GPL v2 / Commercial"
        echo "Note     : MySQL demonstrates the dual-licensing model — free for open source use,"
        echo "           paid for commercial use. Oracle's acquisition raised concerns about"
        echo "           corporate control, leading the community to fork it as MariaDB."
        ;;
    vlc)
        echo "Package  : VLC Media Player"
        echo "License  : LGPL / GPL"
        echo "Note     : VLC was built by students at École Centrale Paris who needed a free"
        echo "           video streaming tool for their campus network. It now plays virtually any"
        echo "           media format and is a testament to what students can build and share freely."
        ;;
    firefox)
        echo "Package  : Mozilla Firefox"
        echo "License  : MPL 2.0"
        echo "Note     : Firefox was born from Netscape's decision to open source its browser code"
        echo "           before it disappeared. The Mozilla Foundation now maintains it as a"
        echo "           nonprofit, arguing that an open web needs an open browser."
        ;;
    libreoffice)
        echo "Package  : LibreOffice"
        echo "License  : MPL 2.0"
        echo "Note     : LibreOffice forked from OpenOffice.org after Oracle acquired Sun Microsystems."
        echo "           The community refused to let corporate ownership slow development,"
        echo "           showing that in open source, the code belongs to everyone."
        ;;
    python3 | python)
        echo "Package  : Python"
        echo "License  : PSF License"
        echo "Note     : Python is governed by the Python Software Foundation, a nonprofit."
        echo "           Its permissive license has made it the language of science, education,"
        echo "           and industry — a community-driven project that resists single-company control."
        ;;
    *)
        # Default case: handle any package not specifically listed above
        echo "Package  : $PACKAGE"
        echo "Note     : This is an open-source package. Open source software grants users"
        echo "           the freedom to run, study, modify, and share it — freedoms that"
        echo "           proprietary software denies."
        ;;
esac

echo ""
echo "========================================================"
