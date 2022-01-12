#!/bin/bash
#if ping -c 1 10.0.2.108 &> /dev/null
#then
#  echo 1
#else
#  echo 0
#fi
#
#files=$(eval find . -maxdepth 1 -name "*network*" -print)
array=(find . -maxdepth 1 -name "*network*")


IFS=$'\n'
paths=($(find . -name "*network*"))
unset IFS

#printf "%s\n" "${paths[@]}"

for i in "${paths[@]}"
do
	echo "$i"
    PS3="Enter a number: "

    PS3="Select the operation: "

    select opt in y n; do

    case $opt in
        y)
            input=$i
            while IFS= read -r line
            do
                echo "$line"
                if ping -c 1 $line &> /dev/null
                then
                    echo "found " $line
                    ./sv_detection.sh $line
                else
                    echo 0
                fi
            done < "$input"
        ;;

        n)
        break
        ;;
        *) 
        echo "Invalid option $REPLY"
        ;;
    esac
    done
done

#pauses
#read  -n 1 -p "Input Selection:" mainmenuinput
#read varname
#input=$varname
#while IFS= read -r line
#do
#  echo "$line"
#done < "$input"