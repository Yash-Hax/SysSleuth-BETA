#!/bin/bash

# Get version and age of Ubuntu system
version=$(lsb_release -a)
age=$(date -d "$(stat -c %y /etc/lsb-release | cut -d' ' -f1)" +"%Y-%m-%d")

echo "Ubuntu version: $version"
echo "Ubuntu age: $age"

# Check for known vulnerabilities using ExploitDB API search
echo "Checking for known vulnerabilities using ExploitDB API search..."
curl -s "https://www.exploit-db.com/search?q=$version" | grep -o '<a href="/exploits/[^"]*' | sed 's/<a href="\/exploits\//https:\/\/www.exploit-db.com\/exploits\//g' | while read line; do
  # Check if system is vulnerable to exploit
  exploit_info=$(curl -s "$line")
  if echo "$exploit_info" | grep -q "Vulnerable"; then
    echo "System is vulnerable to exploit: $line"
  fi
done

# Check if any packages on system are outdated
if apt-get -u upgrade; then
  echo "Outdated packages found. Updating packages using 'apt-get upgrade'..."
  apt-get upgrade
else
  echo "No outdated packages found."
fi

# Check for privilege escalation vulnerabilities using GTFOBins API
echo "Checking for privilege escalation vulnerabilities using GTFOBins API..."
curl -s "https://gtfobins.github.io/gtfobins/linux/index.json" | jq 'keys' | while read binary; do
  # Check if binary is present on system
  if which $binary; then
    echo "Found potential privilege escalation vulnerability: $binary"
  fi
done
