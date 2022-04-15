#!/bin/bash


#counter used to know how many processes are killed and show the messagge at the end
countkills=0  


#Print the 5 current processes using more CPU
echo "These are the current 5 processes using more CPU: "

ps -eAo pid,%cpu,ucmd --sort -%cpu | head -6


#Store the process ids of the 5 processes in 5 variables
processid1=$(ps -eAo pid,%cpu,ucmd --sort -%cpu | awk 'NR==2{print $1}')
processid2=$(ps -eAo pid,%cpu,ucmd --sort -%cpu | awk 'NR==3{print $1}')
processid3=$(ps -eAo pid,%cpu,ucmd --sort -%cpu | awk 'NR==4{print $1}')
processid4=$(ps -eAo pid,%cpu,ucmd --sort -%cpu | awk 'NR==5{print $1}')
processid5=$(ps -eAo pid,%cpu,ucmd --sort -%cpu | awk 'NR==6{print $1}')

#Store the usernames of who started the processes in 5 variables
username1=$(ps -p $processid1 -o user | awk 'NR==2{print $1}')
username2=$(ps -p $processid2 -o user | awk 'NR==2{print $1}')
username3=$(ps -p $processid3 -o user | awk 'NR==2{print $1}')
username4=$(ps -p $processid4 -o user | awk 'NR==2{print $1}')
username5=$(ps -p $processid5 -o user | awk 'NR==2{print $1}')


#Store the time when every process starts in 5 variables
startprocess1=$(ps -p $processid1 -o start | awk 'NR==2{print $1}')
startprocess2=$(ps -p $processid2 -o start | awk 'NR==2{print $1}')
startprocess3=$(ps -p $processid3 -o start | awk 'NR==2{print $1}')
startprocess4=$(ps -p $processid4 -o start | awk 'NR==2{print $1}')
startprocess5=$(ps -p $processid5 -o start | awk 'NR==2{print $1}')

#Take the group of the usernames (which is the correspondent department) and stores it in 5 variables
dptuser1=$(id $username1 | awk '{print $2}' | awk -F'[()]' '{print$2}')
dptuser2=$(id $username2 | awk '{print $2}' | awk -F'[()]' '{print$2}')
dptuser3=$(id $username3 | awk '{print $2}' | awk -F'[()]' '{print$2}')
dptuser4=$(id $username4 | awk '{print $2}' | awk -F'[()]' '{print$2}')
dptuser5=$(id $username5 | awk '{print $2}' | awk -F'[()]' '{print$2}')


#Ask the user to confirm before killing the processes and store the answer in the variable "confirm"
echo "Do you want to kill them? [y/n]"
read confirm


if [ $confirm = "y" ]					#If the user confirms killing the processes:
then
	fileheader=$(echo 'ProcessUsageReport-')	#Create the filename to log the information of the processes killed using the current date.
	filedate=$(date +"%m-%d-%y")
	filename=$fileheader$filedate
	
	if [ "$username1" != 'root' ]			#Check if the user who start the process is the root. If it is not the root it will kill the process and add 1 to countkill counter
	then
		kill -SIGKILL $processid1
		let countkills++
		
		killdate=$(date +"%H:%M:%S")		#Store the hour just after the process was killed
			
		if [ -f ~/$filename ]			#Check if the file to log the information already exits, if this not exists it will create it and pipe the requested data
		then
			echo "$username1 $startprocess1 $killdate $dptuser1" >> ~/$filename	#If this file already exists, it will append the log data into the next line of the file
		else
			echo "$username1 $startprocess1 $killdate $dptuser1" > ~/$filename	
		fi
	fi	
	if [ "$username2" != 'root' ]			#Check the same for every of the 5 processes
	then
		kill -SIGKILL $processid2
		let countkills++
		
		killdate=$(date +"%H:%M:%S")
		
		if [ -f ~/$filename ]
		then
			echo "$username2 $startprocess2 $killdate $dptuser2" >> ~/$filename
		else
			echo "$username2 $startprocess2 $killdate $dptuser2" > ~/$filename
		fi
	fi	
	if [ "$username3" != 'root' ]
	then
		kill -SIGKILL $processid3
		let countkills++
		
		killdate=$(date +"%H:%M:%S")
		
		if [ -f ~/$filename ]
		then
			echo "$username3 $startprocess3 $killdate $dptuser3" >> ~/$filename
		else
			echo "$username3 $startprocess3 $killdate $dptuser3" > ~/$filename
		fi			
	fi
	if [ "$username4" != 'root' ]
	then
		kill -SIGKILL $processid4
		let countkills++
		
		killdate=$(date +"%H:%M:%S")
		
		if [ -f ~/$filename ]
		then
			echo "$username4 $startprocess4 $killdate $dptuser4" >> ~/$filename
		else
			echo "$username4 $startprocess4 $killdate $dptuser4" > ~/$filename
		fi			
	fi
	if [ "$username5" != 'root' ]
	then
		kill -SIGKILL $processid5
		let countkills++
		
		killdate=$(date +"%H:%M:%S")
		
		if [ -f ~/$filename ]
		then
			echo "$username5 $startprocess5 $killdate $dptuser5" >> ~/$filename
		else
			echo "$username5 $startprocess5 $killdate $dptuser5" > ~/$filename
		fi			
	fi
	echo "$countkills processes were killed"	#Display a message at the end showing how many processes were killed
else
	exit						#If the user does not confirm killing the processes it will exit.
fi				
		
	






