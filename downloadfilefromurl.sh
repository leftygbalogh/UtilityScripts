#!/bin/sh

DIR=/opt/

# wget output file
FILE=solr.tgz

# wget log file
LOGFILE=download.log

# wget download url
URL=http://www-us.apache.org/dist/lucene/solr/6.3.0/solr-6.3.0.tgz

#[0-9]+

cd $DIR
sudo wget $URL -O $FILE -o $LOGFILE
sudo curl -O $URL --retry 5 -w http_code
