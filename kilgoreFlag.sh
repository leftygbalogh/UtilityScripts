kilgoreFlag=off
while [ $# -gt 0 ]

do
    echo number of arguments $#

    case "$1" in
        -k | --kilgore)
        kilgoreFlag=on
        echo "Kilgore was here"
        ;;

        -v | --version)
        SOLRVERSION=$2
        echo "We'll be using Solr $2 as you requested."
        ;;

    	-x | --xolp)
        echo "xauxage"
        ;;


	-h | --help)
        echo "sausage"
	    exit 1
        ;;

    *)  break;;	# terminate while loop
    esac
    shift
done
