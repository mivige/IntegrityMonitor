# File Integrity Monitor

![Version](https://img.shields.io/badge/Version-0.1.0-brightgreen)
![Language](https://img.shields.io/badge/Language-PowerShell-blue)
![License](https://img.shields.io/badge/License-MIT-red)
---
A file integrity monitor built in PowerShell that checks if files in a folder are modified, deleted or added.

To make the software work on your device, you'll only have to modify the paths of the "monitored.txt" file (wherever you see "INSERT_PATH_HERE"). [^1]

At the moment the software can only monitor one folder at a time, I'm working on another version to monitor multiple folders.
 
[^1]: The software prints alerts on the command prompt, but it's easy to make it send OS notifications instead.
To do that, you can refer to <a href="https://github.com/windos/poshnotify">this</a>.
