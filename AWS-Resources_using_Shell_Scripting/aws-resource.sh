#!/bin/bash

# Version: v1.2
# Description: This script generates a report of AWS resource usage (S3 buckets, EC2 instances, Lambda functions, and IAM users).

set -e  # Exit immediately if a command exits with a non-zero status

# Output file
OUTPUT_FILE="resourceTracker.txt"
LOG_FILE="scriptExecution.log"

# Start fresh
> "$OUTPUT_FILE"  # Clear the output file if it exists
> "$LOG_FILE"     # Clear the log file if it exists

echo "AWS Resource Usage Report" | tee -a "$OUTPUT_FILE"
echo "==========================" | tee -a "$OUTPUT_FILE"

# Helper function to fetch and log AWS resource details
fetch_and_log() {
    local resource_name="$1"
    local aws_command="$2"
    echo "Fetching list of $resource_name..." | tee -a "$LOG_FILE"
    if $aws_command >> "$OUTPUT_FILE" 2>> "$LOG_FILE"; then
        echo "$resource_name fetched successfully." | tee -a "$LOG_FILE"
    else
        echo "Error fetching $resource_name. Check $LOG_FILE for details." | tee -a "$LOG_FILE"
    fi
}

# Fetch AWS resources
fetch_and_log "S3 buckets" "aws s3 ls"
fetch_and_log "EC2 instances" "aws ec2 describe-instances --query 'Reservations[*].Instances[*].InstanceId' --output json | jq '.'"
fetch_and_log "Lambda functions" "aws lambda list-functions --output json | jq '.'"
fetch_and_log "IAM users" "aws iam list-users --output json | jq '.'"

echo "AWS resource usage report generated in $OUTPUT_FILE." | tee -a "$LOG_FILE"



