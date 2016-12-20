#!/bin/sh

DIR=/opt/
URL=http://archive.apache.org/dist/lucene/solr/6.3.0/solr-6.3.0.tgz

cd $DIR
curl -O $URL --retry 5

file="/opt/solr-6.3.0.tgz"
if [ -f "$file" ]
then
	echo "$file found."
else
	echo "$file not found."
fi
