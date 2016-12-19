#!/bin/sh
echo -n "Enter the Solr username: "
read uname

echo -n "Enter the Solr user password: "
read -s passwd

adduser "$uname"
echo $uname:$passwd | sudo chpasswd

gpasswd wheel -a $uname
