#!/bin/sh
modified=FALSE
closed=FALSE
inotifywait --monitor --quiet --format "%w%f %f %w %e" --event modify /tmp \
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
    if [[ $FILE == "/tmp/target.cfg" ]]; then
        if [[ $event == "MODIFY" ]]; then
            modified=TRUE
            echo "File modified: $FILE"
        fi

        if [[ $event == "close_write" ]]; then
            closed=TRUE
            echo "File closed: $FILE"
        fi
    fi

    if [[ $modified == TRUE && $closed == TRUE ]]; then
        echo "Modified and closed $FILE"
    fi

done
