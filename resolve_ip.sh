#!/bin/bash

# Check if an input file was provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <input_file>"
    exit 1
fi

input_file=$1
output_file="resolved_names.txt"

# Check if the input file exists
if [ ! -f "$input_file" ]; then
    echo "Input file not found!"
    exit 1
fi

# Empty or create output file
> "$output_file"

# Read the input file line by line
while IFS= read -r ip; do
    # Skip empty lines
    if [ -z "$ip" ]; then
        continue
    fi

    # Resolve the IP address to a hostname
    name=$(nslookup "$ip" | awk '/name = / { print $4 }' | sed 's/.$//')

    # If the name was resolved
    if [ -n "$name" ]; then
        echo "$ip, $name" >> "$output_file"
    else
        echo "$ip, NOT FOUND" >> "$output_file"
    fi
done < "$input_file"

echo "Resolution complete. Results are in $output_file"
