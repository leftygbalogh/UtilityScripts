#!/bin/sh
 
if [[ ! `whoami` = "root" ]]; then
    echo "You must have administrative privileges to run this script."
    echo "Log in as root and try again."
    exit 1
else echo "You are an administrator. The application will be installed as root."
fi