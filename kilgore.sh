#!/bin/sh

#The one and only Kilgore Solr Installer for RedHat

{
#Whole script is encased so the log can be sent via tee to
#tmp/Solr_Install.log

#Global variables
#directory where the Solr installer is downloaded to
DIR=/opt/

#default Solr version used, can be modified by using
# command line arguments as follows: -v X.Y.Z
SOLRVERSION="6.3.0"

#Can be used further on to add more Kilgore Trout references if necessary
kilgoreFlag=off
echo "╔═════════════════════════════════════════════════════════════════╗"
echo "║        Welcome to the one and only Kilgore Solr Installer.      ║"
echo "╚════════════════════════════════╤════════════════════════════════╝"

# Detects which OS and if it is Linux then it will detect which Linux
# Distribution.
#Check if OS is RedHAt as script only runs on RedHat
OS=`uname -s`
REV=`uname -r`
MACH=`uname -m`

while [ $# -gt 0 ]

do

    case "$1" in
        -k | --kilgore)
        kilgoreFlag=on
        echo "╔════════════════════════════════╧════════════════════════════════╗"
        echo "║     The list of Novels written by Kilgore Trout,                ║"
        echo "║     the greatest science fiction writer of all times.           ║"
        echo "╚════════════════════════════════╤════════════════════════════════╝"
sleep 3
        echo "╔════════════════════════════════╧════════════════════════════════╗"
        echo "║                                                                 ║"
        echo "║ - Barring-gaffner of Bagnialto or This Year's Masterpiece "
        echo "║       (mentioned in Breakfast of Champions)"
        echo "║ - The Big Board (mentioned in Slaughterhouse-Five)"
        echo "║ - The Era of Hopeful Monsters (mentioned in Galápagos)"
        echo "║ - First District Court of Thankyou (mentioned in Jailbird)"
        echo "║ - The Gospel from Outer Space (mentioned in Slaughterhouse-Five)"
        echo "║ - The Gutless Wonder (mentioned in Slaughterhouse-Five)"
        echo "║ - How You Doin'? (mentioned in Breakfast of Champions)"
        echo "║ - Maniacs in the Fourth Dimension (mentioned in Slaughterhouse-Five)"
        echo "║ - The Money Tree (mentioned in Slaughterhouse-Five)"
        echo "║ - Now It Can Be Told (mentioned in Breakfast of Champions)"
        echo "║ - Oh Say Can You Smell? (mentioned in God Bless You, Mr. Rosewater)"
        echo "║ - The Pan-Galactic Memory Bank (mentioned in Breakfast of Champions)"
        echo "║ - The Pan-Galactic Straw Boss a.k.a. Mouth Crazy "
        echo "║       (mentioned in Breakfast of Champions)"
        echo "║ - The Pan-Galactic Three-Day Pass "
        echo "║       (mentioned in God Bless You, Mr. Rosewater)"
        echo "║ - Plague on Wheels (mentioned in Breakfast of Champions)"
        echo "║ - The Smart Bunny (mentioned in Breakfast of Champions)"
        echo "║ - The Son of Jimmy Valentine (mentioned in Breakfast of Champions)"
        echo "║ - 2BR02B (mentioned in God Bless You, Mr. Rosewater)"
        echo "║ - Venus on the Half-Shell (mentioned in God Bless You, Mr. Rosewater)"
        echo "╚════════════════════════════════╤════════════════════════════════╝"
sleep 5

        shift
        ;;

        -v | --version)
        shift
        if [[ $# -gt 0 ]]; then
    	     SOLRVERSION=$1
            echo "╔════════════════════════════════╧════════════════════════════════╗"
    	    echo "     We will be using Solr $SOLRVERSION for this installation."
            echo "╚════════════════════════════════╤════════════════════════════════╝"

              shift
        else
           echo "╔════════════════════════════════╧════════════════════════════════╗"
      	   echo "      Most things in this world don´t work, aspirin do."
      	   echo "      Capt'n, we're missing a Solr version variable after -v"
           echo "╚════════════════════════════════╤════════════════════════════════╝"

        fi
        ;;

	      -h | --help | *)
        echo "╔════════════════════════════════╧════════════════════════════════╗"
        echo -e "\033[1mNAME\033[0m"
        echo "		Kilgore"
 		    echo ""
        echo -e "\033[1mSYNOPSIS\033[0m"
        echo "		Kilgore [OPTION]... [OPTION] [VERSION]..."
        echo ""
        echo -e "\033[1mDESCRIPTION\033[0m"
        echo "		Kilgore installs Solr from scratch on a RedHat server."
        echo "		By default, unless otherwise specified, "
        echo "      it installs Solr version $SOLRVERSION."
        echo "		Ideally, you would have a clean RedHat install, version 7.x."
        echo "		Stores the complate install log under /tmp/Solr_Install.log"
        echo "		This script has only been tested with Solr 6.x"
        echo "		"
        echo -e "		\033[1m-h | --help\033[0m"
        echo "				Print out all options"
        echo "		"
        echo -e "		\033[1m-k | --kilgore\033[0m"
        echo "				Adds a Kilgore Trout flavour to the logfile "
        echo "				under /tmp/Solr_Install.log."

        echo "		"
        echo -e "		\033[1m-v | --version [SolrVersion for example 6.1.0]\033[0m"
        echo "				The exact syntax is -v 6.1.0 "
        echo "              where the version number is the three digit number "
        echo "				of the various Solr versions in the Apache archive."
        echo "				"
        echo "				This can be found at "
        echo "				http://archive.apache.org/dist/lucene/solr/"
        echo "		"

        echo -e "       \033[1mExit status\033[0m"
        echo "		    0		if OK"
 		echo "	        1		if version is missing"
 		echo ""

        echo -e "\033[1mAUTHOR\033[0m"
        echo "		Lefty "
        echo "		https://hu.linkedin.com/in/leftygbalogh"
        echo "		https://github.com/leftygbalogh"
        echo "		http://stackoverflow.com/users/5996315/lefty-g-balogh"
 		    echo ""

        echo -e "       \033[1mCOPYRIGHT\033[0m"
        echo "		Copyright © 2016 License GPLv3+: GNU"
        echo "		GPL version 3 or later <http://gnu.org/licenses/gpl.html>."
        echo "		This  is  free software: "
        echo "      you are free to change and redistribute it."
        echo "		There is NO WARRANTY, to the extent permitted by law."
      	echo ""
        echo "╚════════════════════════════════╤════════════════════════════════╝"

        exit 1
        ;;

    esac
done


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
    echo "╔════════════════════════════════╧════════════════════════════════╗"
echo ""
    echo "          Sorry this script only runs on RedHat."
    echo "╚═════════════════════════════════════════════════════════════════╝"

    echo ""
    exit -1
fi


# Check if I am root user - comes handy for the install
if [[ ! `whoami` = "root" ]]  ; then
    echo "╔════════════════════════════════╧════════════════════════════════╗"
    echo ""
    echo "  You must have administrative privileges to run this script."
    echo "  Log in as root or use sudo and try again."
    echo "╚═════════════════════════════════════════════════════════════════╝"
    echo ""
    exit 1
else
    echo "╔════════════════════════════════╧════════════════════════════════╗"
    echo "     You are an administrator. "
    echo "      Solr and its dependencies will now be installed."
    echo "╚════════════════════════════════╤════════════════════════════════╝"
    echo ""
fi

# Chech if java is already installed and if it is 1.8 or higher - if not, install Java 1.8
boolInstallJava=0
echo "╔════════════════════════════════╧════════════════════════════════╗"

if type -p java; then
    echo "      Found Java."
    _java=java
elif [[ -n "$JAVA_HOME" ]] && [[ -x "$JAVA_HOME/bin/java" ]];  then
    echo "      Found Java."
    _java="$JAVA_HOME/bin/java"
else
    echo ""
    echo "      No Java found."
    boolInstallJava=1
fi


if [[ "$_java" ]]; then
    version=$("$_java" -version 2>&1 | awk -F '"' '/version/ {print $2}')
    echo Version "      $version"
fi

echo "╚════════════════════════════════╤════════════════════════════════╝"


    if [[ "$version" > "1.7" ]] && [[ $boolInstallJava -ne 1 ]]; then
        echo "╔════════════════════════════════╧════════════════════════════════╗"
        echo "                      We are good to go."
        echo "╚════════════════════════════════╤════════════════════════════════╝"
    else
        echo "╔════════════════════════════════╧════════════════════════════════╗"
        echo "                      Java will now be installed"
        echo "╚════════════════════════════════╤════════════════════════════════╝"
        yes | yum install java-1.8.0-openjdk.x86_64
    fi

# Download Solr and check if file has indeed been downloaded to /opt/

URL=http://archive.apache.org/dist/lucene/solr/$SOLRVERSION/solr-$SOLRVERSION.tgz

cd $DIR
echo "╔════════════════════════════════╧════════════════════════════════╗"
echo "          Downloading Solr from the Apache Archives"
echo "╚════════════════════════════════╤════════════════════════════════╝"

curl -O $URL --retry 5

file="/opt/solr-$SOLRVERSION.tgz"
if [ -f "$file" ]
then
    echo "╔════════════════════════════════╧════════════════════════════════╗"
        echo "          Solr successfully downloaded."
        echo "╚════════════════════════════════╤════════════════════════════════╝"
else
        echo "╔════════════════════════════════╧════════════════════════════════╗"
        echo "      Solr could not be downloaded. Weird, init?!"
        echo "      Exitin sadly, quoth Mandarax"
        echo ""
        echo "      So long, old pal. "
        echo "      You’re going to a different world now."
        echo "      It’s sure to be a better one, "
        echo "      since no other world could be as bad as this one is."
        echo "╚════════════════════════════════╤════════════════════════════════╝"
        exit 1
fi

echo "╔════════════════════════════════╧════════════════════════════════╗"
    echo "      Fidgeting with bubblewrap on Solr"
    echo "╚════════════════════════════════╤════════════════════════════════╝"
    tar zxf solr-$SOLRVERSION.tgz

cp /opt/solr-$SOLRVERSION/bin/install_solr_service.sh .
rm -rf solr-$SOLRVERSION
echo "╔════════════════════════════════╧════════════════════════════════╗"
    echo "      Ready for Solr installer"
    echo "╚════════════════════════════════╤════════════════════════════════╝"

adduser solr
passwd -d solr
gpasswd wheel -a solr

echo "╔════════════════════════════════╧════════════════════════════════╗"
    echo "      Created Solr user"
    echo "╚════════════════════════════════╤════════════════════════════════╝"

#Get rid of tty requirement
sed -i.bak -e 's/Defaults    requiretty.*/#Defaults    requiretty/g' /etc/sudoers

#Install lsof - Solr will need it
echo "╔════════════════════════════════╧════════════════════════════════╗"
yum -y install lsof
echo "╚════════════════════════════════╤════════════════════════════════╝"

# Run Solr installer
echo "╔════════════════════════════════╧════════════════════════════════╗"

su - solr -c "sudo /opt/install_solr_service.sh /opt/solr-$SOLRVERSION.tgz"
echo "╚════════════════════════════════╤════════════════════════════════╝"
echo "╔════════════════════════════════╧════════════════════════════════╗"
echo "      Installed Solr successfully"
echo "╚════════════════════════════════╤════════════════════════════════╝"
echo "╔════════════════════════════════╧════════════════════════════════╗"
echo "      Making Solr start automatically after reboot"
chkconfig --add solr
chkconfig | grep solr
echo "╚════════════════════════════════╤════════════════════════════════╝"
echo "╔════════════════════════════════╧════════════════════════════════╗"

echo "      Changing /var/solr owner to solr user"
sudo chown -R solr:solr /var/solr/
echo "╚════════════════════════════════╤════════════════════════════════╝"
echo "╔════════════════════════════════╧════════════════════════════════╗"

echo "      Let's run a few tests"
echo "      Creating a new test core"
sudo su - solr -c "/opt/solr/bin/solr create -c Kilgore_was_here_Test_Core -n data_driven_schema_configs"
echo "      Restarting the Solr service"
echo "╚════════════════════════════════╤════════════════════════════════╝"
echo "╔════════════════════════════════╧════════════════════════════════╗"

sudo service solr restart
echo "╚════════════════════════════════╤════════════════════════════════╝"
echo "╔════════════════════════════════╧════════════════════════════════╗"

sudo service solr status
echo "╚════════════════════════════════╤════════════════════════════════╝"
echo "╔════════════════════════════════╧════════════════════════════════╗"

echo "  Head over to your browser and open something like: "
echo "  http://<solr_server>:8983/solr/#/"
echo "  Check if the Admin is up and you can see the core"
echo ""
echo "  The installation log you are seeing is currenty available at "
echo "  /tmp/Solr_Install.log"
echo "╚═════════════════════════════════════════════════════════════════╝"

} 2>&1 | tee -a /tmp/Solr_Install.log
