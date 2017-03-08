#!/bin/sh
#this script runs indefinitely and MUST be started at reboot
gitWatchDate=$(date)
opened="FALSE"
modified="FALSE"
closed="FALSE"
fileListChanged="FALSE"
logfile="/var/log/git-committer/file-change-events-$(date +%Y%m%d).log"
filelist="/etc/opt/git-committer/filestowatch.list"
watcherfile="/var/lib/git-committer/watcher.sh"
restarter="/var/lib/git-committer/restarter.sh"

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
    echo $$ is the current PID.
    echo "Currently logged in users:"
    w -i
    last | grep "still" | sort
    echo "+-------------------------------------------+"
    echo ""
} >> $logfile

#all the above is executed only once per run

inotifywait --monitor --quiet --format "%w%f %e" --fromfile $filelist | while read OUTPUT; do

inotifyPID=$( ps -g -o  "%p %r %y %x %c" | grep "inotifywait" | cut -d ' ' -f1)

echo "inotifyPID: " >> $logfile
echo $inotifyPID >> $logfile

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

    if [ $filename == "/etc/opt/git-committer/filestowatch.list" ]; then
        fileListChanged="TRUE"
    fi

    echo "fileListChanged: $fileListChanged"
    echo "filename: $filename"
    echo "watcherfile: $watcherfile"
    echo "====================================="
} >> $logfile

#Watch the file that contains the list of files to watch
# If it changes, the who script needs to be restarted
# to reflect the changes.
    if [ $opened == "TRUE" ] &&  [ $modified == "TRUE" ] && [ $closed == "TRUE"  ] && [ $fileListChanged == "TRUE" ] && [ $filename == $filelist ]; then

        {
            echo -e "\033[1m$filename\033[0m - the list of files to watch has been changed."
            #TODO
            echo -e "\033[1mThe change needs to be committed.\033[0m"
            #TODO
            echo "Processes: watcher and inotify need to be stopped"
            #TODO
            echo "Watcher needs to be started."

            echo "inotifyPID: "
            echo $inotifyPID
            echo "This is handed over to the restarter"
        } >> $logfile


        $restarter


        #Reset flags so it is not recommitted
        opened="FALSE"
        modified="FALSE"
        closed="FALSE"
        fileListChanged="FALSE"

    fi
{
    if [ $opened == "TRUE" ] &&  [ $modified == "TRUE" ] && [ $closed == "TRUE"  ]; then
        echo "$filename has been changed."
        echo "Time to call the ghost busters"
        #TODO
        echo "The change needs to be commited."

        #Reset flags
        opened="FALSE"
        modified="FALSE"
        closed="FALSE"


    fi

} >> $logfile
done
