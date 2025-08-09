# Automated Web Server Log Analysis on Ubuntu server with Apache

## Introduction

This document provides a detailed breakdown of my successful completion of Project 1, a hands-on exercise in system administration. The project's goal was to build a self-sustaining system for analyzing web server access logs. This involved setting up a virtual machine, configuring a web server, creating a custom Bash script for log analysis, and automating the entire process using cron.

The project reinforced my skills in Linux fundamentals, shell scripting, and process automation, while also providing an opportunity to troubleshoot a real-world system issue.



## Phase 1: Setting up the Web Server (The Data Source)

The first step was to create a live environment that would generate the log data for our analysis.

Steps Taken:



- Virtual Machine Setup: I used VMware to set up an Ubuntu Server VM.

- Web Server Installation: I installed either Apache2 using  ```sudo apt install apache2```

- Firewall Configuration: I configured the Uncomplicated Firewall (UFW) to allow web traffic by running ```sudo ufw allow 'Apache'```.

- Verification: I verified that the web server was running and accessible by navigating to the VM's IP address from my host machine's browser. This confirmed that the server was actively generating log files.

## Phase 2: Generating and Verifying Log Data

To ensure the log file had enough data for a robust analysis, I generated test traffic and verified that it was being recorded correctly.

Steps Taken:

- I used my host machine's browser to make a series of requests to the VM's web server, including successful requests (visiting the home page) and intentional 404 errors (visiting a non-existent page).

- I used the tail command on the VM to monitor the log file in real-time.

     ```tail -f /var/log/apache2/access.log```

- This confirmed that every request from my host machine was being written to the log file, providing a solid dataset for the next phase.

## Phase 3: The Log Analysis Bash Script

This phase was the heart of the project, where I used my command-line skills to create a powerful data analysis tool. I created a Bash script named ```analyze_logs_report.sh``` mentioned in this repo that processes the raw log data and generates a clean, readable report.

The Script's Logic and Key Commands:

- The script combines several command-line utilities using pipes (|) to create a data-processing pipeline:

- Total Requests: ```grep -E ' "GET| "POST' "$LOG_FILE" | wc -l```

- This command searches for all lines containing a GET or POST request and counts them.

- Top 2 Requested URLS: ```awk '{print $7}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -2```

- This extracts the 7th field (the URL), sorts the list, counts the unique occurrences, sorts them numerically in reverse, and shows the top 10.

- Unique IP Address: ```awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -2```

- Similar to the above, this extracts the 1st field (the IP address) to identify the most frequent visitors.

- Number of 200 response_status: ```grep ' 200' "$LOG_FILE" | wc -l >> $REPORT_FILE```

- Number of 404 response_status: ```grep ' 404' "$LOG_FILE" | wc -l >> $REPORT_FILE```

- Most User-Agents that requests ```awk -F'"' '{print $6}' "$LOG_FILE" | head -1 >> $REPORT_FILE```

## Phase 4: Automation with cron

The final step was to automate the log analysis process so that the report is generated daily without any manual intervention.

Steps Taken:

- I used crontab -e to open the cron schedule editor for my user.

- I added a new entry to the crontab file:

- Run the log analysis script every day at 2:00 AM

    ```0 2 * * * /home/your_username/log_analysis_project/analyze_logs.sh```

- This entry tells the cron daemon to execute my script at 2:00 AM every day, ensuring I receive an updated report automatically.

## This project reinforced my hands-on skills in:

- Linux fundamentals and system management

- Practical shell scripting and command-line data processing

- System automation and scheduling with cron

- Independent technical problem-solving and resourcefulness
