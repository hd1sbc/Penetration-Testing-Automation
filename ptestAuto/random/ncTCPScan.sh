#!/bin/bash

if [ -z $1 ]; then
	echo "Netcat TCP/UDP Scan"
	echo "Usage: commandAlias -scanType ipAddress portNums"
	echo "	scanType can either be 'u' or 't' for UDP scan and TCP scan, respectively"
	echo "	portNums can be a single number or a range (0-255)"
	echo "Example: commandAlias -t 127.0.0.1 1-443"
elif [ $1 == "-h" ] || [ $1 == "--help" ]; then
	echo "Netcat TCP/UDP Scan"
	echo "Usage: commandAlias -scanType ipAddress portNums"
	echo "	scanType can either be 'u' or 't' for UDP scan and TCP scan, respectively"
	echo "	portNums can be a single number or a range (0-255)"
	echo "Example: commandAlias -t 127.0.0.1 1-443"
elif [ $1 == "-t"  ] && [ ! -z $2 ] && [ ! -z $3 ]; then
	nc -nvv -w 1 -z $2 $3
elif [ $1 == "-u" ] && [ ! -z $2 ] && [ ! -z $3 ]; then
	nc -nv -u -z -w 1 $2 $3
else
	echo "Invalid option(s). Use -h or --help option for details"
fi	
