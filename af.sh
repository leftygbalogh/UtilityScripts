
#!/bin/sh

SOLRVERSION="6.3.0"
URL=http://archive.apache.org/dist/lucene/solr/$SOLRVERSION/solr-$SOLRVERSION.tgz

cd $DIR

curl -O $URL --retry 5 >> /tmp/Solr_Install.log 2>&1

file="/opt/solr-$SOLRVERSION.tgz"
 echo $file