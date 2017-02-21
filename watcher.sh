#!/bin/sh

echo "Git watch is being initiated at $gitWatchDate"

inotifywait --format "%w%f" --event modify /tmp/ & \
| while read FILE; do
    if [[ $FILE == "/tmp/target.cfg" ]]; then
        echo "Running script: $0"
        echo "File modified: $FILE"

        export fileName=$FILE
        echo $fileName

    fi
done
