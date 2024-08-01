#!/bin/bash

all_h264=true

for file in *.mp4; do
    codec=$(mediainfo "$file" | grep -m 1 'Codec ID' | awk -F': ' '{print $2}')
    if [[ "$codec" == *"avc1"* ]]; then
        is_h264="true"
    else
        is_h264="false"
        all_h264=false
    fi
    echo "File: $file, Codec: $codec, H.264: $is_h264"
done

if [ "$all_h264" = true ]; then
    echo "All .mp4 files are encoded with H.264 (AVC) codec."
else
    echo "Some .mp4 files are not encoded with H.264 (AVC) codec."
fi
