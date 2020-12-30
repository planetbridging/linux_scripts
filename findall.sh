#!/bin/bash
#echo "Arg 0: $0"
#eval "nmap -n -sn -PR" $1"/24" | awk '/Up$/{print $2}'
icmp_pe=$(eval nmap -PE -sn $1/24 | awk '/is up/ {print up}; {gsub (/\(|\)/,""); up = $NF}')
icmp_pp=$(eval nmap -PP -sn $1/24 | awk '/is up/ {print up}; {gsub (/\(|\)/,""); up = $NF}')
icmp_pm=$(eval nmap -PM -sn $1/24 | awk '/is up/ {print up}; {gsub (/\(|\)/,""); up = $NF}')

lst_icmp_pe=$(echo $icmp_pe | tr " " "\n")
lst_icmp_pp=$(echo $icmp_pp | tr " " "\n")
lst_icmp_pm=$(echo $icmp_pm | tr " " "\n")


#sift_ip $lst_icmp_pe

combined=( "${lst_icmp_pe[@]}" "${lst_icmp_pp[@]}" "${lst_icmp_pm[@]}" )

#lst_network=$(echo "${combined[@]}" | sort -u)

lst_network=$(tr ' ' '\n' <<< "${combined[@]}" | sort -u | tr '\n' ' ')

#echo $lst_network
#printf "%s\n" "${lst_network[@]}" > file.txt

for i in ${lst_network[@]}; do
	echo $i
	echo $i >> network_$1.txt
done
