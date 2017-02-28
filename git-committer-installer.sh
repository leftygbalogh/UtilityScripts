#!/bin/bash

# Install dialog utility
yes | yum install dialog

# Install a later version of git
# and its dependencies

yes | yum install curl-devel expat-devel gettext-devel openssl-devel zlib-devel
yes | yum install gcc perl-ExtUtils-MakeMaker
yes | yum remove git

cd /tmp/
wget https://www.kernel.org/pub/software/scm/git/git-2.11.1.tar.gz
tar xzf git-2.11.1.tar.gz
cd git-2.11.1/
make prefix=/usr/local/sbin all
