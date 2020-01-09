#!/bin/bash

URL=$1
IP="127.0.0.1"
THEPATH=`pwd`
BEDROCK=0
MAMPVHOST="/Applications/MAMP/conf/apache/extra/httpd-vhosts.conf"

while getopts p:bi: option
do
	case ${option}
		in
		p) THEPATH=${OPTARG};; 
		b) BEDROCK=1;;
		i) IP=${OPTARG};;
	esac
done

# add to /etc/hosts (sudo)
echo -e "$IP \t $URL" >> /etc/hosts

if [ $BEDROCK = 1 ] 
then
	THEPATH="${THEPATH}/web"
fi

echo $THEPATH
echo -e "\n" >> $MAMPVHOST 
echo -e "<VirtualHost *:80>" >> $MAMPVHOST
echo -e "    ServerAdmin webmaster@dummy.com" >> $MAMPVHOST
echo -e "    DocumentRoot \"$THEPATH\"" >> $MAMPVHOST
echo -e "    ServerName $URL" >> $MAMPVHOST
echo -e "</VirtualHost>" >> $MAMPVHOST
