#!/bin/sh
#this script runs indefinitely and MUST be started at reboot
gitWatchDate=$(date)
opened="FALSE"
modified="FALSE"
closed="FALSE"
logfile="/var/log/git-committer/file-change-events-$(date +%Y%m%d).log"
filelist="/etc/opt/git-committer/filestowatch.list"

#Create the very first log if necessary
[ -e $logfile ] || touch $logfile

echo "Git watch is being initiated on $gitWatchDate" >> $logfile
#all the above is executed only once per run

inotifywait --monitor --quiet --format "%w%f %w %f %e" --outfile $logfile --fromfile $filelist | while read OUTPUT; do

#create log file if it does not exist for the day
[ -e "/var/log/git-committer/file-change-events-$(date +%Y%m%d).log" ] || touch "/var/log/git-committer/file-change-events-$(date +%Y%m%d).log"

#update date based filename
logfile="/var/log/git-committer/file-change-events-$(date +%Y%m%d).log"
    echo "macika" >> "$logfile"
    echo $OUTPUT >> $logfile
    FILE=$(echo $OUTPUT | cut -d' ' -f1)
        echo $FILE >> $logfile
    event=$(echo $OUTPUT | cut -d' ' -f2)
        echo $event >> $logfile
        echo "$filelist" >> $logfile


    if [[ $FILE == "$filelist" ]]; then
        #statements
        echo "we need to restart the file if if was changed." >> $logfile
    fi


done
