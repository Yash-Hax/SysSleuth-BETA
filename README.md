# Description
This script is designed to check an Ubuntu system for known vulnerabilities and potential privilege escalation vulnerabilities. It uses the lsb_release command to find the version and age of the Ubuntu system, the ExploitDB API search to check for known vulnerabilities, and the GTFOBins API to check for potential privilege escalation vulnerabilities.

# Requirements
- Bash
- curl, grep, jq, and apt-get
- An internet connection
- Access to the ExploitDB API search and the GTFOBins API
# Usage
To use the script, make it executable using the chmod command. You can then run the script using the ./ command. For example:
```chmod +x vulnerability_check.sh```<br>
```./vulnerability_check.sh```
