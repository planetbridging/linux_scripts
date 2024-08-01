#!/bin/bash

#sudo apt update
#sudo apt install ffmpeg mediainfo


# Display current codecs
echo "Current Codecs:"
for file in *.mp4; do
   codec=$(mediainfo "$file" | grep -m 1 'Codec ID' | awk -F': ' '{print $2}')
   echo "File: $file, Codec: $codec"
done

# Convert each file to H.264
echo "Converting Files..."
for file in *.mp4; do
   output="${file%.*}_converted.mp4"
   ffmpeg -i "$file" -c:v libx264 -crf 23 -preset medium -c:a aac -b:a 192k "$output"
done

# Display codecs of converted files
echo "Converted Files Codecs:"
for file in *_converted.mp4; do
   codec=$(mediainfo "$file" | grep -m 1 'Codec ID' | awk -F': ' '{print $2}')
   echo "File: $file, Codec: $codec"
done
