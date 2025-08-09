#!/bin/bash

# configurations

LOG_FILE="/var/log/apache2/access.log"
REPORT_DATE=$(date +"%Y-%m-%d")
REPORT_DIR="$HOME/log_analysis_project/reports"
REPORT_FILE="$REPORT_DIR/log_report-$REPORT_DATE.txt"

mkdir -p "$REPORT_DIR"

echo "Apache Server Log Analysis Report $REPORT_DATE" > $REPORT_FILE

echo "" >> $REPORT_FILE

echo "" >> $REPORT_FILE

echo "1. Total number of requests made: " >> $REPORT_FILE

grep -E ' "GET| "POST' "$LOG_FILE" | wc -l >> $REPORT_FILE

echo "" >> $REPORT_FILE

echo "2. Top 2 Requested URLS: " >> $REPORT_FILE

awk '{print $7}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -2 >> $REPORT_FILE

echo "" >> $REPORT_FILE

echo "3. Unique IP Address: " >> $REPORT_FILE

awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -2 >> $REPORT_FILE

echo "" >> $REPORT_FILE

echo "4. Number of 200 response_status: " >> $REPORT_FILE

grep ' 200' "$LOG_FILE" | wc -l >> $REPORT_FILE

echo "" >> $REPORT_FILE

echo "5. Number of 404 response_status: " >> $REPORT_FILE

grep ' 404' "$LOG_FILE" | wc -l >> $REPORT_FILE

echo "" >> $REPORT_FILE

echo "6. Most User-Agents that requests:" >> $REPORT_FILE

awk -F'"' '{print $6}' "$LOG_FILE" | head -1 >> $REPORT_FILE

echo "process complete"
