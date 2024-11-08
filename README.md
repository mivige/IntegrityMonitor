# File Integrity Monitor

![Version](https://img.shields.io/badge/Version-1.0.0-brightgreen)
![Language](https://img.shields.io/badge/Language-PowerShell-blue)
![License](https://img.shields.io/badge/License-MIT-red)
---
 
## Overview
A file integrity monitor built in PowerShell that checks if files in a folder are modified, deleted, or added.

## Features
- Monitors a single folder for any changes in file integrity.
- Detects when files are:
  - **Added**
  - **Deleted**
  - **Modified**
- Provides alerts directly in the command prompt. [^1]

## Setup
1. Clone the repository to your local machine:
   ```bash
   git clone https://github.com/yourusername/file-integrity-monitor.git
   ```
2. Open the integrity_monitor.ps1 file in the src folder.

3. Update paths where indicated by "INSERT_PATH_HERE", particularly for the monitored.txt file replace all occurrences of "INSERT_PATH_HERE" with the path where you want monitored.txt to be saved.

## Usage
1. Run the PowerShell script:
  ```powershell
  ./src/file-integrity-monitor.ps1
  ```
2. Choose one of the following options when prompted:
- Option 1: Add files to be monitored.
  - This will prompt you for a folder path.
  - The script calculates and stores the hash of each file in monitored.txt.
- Option 2: Begin monitoring.
  - The script continuously monitors the files listed in monitored.txt for any changes, deletions, or additions.

## Notes
Currently, the software can only monitor a single folder at a time. Multi-folder support is planned for future releases.
To stop monitoring, close the PowerShell window.

## Troubleshooting
- Error: "There are no files to monitor, please add files first."
  - Solution: Run the script and select option 1 to add files before monitoring.

## License
This project is licensed under the MIT License. See the LICENSE file for details.

[^1]: The software prints alerts on the command prompt, but it's easy to make it send OS notifications instead.
To do that, you can refer to <a href="https://github.com/windos/poshnotify">this</a>.
