#!/bin/bash

export sessionID=$(who am i | cut -d'/' -f2 | cut -d' ' -f1)

dialog --title "WARNING" --msgbox "\nYou are accessing a production area." 8 40

dialog --inputbox "Enter your name or Ericsson ID:\n" 8 40 2>/tmp/nameSignumFile$sessionID;

dialog --inputbox "Enter your email address:\n" 8 40 2>/tmp/emailFile$sessionID;

clear
echo ""
echo "Awesome. Carry on soldier."
echo ""
