#!/bin/bash

# UNFINISHED. This is only modestly functional and minimally tested!!

ipAdd=""
uList=0
ipList=0

if [ -z $1 ]; then
	echo "Insufficient number of arguments. Use '-h' or '--help' for details"
elif [ $1 == "-h" ] || [ $1 == "--help" ]; then
	echo "Netcat SMTP Help Menu"
	echo "Description: enumerating SMTP and users"
	echo "Options:"
	echo "	<empty>			:- default. Will run the command and user will supply VRFY commands"
	echo "	-ul,	--userList	:- use a list of usernames"
	echo "	-iL,	--ipList	:- use a list of IP addresses"
	echo "Usage:"
	echo "	ncSMTPAlias <ipAddress>"
	echo "	ncSMTPAlias <ipAddress> -uL userList.txt -iL ipList.txt"
	echo "Notes:"
	echo "	After running the command without any options, type VRFY <username> to see if a username exists"
elif [ ! -z $2 ]; then
	for i in $@; do	
		if [ $(expr substr $i 1 1) != "-" ]; then
			ipAdd=$i
		elif [ $i == "-uL" ] || [ $i == "--userList" ]; then
			uList=1
		elif [ $i == "-iL" ] || [ $i == "--ipList" ]; then
			ipList=1
		fi
	done
fi

if [ -z $2 ]; then
	nc -nv $1 25
elif [ $ipList -eq 1 ]; then
	if [ $uList -eq 1 ]; then
		nc -nv $ipAdd

