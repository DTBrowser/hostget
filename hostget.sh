#!/bin/bash
if [ "$1" == "" ]
then
	echo -e "\e[0;32m\t**********************************************************************"
	echo -e "\t\t\t\tCreated by:\e[0m \e[1;34mDTBrowser\e[0m"
	echo -e "\e[0;32m\t**********************************************************************\n"
	echo -e "\e[1;33mUsage:\e[0m \e[0;32m$0 url\e[0m"
	echo -e "\e[1;33mExample:\e[0m \e[0;32m$0 domain.com\e[0m"
else
		echo -e "\e[0;32m**********************************************************************" > file.txt
		echo -e "\e[1;33mDOMAINS\e[0m" >> file.txt
		echo -e "\e[0;32m**********************************************************************" | tee -a file.txt
		echo -e "\e[1;33m\t\t\tSEARCHING FOR HOSTS\e[0m" 
		echo -e "\e[0;32m**********************************************************************\n"
		wget --user-agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.45 Safari/537.36" -P /tmp/ $1 2>/dev/null; grep href /tmp/index.html | cut -d "/" -f3 | grep "\." | cut -d '"' -f1 | egrep -v "<" | sort -u > /tmp/hosts.txt; rm -f /tmp/index.html
		echo -e "\e[0;32m$(cat /tmp/hosts.txt)\n\e[0m" | tee -a file.txt
		echo -e "\e[1;33m\t\t\tRESOLVING IP ADDRESS\e[0m"
		echo -e "\e[0;32m**********************************************************************" | tee -a file.txt
		echo -e "\e[1;33mIP\e[0m" >> file.txt
		echo -e "\e[0;32m**********************************************************************" >> file.txt
		echo -e "\e[0;32m$1: $(host $1 | grep 'has address' | cut -d ' ' -f4)\e[0m" | tee -a file.txt 
		for domain in $(cat /tmp/hosts.txt)
		do
		echo -e "\e[0;32m$domain: $(host $domain | grep 'has address' | cut -d ' ' -f4)\e[0m" | tee -a file.txt
		done
		echo -e "\e[1;33mOUTPUT: file.txt"
fi
