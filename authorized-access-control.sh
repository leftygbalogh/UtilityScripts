#!/bin/bash
#Ensure that only authorized users can access the SUF and machine processes have free access from  authorized network-IPs
export sessionID=$(who am i | cut -d'/' -f2 | cut -d' ' -f1)
mkdir -p "/var/lib/git-committer/"
nameFile="/var/lib/git-committer/nameSignumFile$sessionID"
originatingIP=$(echo $SSH_CONNECTION | cut -d' ' -f1)
serverPort=$(echo $SSH_CONNECTION | cut -d' ' -f4)
authorizedusers=/tmp/authorized-users

[ -e "$nameFile" ] || touch "$nameFile"

#Allow network internal addresses to access the SUF
    if [[ $(cat /tmp/network-IPs | grep -w $originatingIP | cut -d':' -f2) = "internal" ]];
        then
            echo "Internal network access. Allow passthrough.";
            date;
            echo "Originating IP: $originatingIP";

#Require network external addresses to use an authorized user
        else
            echo "Network external address";
            date;
            echo "Originating IP: $originatingIP";

            # Collect username
            dialog --inputbox "Enter your ID\n" 8 40 2>"$nameFile";
            clear

            username=$(cat "$nameFile")

            #Check if user is authorized to access the system.
            if [[ $(cat "$authorizedusers" | grep -i -w $username | cut -d':' -f2) = "authorized" ]];

            then
                echo "Welcome home, commander $username.";

            else
                clear;
                echo "We've got a bogie at $(date +"%H") o'clock. Bogie arrived from $originatingIP.";
                echo $(exit -1);

            fi
    fi

    export "HISTFILE=/var/log/$username-history";
    export PS1="[\u@\h \w]\$ \[$(tput sgr0)\]";
