#!/bin/bash
#script that starts a new itself and kills the old one - restarts itself.
date
echo $(basename $0)
echo $$
sleep 1

if ! [[ $count =~ ^[0-9]+$ ]] ; then
    export count=0
fi

echo $count

if [ $count -le 10 ]; then
    count=$(echo "$count+1" | bc)
    ./$(basename $0) && exit
fi

echo "This will be printed only when the tenth instance of script is reached"
