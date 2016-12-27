kilgoreFlag=off
while [ $# -gt 0 ]
do
    case "$1" in
        -k | --kilgore)  kilgoreFlag=on echo "Kilgore was here" ;;
	-*)
            echo "usage: $0 [-v] [file ...]"
	    exit 1;;
	*)  break;;	# terminate while loop
    esac
    shift
done