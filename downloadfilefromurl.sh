#!/bin/sh

DIR=/opt/

# wget output file
FILE=solr.tgz

# wget log file
LOGFILE=download.log

# wget download url
URL=http://www-us.apache.org/dist/lucene/solr/6.3.0/solr-6.3.0.tgz

cd $DIR
sudo wget $URL -O $FILE -o $LOGFILE
