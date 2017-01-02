kilgoreFlag=off
SOLRVERSION=6.3.0
while [ $# -gt 0 ]

do

    case "$1" in
        -k | --kilgore)
        kilgoreFlag=on
        echo "The list of Novels written by Kilgore Trout, "
        echo "the greatest science fiction writer of all times."
        echo ""
        echo " - Barring-gaffner of Bagnialto or This Year's Masterpiece (novel mentioned in Breakfast of Champions)"
		echo " - The Big Board (novel mentioned in Slaughterhouse-Five)"
		echo " - The Era of Hopeful Monsters (novel mentioned in Galápagos)"
		echo " - First District Court of Thankyou (novel mentioned in Jailbird and God Bless You, Mr. Rosewater)"
		echo " - The Gospel from Outer Space (novel mentioned in Slaughterhouse-Five)"
		echo " - The Gutless Wonder (novel mentioned in Slaughterhouse-Five)"
		echo " - How You Doin'? (novel mentioned in Breakfast of Champions)"
		echo " - Maniacs in the Fourth Dimension (novel mentioned in Slaughterhouse-Five)"
		echo " - The Money Tree (novel mentioned in Slaughterhouse-Five)"
		echo " - Now It Can Be Told (novel mentioned in Breakfast of Champions)"
		echo " - Oh Say Can You Smell? (novel mentioned in God Bless You, Mr. Rosewater)"
		echo " - The Pan-Galactic Memory Bank (novel mentioned in Breakfast of Champions)"
		echo " - The Pan-Galactic Straw Boss a.k.a. Mouth Crazy (novel mentioned in Breakfast of Champions)"
		echo " - The Pan-Galactic Three-Day Pass (novel mentioned in God Bless You, Mr. Rosewater)"
		echo " - Plague on Wheels (novel mentioned in Breakfast of Champions)"
		echo " - The Smart Bunny (novel mentioned in Breakfast of Champions)"
		echo " - The Son of Jimmy Valentine (novel mentioned in Breakfast of Champions)"
		echo " - 2BR02B (novel mentioned in God Bless You, Mr. Rosewater)"
		echo " - Venus on the Half-Shell (novel first mentioned in God Bless You, Mr. Rosewater)"
		echo ""
		shift
        ;;

        -v | --version)
			shift
			if [[ $# -gt 0 ]]; then
				SOLRVERSION=$1
				echo "We will be using Solr $SOLRVERSION for this installation."
				shift
			else
		    	echo "Most things in this world don´t work, aspirin do."
		    	echo "Capt'n, we're missing a Solr version variable after -v"
		    	fi
		        ;;

	-h | --help | *)
        echo ""
        echo -e "\033[1mNAME\033[0m"
        echo "		Kilgore"
 		echo ""
        echo -e "\033[1mSYNOPSIS\033[0m"
        echo "		Kilgore [OPTION]... [OPTION] [VERSION]..."
        echo ""
        echo -e "\033[1mDESCRIPTION\033[0m"
        echo "		Kilgore installs Solr from scratch on a RedHat server."
        echo "		By default, unless otherwise specified, it installs Solr version $SOLRVERSION."
        echo "		Ideally, you would be using clean RedHat install, version 7.x."
        echo "		Stores the complate install log under /tmp/Solr_Install.log"
        echo "		This script has only been tested with Solr 6.x"
        echo "		"        
        echo -e "		\033[1m-h | --help\033[0m"
        echo "				Print out all options"
        echo "		"
        echo -e "		\033[1m-k | --kilgore\033[0m"
        echo "				Adds a Kilgore Trout flavour to the installation logfile "
        echo "				under /tmp/Solr_Install.log."
        
        echo "		"
        echo -e "		\033[1m-v | --version [SolrVersion for example 6.1.0]\033[0m"
        echo "				The exact syntax is -v 6.1.0 where the version number is"
        echo "				the three digit number of the various Solr versions in the "
        echo "				Apache archive."
        echo "				This can be found at "
        echo "				http://archive.apache.org/dist/lucene/solr/"
        echo "		"
        
        echo -e "\033[1mExit status\033[0m"
        echo "		0		if OK"
 		echo "		1		if version is missing"
 		echo ""

        echo -e "\033[1mAUTHOR\033[0m"
        echo "		Lefty "
        echo "		https://hu.linkedin.com/in/leftygbalogh"
        echo "		https://github.com/leftygbalogh"
        echo "		http://stackoverflow.com/users/5996315/lefty-g-balogh"
 		echo ""

        echo -e "\033[1mCOPYRIGHT\033[0m"
        echo "		Copyright © 2016 License GPLv3+: GNU"
        echo "		GPL version 3 or later <http://gnu.org/licenses/gpl.html>."
        echo "		This  is  free software: you are free to change and redistribute it."
        echo "		There is NO WARRANTY, to the extent permitted by law."
      	echo ""
        exit 1
        ;;

    *)  
	echo "second star"
    break;;	# terminate while loop
    esac
    
done
