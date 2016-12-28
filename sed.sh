#!/bin/sh

sed -i -e 's/Defaults    requiretty.*/ #Defaults    requiretty/g' /etc/sudoers

sed -i.bak -e 's/Defaults    requiretty.*/#Defaults    requiretty/g' /etc/sudoers
