#!/bin/bash
watcherfile="/var/lib/git-committer/watcher.sh"
logfile="/var/log/git-committer/file-change-events-$(date +%Y%m%d).log"

#kill the inotifywait process gracefully, it also terminates the old watcher process
echo "I am the new restarter script" >> $logfile
echo "I am killing all watchers and inotify scripts." >> $logfile
killall inotifywait || killall watcher.sh

#echo $inotifyPID >> $logfile

#inotifyPID=$1
#kill $inotifyPID

sleep 3

#restart the watcher to pick up the new file list
$watcherfile&
