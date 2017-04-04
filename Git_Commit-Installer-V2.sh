#!/bin/bash

# Install dialog utility
yes | yum install dialog

# Install a later version of Git
# and its dependencies

yes | yum install curl-devel expat-devel gettext-devel openssl-devel zlib-devel
yes | yum install gcc perl-ExtUtils-MakeMaker
rpm -e --nodeps git #yes | yum remove git

cd /tmp/
wget https://www.kernel.org/pub/software/scm/git/git-2.11.1.tar.gz
tar xzf git-2.11.1.tar.gz
cd git-2.11.1/
make prefix=/usr/ all
make prefix=/usr/ install

echo "export PATH=$PATH:/usr/bin" >> /etc/bashrc
source /etc/bashrc
git --version
rm -rf /tmp/git*
#===git install is complete===

# Install inotify utility
cd /tmp/
wget http://dl.fedoraproject.org/pub/epel/7/x86_64/i/inotify-tools-3.14-8.el7.x86_64.rpm

yes | yum install inotify-tools-3.14-8.el7.x86_64.rpm
rm -f inotify-tools-3.14-8.el7.x86_64.rpm
#===inotify utilities complete===

# Create log and variable directories and files

##Create a directory for session specific data

mkdir -p /var/lib/git-committer

## Create watcher script and make it executable
[ -e "/var/lib/git-committer/watcher.sh" ] || touch "/var/lib/git-committer/watcher.sh"
chmod +x /var/lib/git-committer/watcher.sh

##TODO add/paste actual script into it



##Create a directory for app logs
mkdir -p /var/log/git-committer

##Initialise log file
[ -e "/var/log/git-committer/file-change-events-$(date +%Y%m%d).log" ] || touch "/var/log/git-committer/file-change-events-$(date +%Y%m%d).log"


##Create file to contain list of files to watch and commit
mkdir -p /etc/opt/git-committer
[ -e "/etc/opt/git-committer/filestowatch.list" ] || touch "/etc/opt/git-committer/filestowatch.list"

##TODO add/appent actual list to it
## echo /tmp/target.cfg >> /etc/opt/git-committer/filestowatch.list
#===file and dirs done===



#start file and add @reboot cronjob
