#!/bin/bash

ipList="" 
portList=""

#Input Functions ------------------------------------------------------------------------------

inputIP () {
	updatedIpArg=${1//\'/}
	if [ -f $updatedIpArg ]; then
		ipList=$(cat $updatedIpArg)
	else
		echo "Enter IP address:"
		read ipAdd
		ipList=$ipAdd
	fi
}

inputPort () {
	updatedPortArg=${1//\'/}
	if [ -f $updatedPortArg ]; then
		portList=$(cat $updatedPortArg)
	else
		echo "Enter ports:"
		echo "Format: portNum1,portNum2,...,portNumN"
		read portNum
		portList=$portNum
	fi
}

inputFolderName () {
	echo "Enter folder to save outputs (leave empty for no output):"
	read folder
	if [ ! -z $folder ] && [ -d $folder ]; then
		echo "Folder already exists. If you don't want to overwrite it, exit now (CTRL+c). Otherwise, continue"
	fi
}


#NMAP Functions ------------------------------------------------------------------------------
ho () {
	inputIP $1
	inputFolderName
	if [ -z "$folder" ]; then
		sudo nmap -n -sn -v $ipList
	else
		mkdir $folder
		cd $folder
		sudo nmap -n -sn -v $ipList -oA $folder
	fi
}

ph () {
	inputIP $1
	inputFolderName
	if [ -z "$folder" ]; then
		sudo nmap -n --open -F -sS $ipList
	else
		mkdir $folder
		cd $folder
		sudo nmap -n --open -F -sS $ipList -oA $folder
	fi
}

p () {
	inputIP $1
	inputFolderName
	if [ -z "$folder" ]; then
		sudo nmap -n -Pn -F --open -sS $ipList
	else
		mkdir $folder
		cd $folder
		sudo nmap -n -Pn -F --open -sS $ipList -oA $folder
	fi
}

va () {
	inputIP $1
	inputFolderName
	if [ -z "$folder" ]; then
		sudo nmap -n -Pn --open -F -sS -sV $ipList
	else
		mkdir $folder
		cd $folder
		sudo nmap -n -Pn --open -F -sS -sV $ipList -oA $folder	
	fi
}

vp () {
	inputIP $1
	inputPort $2
	inputFolderName
	if [ -z "$folder" ]; then
		sudo nmap -n -Pn --open -sS -sV -p $(echo $portList) $ipList
	else
		mkdir $folder
		cd $folder
		sudo nmap -n -Pn --open -sS -sV -p $(tr '\n' , <$portList) $ipList -oA $folder
	fi
}


#Input function for interactive option --------------------------------------------------------------------------------
addIP () {
	filePath=""
	echo "Do you want to add a file with a list of IP addresses? (Y/n):"
	read listIPAdd
	if [ $listIPAdd == "Y" ]; then
		echo "Enter file path:"
		read filePathTmp
		filePath=$filePathTmp
	elif [ $listIPAdd == "n" ]; then
		echo "Enter IP address:"
		read ipAdd
		echo $ipAdd > tempIpAdd.txt
		filePath="tempIpAdd.txt"
	else
		echo "Invalid option"
	fi
}
addPort () {
	portPath=""
	echo "Do you want to add a file with a list of ports? (Y/n):"
	read listPortAdd
	if [ $listPortAdd == "Y" ]; then
		echo "Enter file path:"
		read filePathTmp
		portPath=$filePathTmp
	elif [ $listPortAdd == "n" ]; then
		echo "Enter ports:"
		echo "Format: portNum1,portNum2,...,portNumN"
		read portNum
		echo $portNum > tempPortNum.txt
		portPath="tempPortNum.txt"

	else
		echo "Invalid option"
	fi

}




