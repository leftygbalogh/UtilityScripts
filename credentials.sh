#!/bin/bash

export sessionID=$(who am i | cut -d'/' -f2 | cut -d' ' -f1)

dialog --inputbox "Enter your E/// signum or full name:" 8 40 2>/tmp/nameSignumFile$sessionID;

dialog --inputbox "Enter your email address:" 8 40 2>/tmp/emailFile$sessionID;

clear
echo "Awesome.  Carry on soldier."

/home/ebalgza/watcher.sh &
