#!/bin/bash

if [ -z "$1" ]; then
	nc -nvlp 4444
elif [ $1 == "-h" ] || [ $1 == "--help" ]; then
	echo "Netcat Listener"
	echo "Options:"
	echo "	<empty>			default to port 4444"
	echo "	<portNum>		sets listener to given port"
	echo ""
	echo "Example Usage:"
	echo "	commandAlias 1234"
elif [ -z "${1//[0-9]}" ] && [ $1 -le 65535 ] && [ $1 -ge 1 ]; then
	nc -nvlp $1
else
	echo "Invalid input. Port number must be a positive integer between 1 and 65535"
	echo "Use the -h or --help flags for more info"
fi
