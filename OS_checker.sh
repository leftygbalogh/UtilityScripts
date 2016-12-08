#!/bin/sh
#which yum && ^Cecho Fedora;
     which yum >/dev/null && { echo Fedora; exit 0; }
     which zypper >/dev/null && { echo Suse; exit 0; }
     which apt-get >/dev/null && { echo Debian;  exit 0;}
echo Some funny OS;
exit 1;
