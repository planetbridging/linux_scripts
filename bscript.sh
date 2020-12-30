#!/bin/bash
function back_ground_process () {
	# Random number between 10 and 15
	sleep_time=$(($RANDOM*12345%6 + 10))

	echo "${1} will sleep for ${sleep_time} seconds"

	sleep ${sleep_time}

	echo "${1} sleep done!"
}

# array in shell script
arr=("a_worker" "b_worker" "c_worker")

# @ means all elements in array
#for i in ${arr[@]}; do
    # run back_ground_process function in background
    # pass element of array as argument
    # make log file

 #   back_ground_process $i > ~/log_${i}.txt &
#done

function Port_Scan(){
	#echo $1
	eval "nmap -sS -p "$1 "192.168.1.1 -oG -" 
}

for i in {1..65535}; do
    #eval "nmap -sS -p "$i "192.168.1.1 -oG -" 
    Port_Scan $i &
done

wait
echo "done"

