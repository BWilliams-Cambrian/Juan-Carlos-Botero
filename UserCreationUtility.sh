#!/bin/bash

# clears the screen
clear

# declare variables to know how many users and groups were created

newuserscount=0
newgroupscount=0

# change the IFS to a comma to use it with the csv file
IFS=","

#while loop to read the csv file and store each entity on 3 variables called first(for first name), last(for last name), dept(for department)
while  read  first last dept
do
  if [ $first != "FirstName" ]  				# avoid the header
  then
  	first=$(echo $first | tr '[:upper:]' '[:lower:]') 	# convert the first name to lowercase
  	last=$(echo $last | tr '[:upper:]' '[:lower:]') 	#convert the last name to lowercase
  	dept=$(echo $dept | tr -d '\r') 			# remove the ^M operator from the department column. This is because the file is coming from Windows
  	user=${first:0:1}${last:0:7} 				# creates the username with the first name letter and 7 firsts lasts names letters 
  	  	
  	if id "$user" &>/dev/null 				#check if the user exits
  	then
    		echo "The user $user already exits" 		#display an error message if the user exists
	else
    		sudo useradd $user 				# add the user
    		let newuserscount++ 				#increment the counter of user created by 1
  		if  grep -q $dept /etc/group 			#check if the group exits 
  		then
  			echo "The $dept group already exits"	#display an error message if the group exists
  		else 
  			sudo groupadd $dept			#create the group
  			let newgroupscount++           	#increment the counter of groups created by 1
    		fi 
    		sudo usermod -g ${dept} ${user}		#assign the primary group to the user base on their department
	fi
		
   fi	
done < EmployeeNames.csv

echo "$newuserscount new users were created" 			#display how many users were created
echo "$newgroupscount new groups were created"		#display how many groups were created

