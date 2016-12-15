#!/bin/sh

LOC=`dig +short myip.opendns.com @resolver1.opendns.com`
GEO=$(curl --silent ipinfo.io/$LOC/country)

if [ $GEO = "US" ];
then echo "US:"
else echo "other"
fi
