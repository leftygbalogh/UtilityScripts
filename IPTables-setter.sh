#!/bin/bash
#Setting IPTABLES for closed environment

#Set default to REJECT
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT


#Accept loopback connections
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

#Allow related/established traffic in and out
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -m conntrack --ctstate ESTABLISHED -j ACCEPT

#Allow HTTP and HTTPS
iptables -A INPUT -p tcp -m multiport --dports 80,443 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp -m multiport --dports 80,443 -m conntrack --ctstate ESTABLISHED -j ACCEPT

#Allow traffic from specific IPs
iptables -A INPUT -s 136.225.208.158 -j ACCEPT
iptables -A INPUT -s 136.225.58.55 -j ACCEPT
iptables -A INPUT -s 10.216.186.11 -j ACCEPT
iptables -A INPUT -s 10.216.186.12 -j ACCEPT
iptables -A INPUT -s 10.216.186.13 -j ACCEPT
iptables -A INPUT -s 10.216.186.14 -j ACCEPT
iptables -A INPUT -s 10.216.186.15 -j ACCEPT
iptables -A INPUT -s 10.216.186.16 -j ACCEPT
iptables -A INPUT -s 10.216.186.17 -j ACCEPT
iptables -A INPUT -s 10.216.186.18 -j ACCEPT
iptables -A INPUT -s 10.216.186.19 -j ACCEPT
iptables -A INPUT -s 10.216.186.21 -j ACCEPT
iptables -A INPUT -s 10.216.186.22 -j ACCEPT
iptables -A INPUT -s 10.216.186.23 -j ACCEPT
iptables -A INPUT -s 10.216.186.24 -j ACCEPT
iptables -A INPUT -s 10.61.172.82 -j ACCEPT
iptables -A INPUT -s 10.61.152.144 -j ACCEPT

iptables -A INPUT -j REJECT
iptables -A OUTPUT -j REJECT

echo "Done"
