#!/bin/bash
watcherfile="/var/lib/git-committer/watcher.sh"
#kill the inotifywait process gracefully, it also terminates the old watcher process
inotifyPID=$1
kill $inotifyPID
sleep 3

#restart the watcher to pick up the new file list
$watcherfile&
