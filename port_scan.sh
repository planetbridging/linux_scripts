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

ports_ss=$(eval nmap -sS -oG - $1 | awk '/open/{ s = ""; for (i = 5; i <= NF-4; i++) s = s substr($i,1,length($i)-4) "\n"; print $2 " " $3 "\n" s}')
ports_st=$(eval nmap -sT -oG - $1 | awk '/open/{ s = ""; for (i = 5; i <= NF-4; i++) s = s substr($i,1,length($i)-4) "\n"; print $2 " " $3 "\n" s}')
ports_sa=$(eval nmap -sA -oG - $1 | awk '/open/{ s = ""; for (i = 5; i <= NF-4; i++) s = s substr($i,1,length($i)-4) "\n"; print $2 " " $3 "\n" s}')


combined=( "${ports_ss[@]}" "${ports_st[@]}" "${ports_sa[@]}" )

lst_ports=$(echo "${combined[@]}" | sort -u)
lst_ports_clean=()

function contains() {
    local n=$#
    local value=${!n}
    for ((i=1;i < $#;i++)) {
        if [ "${!i}" == "${value}" ]; then
            echo "y"
            return 0
        fi
    }
    echo "n"
    return 1
}

for i in ${lst_ports[@]}; do
	#echo $i
	if [[ $i == *"open"* ]]; then
		#just_port=$i"/"
		delimiter=/
		s=$i$delimiter
		array=();
		while [[ $s ]]; do
			array+=( "${s%%"$delimiter"*}" );
			s=${s#*"$delimiter"};
		done;
		if [ $(contains "${lst_ports_clean[@]}" ${array[0]} ) != "y" ]; then
			lst_ports_clean+=( ${array[0]} )
		fi
	fi
done

for i in ${lst_ports_clean[@]}; do
	echo $i
	echo $i >> port_$1.txt
done
