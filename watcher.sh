#!/bin/sh

$(which git) init /tmp/

gitWatchDate=$(date)
echo "Git watch is being initiated on $gitWatchDate"

inotifywait --format "%w%f" --event modify /tmp/ \
| while read FILE; do
    if [[ $FILE == "/tmp/target.cfg" ]]; then
        echo "Running script: $0"
        echo "File modified: $FILE"

        echo $sessionID " is the session ID"

        echo $FILE > /tmp/modifiedFileNameFile$sessionID

        export gitName=$(cat /tmp/nameSignumFile$sessionID)
        echo $gitName

        export gitEmail=$(cat /tmp/emailFile$sessionID)
        echo $gitEmail

        echo "Adding user to git"
        $(which git) config --global user.email $gitEmail
        $(which git) config --global user.email

        $(which git) config --global user.name $gitName
        $(which git) config --global user.name

        echo "Staging and committing $FILE to git"
        $(which git) add $FILE
        $(which git) commit

        echo "Removing user from git"
        $(which git) config --global --unset user.email
        $(which git) config --global --unset user.name

        $(which git) config --global user.email
        $(which git) config --global user.name

        exit -7
    fi
    echo "Skipped file change"
    exit -8
done
