#!/bin/sh
inotifywait --monitor --quiet --format "%w%f %f %w %e" --outfile /home/ebalgza/inotify.log --fromfile /home/ebalgza/inotifyfile.list &
