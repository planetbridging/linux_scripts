

#!/bin/bash

cat > FILE.txt <<EOF

info code info 
info code info
info code info

EOF 

p_scan_ss=$(eval nmap -sS -oG - 192.168.1.1)

lst_ports=$(echo $p_scan_ss | tr " " "\n")

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
		echo ${array[0]}
	fi
done
