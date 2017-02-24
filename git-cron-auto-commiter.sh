#!/bin/sh

PATH=/usr/local/git/bin/git:"$PATH"

date
git status
echo "========baseline status==============="
read -n 1 -s

gitFolder=/tmp
username='Rodimus Prime'
useremail="autobots@inv.ericsson.commit"
cd $gitFolder
git config --global --replace-all user.name $username
git config --global user.email $useremail

gitFileList=$(git status | grep "modified: " | cut -d':' -f2 | xargs)
git add $gitFileList
date
git status
echo "========staged files==============="
read -n 1 -s

git commit -m "automatically commits changes daily"
echo "========commit made==============="
read -n 1 -s

git config --global --unset user.name
git config --global --unset user.email

date
git status
