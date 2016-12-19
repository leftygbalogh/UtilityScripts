#!/bin/sh

# Detects which OS and if it is Linux then it will detect which Linux
# Distribution.
# from http://linuxmafia.com/faq/Admin/release-files.html

#Only run on RedHat
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
    echo Sorry this script only runs on RedHat.
    exit -1
fi


# Check if I am root user - comes handy for the install
if [[ ! `whoami` = "root" ]]; then
    echo "You must have administrative privileges to run this script."
    echo "Log in as root or use sudo and try again."
    exit 1
else echo "You are an administrator. "
    echo "The application will be installed as root."
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
    echo No Java found.
    boolInstallJava=1
fi


if [[ "$_java" ]]; then
    version=$("$_java" -version 2>&1 | awk -F '"' '/version/ {print $2}')
    echo Version "$version"
fi

    if [[ "$version" > "1.7" ]] && [[ $boolInstallJava -ne 1 ]]; then
        echo We are good to go.
    else
        echo "Java will now be installed"
        yes | yum install java-1.8.0-openjdk.x86_64
    fi

#Create Solr user so Solr can be run as a service
echo -n "Enter the Solr username: "
read uname

echo -n "Enter the Solr user password: "
read -s passwd

adduser "$uname"
echo $uname:$passwd | sudo chpasswd

gpasswd wheel -a $uname > /dev/null


