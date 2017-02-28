#!/bin/sh

/usr/local/git/bin/git init /tmp/

gitWatchDate=$(date)
opened="FALSE"
modified="FALSE"
closed="FALSE"

echo "Git watch is being initiated on $gitWatchDate"

#inotifywait --format "%w%f" --event modify /tmp/ \
#| while read FILE; do

#inotifywait --monitor --quiet --format "%w%f %f %w" --event modify /tmp \
inotifywait --monitor --quiet --format "%w%f %f %w %e" --outfile /home/ebalgza/inotify.log --fromfile /home/ebalgza/inotifyfile.list \

| while read OUTPUT; do

    echo $OUTPUT
    FILE=$(echo $OUTPUT | cut -d' ' -f1)
        echo $FILE
    bareFile=$(echo $OUTPUT | cut -d' ' -f2)
        echo $bareFile
    folder=$(echo $OUTPUT | cut -d' ' -f3)
        echo $folder
    event=$(echo $OUTPUT | cut -d' ' -f4)
        echo $event

#
#    if [[ $FILE == "/tmp/target.cfg" ]]; then
#        echo "Running script: $0"
#        echo "File modified: $FILE"
#
#        echo $sessionID " is the session ID"
#
#        echo $FILE > /tmp/modifiedFileNameFile$sessionID
#
#        export gitName=$(cat /tmp/nameSignumFile$sessionID)
#        echo $gitName
#
#        export gitEmail=$(cat /tmp/emailFile$sessionID)
#        echo $gitEmail
#
#        echo "Adding user to git"
#        /usr/local/git/bin/git config --global user.email $gitEmail
#        /usr/local/git/bin/git config --global user.email
#
#        /usr/local/git/bin/git config --global user.name $gitName
#        /usr/local/git/bin/git config --global user.name
#
#        echo "Staging and committing $bareFile to git"
#        cd $folder
#        /usr/local/git/bin/git add $bareFile
#        /usr/local/git/bin/git commit $bareFile --message="$gitName ($gitEmail) modified $bareFile in $folder on $(date)"
#
#        echo "Removing user from git"
#        /usr/local/git/bin/git config --global --unset user.email
#        /usr/local/git/bin/git config --global --unset user.name
#
#        /usr/local/git/bin/git config --global user.email
#        /usr/local/git/bin/git config --global user.name
#
#    fi
done
