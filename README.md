# OSS Audit — Git
## Open Source Software Capstone Project

**Student Name:** [NIHARIKA SHARMA]  
**Registration Number:** [24BAI100966]  
**Course:** Open Source Software (OSS NGMC)  
**Chosen Software:** Git  
**Repository Name:** oss-audit-[]

---

## About This Project

This repository contains five shell scripts written as part of the Open Source Audit capstone project. Each script demonstrates practical Linux shell scripting skills and explores the open source ecosystem through the lens of Git — the version control system created by Linus Torvalds in 2005.

---

## Shell Scripts

| Script | Name | Purpose |
|--------|------|---------|
| `script1_system_identity.sh` | System Identity Report | Displays system info: distro, kernel, user, uptime, date, and OS license |
| `script2_package_inspector.sh` | FOSS Package Inspector | Checks if Git is installed, shows version and license, prints philosophy notes |
| `script3_disk_permission_auditor.sh` | Disk and Permission Auditor | Loops through key directories and reports permissions, owner, and disk size |
| `script4_log_analyzer.sh` | Log File Analyzer | Reads a log file line by line, counts keyword matches, prints last 5 matches |
| `script5_manifesto_generator.sh` | Open Source Manifesto Generator | Interactively builds a personalised open source philosophy statement |

---

## How to Run Each Script on Linux

### Prerequisites

- A Linux system (Ubuntu, Debian, Fedora, CentOS, or any major distribution)
- Bash shell (version 4.0 or later; check with `bash --version`)
- Git installed (`sudo apt install git` or `sudo dnf install git`)

### Step 1 — Clone the repository

```bash
git clone https://github.com/[your-username]/oss-audit-[rollnumber].git
cd oss-audit-[rollnumber]
```

### Step 2 — Make the scripts executable

```bash
chmod +x script1_system_identity.sh
chmod +x script2_package_inspector.sh
chmod +x script3_disk_permission_auditor.sh
chmod +x script4_log_analyzer.sh
chmod +x script5_manifesto_generator.sh
```

### Step 3 — Run Script 1: System Identity Report

```bash
./script1_system_identity.sh
```

**What it does:** Displays the Linux distribution name, kernel version, logged-in user, home directory, system uptime, current date/time, and the license of the OS.  
**No arguments required.**

---

### Step 4 — Run Script 2: FOSS Package Inspector

```bash
./script2_package_inspector.sh
```

**What it does:** Checks whether the `git` package is installed using your system's package manager (RPM or dpkg), shows version and license info, then prints a philosophy note via a `case` statement.  
**No arguments required.** Edit the `PACKAGE` variable inside the script to inspect a different package.

---

### Step 5 — Run Script 3: Disk and Permission Auditor

```bash
./script3_disk_permission_auditor.sh
```

**What it does:** Loops through `/etc`, `/var/log`, `/home`, `/usr/bin`, `/tmp`, `/usr/share`, and `/var`, printing permissions, owner, group, and disk usage for each. Also checks if Git's configuration files are present.  
**No arguments required.**

---

### Step 6 — Run Script 4: Log File Analyzer

```bash
./script4_log_analyzer.sh /var/log/syslog error
```

Or on systems that use `/var/log/messages`:

```bash
./script4_log_analyzer.sh /var/log/messages error
```

**Arguments:**
- `$1` — Path to the log file (required)
- `$2` — Keyword to search for (optional; defaults to `error` if not provided)

**Examples:**

```bash
./script4_log_analyzer.sh /var/log/syslog warning
./script4_log_analyzer.sh /var/log/auth.log failed
./script4_log_analyzer.sh /var/log/kern.log error
```

**What it does:** Reads the log file line by line, counts occurrences of the keyword (case-insensitive), prints the last 5 matching lines, and retries with a fallback log file if the specified file is empty.

---

### Step 7 — Run Script 5: Open Source Manifesto Generator

```bash
./script5_manifesto_generator.sh
```

**What it does:** Asks three interactive questions and generates a personalised open source philosophy statement, saving it to `manifesto_[username].txt` in the current directory.  
**No arguments required.** The script is interactive — answer the prompts when asked.

---

## Dependencies

| Script | Dependencies |
|--------|-------------|
| Script 1 | `bash`, `uname`, `whoami`, `uptime`, `date` — all standard on any Linux system |
| Script 2 | `bash`, `rpm` (RHEL/Fedora) or `dpkg` (Debian/Ubuntu), `grep` |
| Script 3 | `bash`, `ls`, `du`, `awk`, `cut` — all standard |
| Script 4 | `bash`, `grep`, `wc`, `tail` — all standard |
| Script 5 | `bash`, `date`, `whoami`, `cat` — all standard |

All dependencies are part of the standard Linux base system. No additional packages need to be installed beyond what is already present on a typical Linux installation.

---

## File Structure

```
oss-audit-[rollnumber]/
├── script1_system_identity.sh
├── script2_package_inspector.sh
├── script3_disk_permission_auditor.sh
├── script4_log_analyzer.sh
├── script5_manifesto_generator.sh
└── README.md
```

---

## Notes

- Scripts were developed and tested on Ubuntu 22.04 LTS and are compatible with most Debian/Ubuntu and RHEL/Fedora distributions.
- Script 2 auto-detects whether the system uses RPM or DEB packaging and adjusts accordingly.
- Script 4 includes a retry mechanism: if the specified log file is empty, it automatically tries common fallback locations (`/var/log/syslog`, `/var/log/messages`, `/var/log/kern.log`).
- All scripts include inline comments explaining each section and the concepts used.

