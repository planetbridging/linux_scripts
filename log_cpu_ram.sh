#!/bin/bash
mkdir -p ~/logs  # Ensure the logs folder exists

while true; do
    LOG_FILE=~/logs/$(date +"%Y-%m-%d").txt
    echo "$(date +"%Y-%m-%d %H:%M:%S") | CPU: $(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')% | RAM: $(free -m | awk 'NR==2{printf "%s/%sMB (%.2f%%)", $3,$2,$3*100/$2 }') | Disk: $(df -h / | awk 'NR==2 {print $3 "/" $2 " (" $5 ")"}') | Network: $(for i in $(ls /sys/class/net/); do RX=$(cat /sys/class/net/$i/statistics/rx_bytes); TX=$(cat /sys/class/net/$i/statistics/tx_bytes); RX_H=$((RX / 1024)); TX_H=$((TX / 1024)); echo -n "$i ↓$RX_H KB ↑$TX_H KB | "; done) Top Process: $(ps -eo pid,comm,%cpu --sort=-%cpu | head -n 2 | tail -n 1) | Docker: $(docker stats --no-stream --format "{{.Name}}: CPU {{.CPUPerc}} | MEM {{.MemUsage}}" 2>/dev/null || echo 'Docker not installed')" >> "$LOG_FILE"
    sleep 1
done
