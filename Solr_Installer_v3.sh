#!/bin/sh

#Solr Installer for RedHat

# Detects which OS and if it is Linux then it will detect which Linux
# Distribution.
#Check if OS is RedHAt as script only runs on RedHat

OS=`uname -s`
REV=`uname -r`
MACH=`uname -m`

echo "Welcome to the one and only Kilgore Solr Installer." >> /tmp/Solr_Install.log 2>&1
tail -f /tmp/Solr_Install.log &

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

echo ${OSSTR}  >> /tmp/Solr_Install.log 2>&1

if [ ! ${DIST} = 'RedHat' ]; then
    echo "" >> /tmp/Solr_Install.log 2>&1
    echo "Sorry this script only runs on RedHat." >> /tmp/Solr_Install.log 2>&1
    echo "==========================================" >> /tmp/Solr_Install.log 2>&1
    echo "" >> /tmp/Solr_Install.log 2>&1
    exit -1
fi


# Check if I am root user - comes handy for the install
if [[ ! `whoami` = "root" ]]  >> /tmp/Solr_Install.log 2>&1; then
    echo "" >> /tmp/Solr_Install.log 2>&1
    echo "You must have administrative privileges to run this script." >> /tmp/Solr_Install.log 2>&1
    echo "Log in as root or use sudo and try again." >> /tmp/Solr_Install.log 2>&1
    echo "==========================================" >> /tmp/Solr_Install.log 2>&1
    echo "" >> /tmp/Solr_Install.log 2>&1
    exit 1
else
    echo "" >> /tmp/Solr_Install.log 2>&1
    echo "You are an administrator. " >> /tmp/Solr_Install.log 2>&1
    echo "The application will be installed as root." >> /tmp/Solr_Install.log 2>&1
    echo "==========================================" >> /tmp/Solr_Install.log 2>&1
    echo "" >> /tmp/Solr_Install.log 2>&1
fi

# Chech if java is already installed and if it is 1.8 or higher - if not, install Java 1.8
boolInstallJava=0

if type -p java; then
    echo Found Java.
    _java=java
elif [[ -n "$JAVA_HOME" ]] && [[ -x "$JAVA_HOME/bin/java" ]];  then
    echo "Found Java." >> /tmp/Solr_Install.log 2>&1
    _java="$JAVA_HOME/bin/java"
else
    echo "" >> /tmp/Solr_Install.log 2>&1
    echo "No Java found." >> /tmp/Solr_Install.log 2>&1
    boolInstallJava=1
fi


if [[ "$_java" ]]; then
    version=$("$_java" -version 2>&1 | awk -F '"' '/version/ {print $2}')
    echo Version "$version" >> /tmp/Solr_Install.log 2>&1
fi

    if [[ "$version" > "1.7" ]] && [[ $boolInstallJava -ne 1 ]]; then
        echo "We are good to go." >> /tmp/Solr_Install.log 2>&1
    else
        echo "" >> /tmp/Solr_Install.log 2>&1
        echo "Java will now be installed" >> /tmp/Solr_Install.log 2>&1
        yes | yum install java-1.8.0-openjdk.x86_64 >> /tmp/Solr_Install.log 2>&1
    fi



# Download Solr and check if file has indeed been downloaded to /opt/
DIR=/opt/
SOLRVERSION="6.3.0"
URL=http://archive.apache.org/dist/lucene/solr/$SOLRVERSION/solr-$SOLRVERSION.tgz

cd $DIR
echo ""
echo "Downloading Solr from the Apache Archives" >> /tmp/Solr_Install.log 2>&1
curl -O $URL --retry 5 >> /tmp/Solr_Install.log 2>&1

file="/opt/solr-$SOLRVERSION.tgz"
if [ -f "$file" ]
then
        echo "" >> /tmp/Solr_Install.log 2>&1
        echo "Solr successfully downloaded." >> /tmp/Solr_Install.log 2>&1
        echo "==========================================" >> /tmp/Solr_Install.log 2>&1
        echo "" >> /tmp/Solr_Install.log 2>&1
else
        echo "Solr could not be downloaded. Weird, init?!" >> /tmp/Solr_Install.log 2>&1
        echo "Exitin sadly, quoth Mandarax" >> /tmp/Solr_Install.log 2>&1
        echo "" >> /tmp/Solr_Install.log 2>&1
        echo "So long, old pal. " >> /tmp/Solr_Install.log 2>&1
        echo "You’re going to a different world now." >> /tmp/Solr_Install.log 2>&1
        echo "It’s sure to be a better one, " >> /tmp/Solr_Install.log 2>&1
        echo "since no other world could be as bad as this one is." >> /tmp/Solr_Install.log 2>&1
        echo "" >> /tmp/Solr_Install.log 2>&1
        exit 1
fi

    echo "" >> /tmp/Solr_Install.log 2>&1
    echo "Fidgeting with bubblewrap on Solr" >> /tmp/Solr_Install.log 2>&1
    echo "==========================================" >> /tmp/Solr_Install.log 2>&1
    echo "" >> /tmp/Solr_Install.log 2>&1
    tar zxf solr-$SOLRVERSION.tgz >> /tmp/Solr_Install.log 2>&1

cp /opt/solr-$SOLRVERSION/bin/install_solr_service.sh .
rm -rf solr-$SOLRVERSION
    echo "" >> /tmp/Solr_Install.log 2>&1
    echo "Ready for Solr installer" >> /tmp/Solr_Install.log 2>&1
    echo "==========================================" >> /tmp/Solr_Install.log 2>&1
    echo "" >> /tmp/Solr_Install.log 2>&1

adduser solr >> /tmp/Solr_Install.log 2>&1
passwd -d solr >> /tmp/Solr_Install.log 2>&1
gpasswd wheel -a solr >> /tmp/Solr_Install.log 2>&1




    echo "Created Solr user" >> /tmp/Solr_Install.log 2>&1
    echo "==========================================" >> /tmp/Solr_Install.log 2>&1
    echo "" >> /tmp/Solr_Install.log 2>&1

#Get rid of tty requirement
sed -i.bak -e 's/Defaults    requiretty.*/#Defaults    requiretty/g' /etc/sudoers

#Install lsof - Solr will need it
yum -y install lsof >> /tmp/Solr_Install.log 2>&1

# Run Solr installer

su - solr -c "sudo /opt/install_solr_service.sh /opt/solr-6.3.0.tgz" >> /tmp/Solr_Install.log 2>&1

echo "Installed Solr successfully" >> /tmp/Solr_Install.log 2>&1
    echo "==========================================" >> /tmp/Solr_Install.log 2>&1
    echo "" >> /tmp/Solr_Install.log 2>&1

echo "Making Solr start automatically after reboot" >> /tmp/Solr_Install.log 2>&1
chkconfig --add solr >> /tmp/Solr_Install.log 2>&1
chkconfig | grep solr >> /tmp/Solr_Install.log 2>&1

echo "Changing /var/solr owner to solr user" >> /tmp/Solr_Install.log 2>&1
sudo chown -R solr:solr /var/solr/ >> /tmp/Solr_Install.log 2>&1

echo "Let's run a few tests" >> /tmp/Solr_Install.log 2>&1
echo "Creating a new test core" >> /tmp/Solr_Install.log 2>&1
sudo su - solr -c "/opt/solr/bin/solr create -c Kilgore_was_here_Test_Core -n data_driven_schema_configs" >> /tmp/Solr_Install.log 2>&1

echo "Restarting the Solr service" >> /tmp/Solr_Install.log 2>&1

sudo service solr restart >> /tmp/Solr_Install.log 2>&1

sudo service solr status >> /tmp/Solr_Install.log 2>&1

echo "Head over to your browser and open something like: " >> /tmp/Solr_Install.log 2>&1
echo "http://<solr_server>:8983/solr/#/" >> /tmp/Solr_Install.log 2>&1
echo "Check if the Admin is up and you can see the core" >> /tmp/Solr_Install.log 2>&1


echo "" >> /tmp/Solr_Install.log 2>&1
echo "The installation log you are seeing is currenty available at /tmp/Solr_Install.log" >> /tmp/Solr_Install.log 2>&1
