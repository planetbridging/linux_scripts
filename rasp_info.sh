#!/bin/bash

# Prompt for subnet
read -p "Enter subnet prefix (e.g., 100.0.0): " prefix

# Prompt for starting and ending numbers
read -p "Enter starting number (e.g., 201): " start_num
read -p "Enter ending number (e.g., 204): " end_num

# Validate the numbers
if [[ ! "$start_num" =~ ^[0-9]+$ ]] || [[ ! "$end_num" =~ ^[0-9]+$ ]] || [ "$start_num" -gt "$end_num" ]; then
    echo "Invalid number range."
    exit 1
fi

# Loop through each IP in the specified range and SSH to get specs
for i in $(seq $start_num $end_num); do
    ip="$prefix.$i"
    echo "Connecting to $ip..."
    
    # Command to get specs, MAC address, and IP
    cmd="echo 'IP Address: $ip' && echo 'Specifications:' && lscpu && echo 'MAC Address:' && cat /sys/class/net/eth0/address"
    
    # SSH into the device and execute the command
    ssh -o StrictHostKeyChecking=no -o ConnectTimeout=5 ubuntu@$ip "$cmd"
    
    echo "-----------------------------------"
done
