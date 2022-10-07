#!/bin/bash

# This script creates a new user on the local system.
# You will be prompted to enter the username (login), the person name, and a password.
# The username, password, and host for the account will be displayed.

# Make sure the script is being executed with superuser privileges.

if [[ "${UID}" -ne 0 ]]
then
   echo 'Please run with sudo or as root.'
   exit 1
fi
# Enter username
read -p 'Enter username to begin with: ' USER_NAME

# Get name of the user (for description field)
read -p 'Enter the name of the person/application that will be using the account: ' COMMENT

# Get the password
echo 'Enter passowrd to use for the account: ' 
read -s PASSWORD

# Confirm password
echo 'Confirm the password'
read -s CONFIRM_PASSWORD

if [[ "${PASSWORD}" -ne "${CONFIRM_PASSWORD}" ]]
then 
  echo "Passwords do not match, please try again"
  exit 1
fi

#Create the account.
useradd -c "${COMMENT}" -m ${USER_NAME}
# Set the password.
echo ${PASSWORD} | passwd --stdin ${USER_NAME}
# Force password change on first login.
passwd -e ${USER_NAME}



exit 0


