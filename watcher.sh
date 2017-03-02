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
{
    echo ""
    echo "+-------------------------------------------+"
    echo "Git watch is being initiated on $gitWatchDate"
    echo "Current logfile: $logfile"
    echo "Current list of watched files is in: $filelist"
    echo "list of files:"
    cat $filelist
    echo ""
    echo "Currently logged in users:"
    w -i
    last | grep "still" | sort
    echo "+-------------------------------------------+"
    echo ""
} >> $logfile

#all the above is executed only once per run

inotifywait --monitor --quiet --format "%w%f %e" --fromfile $filelist | while read OUTPUT; do

#create log file if it does not exist for the day
[ -e "/var/log/git-committer/file-change-events-$(date +%Y%m%d).log" ] || touch "/var/log/git-committer/file-change-events-$(date +%Y%m%d).log"

#update date based filename
logfile="/var/log/git-committer/file-change-events-$(date +%Y%m%d).log"

{
    echo $(date) $OUTPUT
    filename=$(echo $OUTPUT | cut -d' ' -f1)
    echo $filename
    event=$(echo $OUTPUT | cut -d' ' -f2)
    echo $event

    if [ $event == "OPEN" ]; then
        opened="TRUE"
    fi

    if [ $event == "MODIFY" ]; then
        modified="TRUE"
    fi

    if [ $event == "CLOSE_WRITE,CLOSE" ]; then
        closed="TRUE"
    fi

    if [ $opened == "TRUE" ] &&  [ $modified == "TRUE" ] && [ $closed == "TRUE"  ]; then
        echo "$filename has been changed."
        echo "Time to call the ghost busters"
    fi

} >> $logfile
done
