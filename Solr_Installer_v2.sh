#!/bin/sh

#Solr Installer for RedHat

# Detects which OS and if it is Linux then it will detect which Linux
# Distribution.
#Check if OS is RedHAt as script only runs on RedHat

OS=`uname -s`
REV=`uname -r`
MACH=`uname -m`

GetVersionFromFile()
{
    VERSION=`cat $1 | tr "\n" ' ' | sed s/.*VERSION.*=\ // `
}

if [ "${OS}" = "Darwin" ]; then
    OIFS="$IFS"
    IFS=$'\n'
    set `sw_vers` > /dev/null
    DIST=`echo $1 | tr "\n" ' ' | sed 's/ProductName:[ ]*//'`
    VERSION=`echo $2 | tr "\n" ' ' | sed 's/ProductVersion:[ ]*//'`
    BUILD=`echo $3 | tr "\n" ' ' | sed 's/BuildVersion:[ ]*//'`
    OSSTR="${OS} ${DIST} ${REV}(SORRY_NO_PSEUDONAME ${BUILD} ${MACH})"
    IFS="$OIFS"

elif [ "${OS}" = "SunOS" ] ; then
    OS=Solaris
    ARCH=`uname -p` 
    OSSTR="${OS} ${REV}(${ARCH} `uname -v`)"

elif [ "${OS}" = "AIX" ] ; then
    OSSTR="${OS} `oslevel` (`oslevel -r`)"
elif [ "${OS}" = "Linux" ] ; then
    KERNEL=`uname -r`
    if [ -f /etc/redhat-release ] ; then
        DIST='RedHat'
        PSUEDONAME=`cat /etc/redhat-release | sed s/.*\(// | sed s/\)//`
        REV=`cat /etc/redhat-release | sed s/.*release\ // | sed s/\ .*//`
    elif [ -f /etc/SuSE-release ] ; then
        DIST=`cat /etc/SuSE-release | tr "\n" ' '| sed s/VERSION.*//`
        REV=`cat /etc/SuSE-release | tr "\n" ' ' | sed s/.*=\ //`
    elif [ -f /etc/mandrake-release ] ; then
        DIST='Mandrake'
        PSUEDONAME=`cat /etc/mandrake-release | sed s/.*\(// | sed s/\)//`
        REV=`cat /etc/mandrake-release | sed s/.*release\ // | sed s/\ .*//`
    elif [ -f /etc/debian_version ] ; then
        DIST="Debian `cat /etc/debian_version`"
        REV=""
    elif [ -f /etc/UnitedLinux-release ] ; then
        DIST="${DIST}[`cat /etc/UnitedLinux-release | tr "\n" ' ' | sed s/VERSION.*//`]"
    fi
    
    OSSTR="${OS} ${DIST} ${REV}(${PSUEDONAME} ${KERNEL} ${MACH})"

fi

echo ${OSSTR}

if [ ! ${DIST} = 'RedHat' ]; then
    echo ""
    echo "Sorry this script only runs on RedHat."
    echo "=========================================="
    echo ""
    exit -1
fi


# Check if I am root user - comes handy for the install
if [[ ! `whoami` = "root" ]]; then
    echo ""
    echo "You must have administrative privileges to run this script."
    echo "Log in as root or use sudo and try again."
    echo "=========================================="
    echo ""
    exit 1
else 
    echo ""
    echo "You are an administrator. "
    echo "The application will be installed as root."
    echo "=========================================="
    echo ""
fi

# Chech if java is already installed and if it is 1.8 or higher - if not, install Java 1.8
boolInstallJava=0

if type -p java; then
    echo Found Java.
    _java=java
elif [[ -n "$JAVA_HOME" ]] && [[ -x "$JAVA_HOME/bin/java" ]];  then
    echo Found Java.
    _java="$JAVA_HOME/bin/java"
else
    echo ""
    echo "No Java found."
    boolInstallJava=1
fi


if [[ "$_java" ]]; then
    version=$("$_java" -version 2>&1 | awk -F '"' '/version/ {print $2}')
    echo Version "$version"
fi

    if [[ "$version" > "1.7" ]] && [[ $boolInstallJava -ne 1 ]]; then
        echo "We are good to go."
    else
        echo ""
        echo "Java will now be installed"
        yes | yum install java-1.8.0-openjdk.x86_64
    fi



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

#echo -n "Enter the Solr username: "
#read uname

#echo -n "Enter the Solr user password: "
#read -s password

#adduser "$uname"
#echo $uname:$pw | sudo chpasswd

#gpasswd wheel -a $uname > /dev/null
adduser solr
passwd -d solr
gpasswd wheel -a solr




    echo "Created Solr user"
    echo "=========================================="
    echo ""

# Run Solr installer

#sudo ./install_solr_service.sh solr-6.3.0.tgz

script -c "su - solr -c sudo /opt/install_solr_service.sh /opt/solr-6.3.0.tgz"

#su - solr -c "sudo /opt/install_solr_service.sh /opt/solr-6.3.0.tgz"

echo "Installed Solr successfully"
    echo "=========================================="
    echo ""

echo "Making Solr start automatically after reboot"
chkconfig --add solr
chkconfig | grep solr

echo "Changing /var/solr owner to solr user"
sudo chown -R solr:solr /var/solr/

echo "Let's run a few tests"
echo "Creating a new test core"
sudo su - solr -c "/opt/solr/bin/solr create -c Kilgore_was_here_Test_Core -n data_driven_schema_configs"

echo "Restarting the Solr service"

sudo service solr restart

sudo service solr status

echo "Head over to your browser and open something like: "
echo "http://<solr_server>:8983/solr/#/"
echo "Check if the Admin is up and you can see the core"
