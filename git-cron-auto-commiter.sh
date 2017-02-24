#!/bin/bash

PATH=$PATH:/usr/local/git/bin/

echo ${PATH}
date

gitFolder=/tmp
username="Rodimus Prime"
useremail="autobots@inv.ericsson.commit"

cd $gitFolder
gitFileList=$(git status | grep "modified: " | cut -d':' -f2 | xargs)
if [[ $gitFileList == "" ]]; then
    echo "nothing to do here"
    exit 0
fi

git config --global --unset user.name
git config --global --unset user.email
git config --global --replace-all user.name "$username"
git config --global user.email "$useremail"
git add $gitFileList
git commit -m "$username automatically commits file changes several times a day."

git config --global --unset user.name
git config --global --unset user.email
