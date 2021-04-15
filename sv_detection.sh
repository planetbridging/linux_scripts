#!/bin/bash

# -sS tcp syn
# -sT connect
# -sU udp
# -sA ack
# -sW windows
# -sM maimon

# nmap -sS -p- -oG - 192.168.1.1
#nmap --open 192.168.1.1 -oG - | grep "/open" | awk '{ print $2 }'
#nmap -sS -oG - 192.168.1.1 | awk '/open/{ s = ""; for (i = 5; i <= NF-4; i++) s = s substr($i,1,length($i)-4) "\n"; print $2 " " $3 "\n" s}'
#nmap -sS -oG - 192.168.1.1 | awk '/open/{ s = ""; for (i = 5; i <= NF-4; i++) s = s substr($i,1,length($i)-4) "\n"; print $2 " " $3 "\n" s}'
#nmap -sS -oG - 192.168.1.1 | awk '/open/ {print $1}'

open_ports=()

ports_ss=$(eval nmap -sV -vv -p $2 -sS -oX sv_detection/$1_ss.txt $1 | awk '/open/{ s = ""; for (i = 5; i <= NF-4; i++) s = s substr($i,1,length($i)-4) "\n"; print $2 " " $3 "\n" s}')
ports_st=$(eval nmap -sV -vv -p $2 -sT -oX sv_detection/$1_st.txt $1 | awk '/open/{ s = ""; for (i = 5; i <= NF-4; i++) s = s substr($i,1,length($i)-4) "\n"; print $2 " " $3 "\n" s}')
ports_sa=$(eval nmap -sV -vv -p $2 -sA -oX sv_detection/$1_sa.txt $1 | awk '/open/{ s = ""; for (i = 5; i <= NF-4; i++) s = s substr($i,1,length($i)-4) "\n"; print $2 " " $3 "\n" s}')

echo $ports_ss
echo $ports_st
echo $ports_sa
