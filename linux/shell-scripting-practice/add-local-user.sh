#!/bin/bash


# Make sure the script is being executed with superuser privileges.

userid=$UID

if [[ $userid != "0" ]]
then
    echo "Superuser priviledge is required to run the script"
    exit 1
fi 
   
# Get the username (login).

read -p "Enter the username to create:" username

# Get the real name (contents for the description field).

read -p "Enter the name of the person or application that will be using this account:" realname

# Get the password.

read -s -p "Enter the password to use for the account:" password

# Create the user with the password.

useradd -c "$realname" $username

# Check to see if the useradd command succeeded.

if [[ ${?} != 0 ]]
then 
    echo "failed to create the user"
    exit 1
fi

# Set the password.

echo "$password" | passwd --stdin $username 

# Check to see if the passwd command succeeded.

if [[ ${?} != 0 ]]
then 
   exit 1 
fi

# Force password change on first login.

passwd -e $username

# Display the username, password, and the host where the user was created.
hostname1=$(hostname)
if [[ ${?} = 0 ]]
then 
   echo "username is $username is created on the host $hostname1 whose password is $password" 
fi   
