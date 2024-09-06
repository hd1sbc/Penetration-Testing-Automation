#!/bin/bash

#no args and help options-----------------------------------------------
if [ -z $1 ]; then
	echo "Insufficient number of arguments."
	echo "Usage: commandAlias  subdomainList hostName"
	echo "To iterate through 0-255 in the last/right most octet of an IP address:"
	echo "	-i <first 3 octets of IP address>"
	echo ""
	echo "Examples:"
	echo "commandAlias potentHostname.txt megacorp.com"
	echo "commandAlias -i 127.0.0."
	echo "		Make sure to include "." after the 3rd octet"
elif [ $1 == "-h" ] || [ $1 == "--help" ]; then
	echo "Help"
	echo "Usage: commandAlias  subdomainList hostName"
	echo "To iterate through 0-255 in the last/right most octet of an IP address:"
	echo "	-i <first 3 octets of IP address>"
	echo ""
	echo "Examples:"
	echo "commandAlias potentHostname.txt megacorp.com"
	echo "commandAlias -i 127.0.0."
	echo "		Make sure to include . after the 3rd octet"

#executable options----------------------------------------------------

#base option
elif [ -n $1 ] && [ -n $2 ] && [ ! $1 == "-i" ]; then
	for ip in $(cat $1); do host $ip.$2.com; done

#iterate option
elif [ $1 == "-i" ]; then
	if [ -z $2 ]; then
		echo "Missing argument. Use -h or --help option for details"
	else
		for ip in $(seq 0 255); do host $2$ip; done | grep -v "not found"
			
	fi

#invalid option
else
	echo "Invalid option. Use -h or --help option for details"

fi
