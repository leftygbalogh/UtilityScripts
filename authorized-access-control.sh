#!/bin/bash


dialog --inputbox "Enter your ID\n" 8 40 2>"/tmp/nameFile"
username=$(cat /tmp/nameFile)
originatingIP=$(echo $SSH_CONNECTION | cut -d' ' -f1)

if [[ $(cat /tmp/authorized-users | grep -w $username | cut -d':' -f2) = "authorized" ]]; then echo "yes"; else echo "no"; fi

if [[ $(echo $(cat /tmp/network-IPs | grep -w $(echo $SSH_CONNECTION | cut -d' ' -f1)) | cut -d' ' -f2) = "authorized" ]]; then echo "yes"; else echo "no"; fi
