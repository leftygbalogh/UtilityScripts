#!/bin/bash
#
# Asks for user credentials tha can be used in making git commits
# when config changes are tracked.
#

export sessionID=$(who am i | cut -d'/' -f2 | cut -d' ' -f1)

mkdir -p "/var/lib/git-committer/"
nameFile="/var/lib/git-committer/nameSignumFile$sessionID"
emailFile="/var/lib/git-committer/emailFile$sessionID"

[ -e "$nameFile" ] || touch "$nameFile"
[ -e "$emailFile" ] || touch "$emailFile"

dialog --title "WARNING" --msgbox "\nYou are accessing a production area." 8 40
hasName="TRUE"

dialog --inputbox "Enter your name or Ericsson ID:\n" 8 40 2>"$nameFile";

dialog --inputbox "Enter your email address:\n" 8 40 2>/var/lib/git-committer/emailFile$sessionID;

if [ -s "$nameFile" ] && [ -s /var/lib/git-committer/emailFile$sessionID ]; then
    clear
    echo ""
    echo "Awesome. Carry on soldier."
    echo ""

else
    /etc/profile.d/credentials.sh
fi
