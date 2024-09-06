#!/bin/bash

basicOptions () {
	echo "Basic NMAP enumeration automation"
	echo "Options for basic scans (can only choose one):"
	echo "--ho	:- initial host scan. Command: sudo nmap -n -sn <ipAddress[/range]> -oA <folderName>"
	echo "--ph	:- tcp port scan where hosts are not known to be live. Command: sudo nmap -n --open -F -sT <ipAddress[/range]> -oA <folderName>"
	echo "-p	:- tcp port scan of known live hosts. Command: sudo nmap -n -Pn -F --open -sT <ipAddress[/range]> -oA <folderName>"
	echo "--va	:- version scan of all ports. Command: sudo nmap -n -Pn --open -F -sT -sV <ipAddress[/range]> -oA <folderName>"
	echo "--vp	:- version scan of specified ports. Command: sudo nmap -n -Pn --open -sT -sV -p <specified ports> <ipAddresss[/range]> -oA <folderName>"
	echo ""
	echo "For more options, type '--more'"
	echo "For help, type '-h' or '--help'"
}


moreOptions () {
	echo "More options:"
	echo "Additions to basic options:"
	#echo "	-t :- a secondary option (in addition to the ones above) to use -sT instead of -sS in the NMAP commands"
	#echo "	-u :- a secondary option (in addition to the ones above) to use -sU option (UDP scan) instead of -sT in the NMAP commands"
	echo "	--iL <ipAddressList> 	:- an addiontal option to use of list of IP addresses" #the actual addition to the nmap command is -iL <list>
	echo "	--pL <portList> 	:- an additional option to use a list of ports for a port scan." #see comment at bottom for details
#	echo "Chaining scans together (taking the output of one as the input for another):"
#	echo "	--chpvp :- does an initial host scan, then finds the open ports on open hosts, then does a version scan of those open ports. It is a combination of basic scans -h, -p, and -vp"
#	echo "	--chp :- does an initial host scan, then finds the open ports on open hosts. It is a combination of basic scans -h and -p"
#	echo "	To use -sS instead of -sT in the NMAP commands, add a second option '-s' to the command"
}

howScriptWorks () {
	echo "This script has two ways of running it: the interactive method and the command line options method."
	echo "Interactive:"
	echo "	The interactive method is designed for those unfamiliar with the tool and want guidance (the basic scan options) every time they run it."
	echo "	This option is available by adding '-i', and nothing else, to the command"
	echo "Command Line Options:"
	echo "	This method is designed for those who are familiar with the tool and don't want the guidance cluttering the terminal space."
	echo "	This option is the default. Just add the commands you want"
}

