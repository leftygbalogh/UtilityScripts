#!/bin/sh

PATH=/usr/local/git/bin/git:"$PATH"
gitFolder=/tmp
username="Rodimus Prime"
useremail="autobots@inv.ericsson.commit"

gitFileList=$(git status | grep "modified: " | cut -d':' -f2 | xargs)
if [[ $gitFileList == "" ]]; then
    exit 0
fi

cd $gitFolder
git config --global --unset user.name
git config --global --unset user.email
git config --global --replace-all user.name "$username"
git config --global user.email "$useremail"

git add $gitFileList
git commit -m "automatically commits changes daily"

git config --global --unset user.name
git config --global --unset user.email
