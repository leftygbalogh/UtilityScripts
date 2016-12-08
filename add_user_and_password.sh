#!/bin/sh

echo -n "Enter the username: "
read uname

echo -n "Enter the password: "
read -s passwd

adduser "$uname"
echo "$password" | passwd "$uname" --stdin

# add this in there somehow: 
# sudo adduser existing_user sudo
# gpasswd wheel -a username

#Debian
#echo $uname:$passwd | chpasswd