#!/bin/bash

#nmap -vv -p 135,139,445,49152,49153,49154,49155,49156,49157,21,22,80,2016,1027,3389 -sV -oX allscripts.xml --script all 10.20.30.125-254

nmap -vv -p $2 -sV -oX $1_xml.xml -oN $1_txt.txt --script all $1
