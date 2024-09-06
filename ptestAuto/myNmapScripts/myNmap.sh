#!/bin/bash

source ~/myScripts/pentestAutomationCode/basicNmapEnum/nmapFunctions.sh
source ~/myScripts/pentestAutomationCode/basicNmapEnum/basicNmapEnumOptions.sh

SHORT=i,p,s,u
LONG=ho,ph,va,vp,iL:,pL:,chpvp,chp
OPTS=$(getopt --options $SHORT --longoptions $LONG -- "$@")

eval set -- "$OPTS"

#no arguments to script
if [ $# -eq 1 ]; then
	echo "Need at least one argument."
	howScriptWorks #from basicNmapEnumOptions.sh
fi

#determining if there is an --iL and/or --pL in the script so I can adjust accordingly. iL is a file list of IP's and pL is a file list of port numbers
iL=0
iLTrue=0
pL=0
pLTrue=0

for i in $OPTS; do
	if [ "$iLTrue" == 1 ]; then
		iL=$i
		iLTrue=0
	fi
	if [ "$pLTrue" == 1 ]; then
		pL=$i
		pLTrue=0
	fi
	if [ "$i" == "--iL" ]; then
		iLTrue=1
	fi
	if [ "$i" == "--pL" ]; then
		pLTrue=1
	fi
done

while :
do
	case "$1" in
		-i) #INTERACTIVE MODE --------------------------------------------------------------------------------
			basicOptions #from basicNmapEnumOptions.sh
			read input
			if [ $input == "--more" ]; then
				moreOptions #from basicNmapEnumOptions.sh
			elif [ $input == "-h" ] ||[ $input == "--help" ]; then
				howScriptWorks #from basicNmapEnumOptions.sh
			elif [ $input == "--ho" ]; then
				addIP
				ho $filePath
				if [ -f tempIpAdd.txt ]; then
					rm tempIpAdd.txt
				fi
			elif [ $input == "--ph" ]; then
				addIP
				ph $filePath
				if [ -f tempIpAdd.txt ]; then
					rm tempIpAdd.txt
				fi
			elif [ $input == "-p" ]; then
				addIP
				p $filePath
				if [ -f tempIpAdd.txt ]; then
					rm tempIpAdd.txt
				fi
			elif [ $input == "--va" ]; then
				addIP
				va $filePath
				if [ -f tempIpAdd.txt ]; then
					rm tempIpAdd.txt
				fi
			elif [ $input == "--vp" ]; then
				addIP
				addPort
				vp $filePath $portPath
				if [ -f tempIpAdd.txt ]; then
					rm tempIpAdd.txt
				fi
				if [ -f tempPortNum.txt ]; then
					rm tempPortNum.txt
				fi
			fi
			shift;
			break			
			;;
		--iL)
			shift 2
			;;
		--pL)
			shift 2
			;;
		--ho)
			ho $iL
			shift 1
			;;
		--ph)
			ph $iL
			shift 1
			;;
		-p)
			p $iL
			shift 1
			;;
		--va)
			va $iL
			shift 1
			;;
		--vp)
			vp $iL $iP
			shift 1
			;;
		-h | --help)
			howScriptWorks #from basicNmapEnumOptions.sh
			exit 2
			;;
		--more)
			moreOptions
			exit 2
			;;
		--)
			shift;
			break
			;;
		*)
			echo "Invalid option: $1"
			;;
	esac
done
			
: <<'comment'
if [ $1 == "i" ] || [ $1 == "-h" ] || [ $1 == "--help" ]; then
	basicOptions #from basiNmapEnumOptions.sh
	read input
	
	#user input
	if [ $input == "--more" ]; then
		moreOptions #from basiNmapEnumOptions.sh
	elif [ $input == "-h" ] ||[ $input == "--help" ]; then
		howScriptWorks #from basiNmapEnumOptions.sh


	#basic options
	elif [ $input == "-ho" ]; then
		echo "Enter IP Address:"
	
	
	#invalid options
	else
		echo "Invalid argument"

	fi 	
#INTERACTIVE MODE END-----------------------------------------------------------------------------

#COMMAND LINE MODE (user enters arguments in command line) ---------------------------------------
elif [ $1 == "c" ]; then
	


	#checking for additional arguments
	if [ ! $3 == "" ]; then
		echo "more than one option detected"

	#if only one argument
	elif [ $2 == "-ho" ]; then
		ho
	
	
	
	fi


fi
comment

#to use a list for ports, you need to do -p $(tr '\n' , <list). Yes, you need the "<", and only once. Don't need a matching one. For the file list, needs to be in CSV format. That means values followed by comma followed by next value. No spaces or new lines.


