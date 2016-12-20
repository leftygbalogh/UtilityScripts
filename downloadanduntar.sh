#!/bin/sh
# Download Solr and check if file has indeed been downloaded to /opt/
DIR=/opt/
VERSION="6.3.0"
URL=http://archive.apache.org/dist/lucene/solr/$VERSION/solr-$VERSION.tgz

cd $DIR
echo ""
echo "Downloading Solr from the Apache Archives"
curl -O $URL --retry 5

file="/opt/solr-6.3.0.tgz"
if [ -f "$file" ]
then
        echo ""
        echo "Solr successfully downloaded."
        echo "=========================================="
        echo ""
else
        echo "Solr could not be downloaded. Weird, init?!"
        echo "Exitin sadly, quoth Mandarax"
        echo
        echo "So long, old pal. "
        echo "You’re going to a different world now."
        echo "It’s sure to be a better one, "
        echo "since no other world could be as bad as this one is."
        echo ""
fi

tar zxf solr-$VERSION.tgz
	echo ""
    echo "Removing bubblewrap from Solr"
    echo "=========================================="
    echo ""
cp /opt/solr-$VERSION/bin/install_solr_service.sh .
rm -rf solr-$VERSION
	echo ""
	echo "Ready for Solr installer"
    echo "=========================================="
    echo ""

echo "Lef"
    echo -n "Enter the Solr username: "
read uname

echo -n "Enter the Solr user password: "
read -s passwd

adduser "$uname"
echo $uname:$passwd | sudo chpasswd

gpasswd wheel -a $uname > /dev/null
    
    echo "=========================================="
    echo ""