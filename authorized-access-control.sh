#!/bin/bash
#Ensure that only authorized users can access the SUF and machine processes have free access from  authorized network-IPs

#Variables of all shapes and sizes
export sessionID=$(who am i | cut -d'/' -f2 | cut -d' ' -f1)
mkdir -p "/var/lib/git-committer/"
nameFile="/var/lib/git-committer/nameSignumFile$sessionID"
originatingIP=$(echo $SSH_CONNECTION | cut -d' ' -f1)
serverPort=$(echo $SSH_CONNECTION | cut -d' ' -f4)
authorizedusers=/tmp/authorized-users
thisServersIP=$(hostname -i)
originatingServerName=$(nslookup $(echo $SSH_CONNECTION | cut -d' ' -f1) | grep "name = " | cut -d'=' -f2 | xargs | cut -d'.' -f1)
authorizedMachine="FALSE"
authorizedUser="FALSE"
[ -e "$nameFile" ] || touch "$nameFile"

echo $sessionID sessionID
echo $nameFile nameFile
echo $originatingIP originatingIP
echo $serverPort serverPort
echo $authorizedusers authorizedusers
echo $thisServersIP thisServersIP
echo $originatingServerName originatingServerName
echo $authorizedMachine authorizedMachine
echo $authorizedUser authorizedUser


#Check if serve name is in authorized list
if [[ $(cat /tmp/serverlistbyname | grep -w $originatingServerName | cut -d':' -f2) = "authorized" ]];
then
    echo "Access to server: $originatingServerName granted.";
    date;
    authorizedMachine="YES"
fi

#Allow network internal addresses to access the SUF
if [[ $(cat /tmp/network-IPs | grep -w $originatingIP | cut -d':' -f2) = "internal" ]];
then
    echo "Internal network access. Allow passthrough.";
    date;
    echo "Originating IP: $originatingIP";
    authorizedMachine="YES"
fi

echo authorizedMachine: $authorizedMachine

#Require network external addresses to use an authorized user
if [[ authorizedMachine = "FALSE" ]];
then
    echo "Network external address";
    date;
    echo "Originating IP: $originatingIP";
    echo "Originating Server Name: $originatingServerName"

    # Collect username
    dialog --inputbox "Enter your ID\n" 8 40 2>"$nameFile";
    clear

    username=$(cat "$nameFile")
fi

#Check if user is authorized to access the system.
if [[ authorizedMachine = "FALSE" ]] && [[ $(cat "$authorizedusers" | grep -i -w $username | cut -d':' -f2) = "authorized" ]];

then
    authorizedUser="TRUE"
    export "HISTFILE=/var/log/$username-history";
    echo "Welcome home, commander $username.";
fi


if [[ authorizedMachine = "FALSE" ]] && [[ authorizedUser="FALSE" ]];
then
    clear;
    echo "We've got a bogie: $username at $(date) from $originatingIP, $originatingServerName." | mail -s "Unauthorized Access attempt at $thisServersIP" -r Zeb@$originatingServerName geza.balogh@ericsson.com ;
    echo "Hate to see you leave... Good bye."
    exit;
fi

    export PS1="[\u@\h \w]\$ \[$(tput sgr0)\]";
