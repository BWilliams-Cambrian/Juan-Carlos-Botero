#!/bin/bash


#install the members package that is used to list the users in a group
sudo apt install members

#clear the screen
clear

#Store all the members of the IT group in a variable
ITmembers=$(members IT)

#Counts how many members are in the IT group
userqty=$(echo -n "$ITmembers" | wc -w)

#Show a list of the members that will have access to internet after the script is completed.
echo "These are the users in the IT group. They will have access to internet:"
for value in $ITmembers
do
	
	echo $value
	sudo iptables -A OUTPUT -p tcp --dport 443 -m owner --uid-owner $value -j ACCEPT	#Create the exceptions for the IT members
	
done	

# Add the local web server as an exception so everybody can access it.
sudo iptables -A OUTPUT -p tcp --dport 443 -d 192.168.2.3 -j ACCEPT

# Drop all the traffic through the ports 80 and 443 used by internet
sudo iptables -t filter -A OUTPUT -p tcp --dport 80 -j DROP
sudo iptables -t filter -A OUTPUT -p tcp --dport 443 -j DROP

#Display a message indicating how many users have access to internet.
echo " There are $userqty users with internet access"

