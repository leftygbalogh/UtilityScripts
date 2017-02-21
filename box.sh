#!/bin/bash

dialog --inputbox "Enter your E/// signum or full name:" 8 40 2>/tmp/nameSignumFile;
export gitName=$(cat /tmp/nameSignumFile)
echo $gitName

dialog --inputbox "Enter your email address:" 8 40 2>/tmp/emailFile;
export gitEmail=$(cat /tmp/emailFile)
echo $gitEmail

/usr/local/git/bin/git config --global user.name $gitName
#git config --global user.email $gitEmail

/usr/local/git/bin/git config --global user.name
#git config --global user.email
echo "Awesome.  Carry on soldier."
