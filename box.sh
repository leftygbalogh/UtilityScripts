#!/bin/sh

echo "I am in box.sh"
echo "Running script: $0"
echo "File modified: $fileName"
sleep 5

dialog --title "A system file ($fileName) has been changed" --yesno "Have you modified a config file?" 8 40
if [ "$?" = "0" ]
    then
dialog --inputbox "Enter your E/// signum or full name:" 8 40 2>/tmp/nameSignumFile;
export gitName=$(cat /tmp/nameSignumFile)
dialog --inputbox "Enter your email address:" 8 40 2>/tmp/emailFile;
export gitEmail=$(cat /tmp/emailFile)
dialog --inputbox "Why did you change the file?" 8 40 2>/tmp/reasonFile;
export gitMessage=$(cat /tmp/reasonFile)

git config --unset --global user.name
git config --unset --global user.email
git config --global user.name $gitName
git config --global user.email $gitEmail
  fi

clear
cat reasonFile
git config --global user.name
git config --global user.email
echo "Awesome.  Carry on soldier."
