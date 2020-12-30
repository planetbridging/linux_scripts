#!/bin/bash
#nmap -p 22 --open -sV 192.168.1.0/24 -oG - | grep 22/open
#pi=$(nmap -p 22 --open -sV $1/24 -oG - | grep 22/open)

setup_run="sudo apt-get update -y && sudo apt-get install golang -y && sudo apt-get install nmap -y && sudo apt-get install git -y && git clone https://github.com/planetbridging/gogetgalaxy && cd gogetgalaxy && cd node && go run node.go"
lstpi=$(eval nmap -p 22 --open -sV 192.168.1.0/24 -oG -  192.168.1.2 | awk '/open/{print $2 "," $7}')

for i in ${lstpi}; do
	echo $i
    #Define multi-character delimiter
    delimiter=","
    #Concatenate the delimiter with the main string
    string=$i$delimiter

    #Split the text based on the delimiter
    myarray=()
    while [[ $string ]]; do
    myarray+=( "${string%%"$delimiter"*}" )
    string=${string#*"$delimiter"}
    done

    echo 
    if [[ "${myarray[0]}" == *"."* ]]; then
        if [[ "${myarray[1]}" == *"Rasp"* ]]; then
            DEFAULT_TABS_TITLE1="${myarray[0]}${myarray[1]}"
            DEFAULT_TABS_CMD1="sshpass -p raspberry ssh pi@${myarray[0]} '$setup_run'"
            gnome-terminal --tab -- bash -ic "export TITLE_DEFAULT='$DEFAULT_TABS_TITLE1'; $DEFAULT_TABS_CMD1; echo hello ;exec bash;"
        fi
    fi
done
