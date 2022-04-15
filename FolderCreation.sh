#!/bin/bash


# Create the directories
sudo mkdir -p /home/EmployeeData/{HR,IT,Finance,Executive,Administrative,'Call Centre'}


#Assign the specific permissions for each folder
sudo chmod -R 764 /home/EmployeeData/{IT,Finance,Administrative,'Call Centre'}
sudo chmod -R 760 /home/EmployeeData/{HR,Executive}

#Assign the specific group as the owner of the specific folder
sudo chgrp HR /home/EmployeeData/HR 
sudo chgrp IT /home/EmployeeData/IT
sudo chgrp Finance /home/EmployeeData/Finance 
sudo chgrp Executive /home/EmployeeData/Executive 
sudo chgrp Administrative /home/EmployeeData/Administrative 
sudo chgrp CallCentre /home/EmployeeData/'Call Centre' 

#counts how many folders were created 
cd /home/EmployeeData
folderqty=$(echo */ | wc | awk '{print$2}')

#Display how many folders were created before exit
echo " $folderqty folders were created"





