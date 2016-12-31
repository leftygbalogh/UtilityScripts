kilgoreFlag=off
while [ $# -gt 0 ]
do
    case "$1" in
        -k | --kilgore)
        kilgoreFlag=on
        echo "Kilgore was here"
        shift;;
        -v | --version)
        SOLRVERSION=$2
        echo "We'll be using Solr $2 as you requested."
        shift;;


	-h | --help)
            echo "sausage"
	    exit 1;;
	*)  break;;	# terminate while loop
    esac
    shift
done
