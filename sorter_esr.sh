#!/bin/bash

OWN_PID=$$

ACTUAL_DATE=$(date +%s)

WORKING_PATH=""
MAX_THREAD_NUMBER=0
FINISHED_TAR_FOLDER=""
PATH_IN_THE_TAR_FILE=""
DEBUG="false"

function usage () {
  echo
  echo "    Usage:"
  echo "       sorter_esr.sh <input path> <maximum thread number> <output path> [ESR path in the .tar.gz files || d] [d]"
  echo
  echo "             input path                     -  Full path where the ESR .tar.gz files are stored"
  echo "             maximum thread number          -  If you want to execute the script in parallel mode, then give a >0 number."
  echo "                                               But do not forget to check the number of CPUs before you start this script!"
  echo "                                               If you do not want to execute the script in parallel mode, then give 1 to here."
  echo "             output path                    -  Full path where you want to find the sorted ESR .tar.gz files after this script execution."
  echo "             ESR path in the .tar.gz files  -  Not necessary argument."
  echo "                                               The path inside the .tar.gz input files where the ESR files are stored."
  echo "                                               If you do not give it, the the following paths will be used:"
  echo "                                                  local/anonymization/anon_output/data-esr-anonim/"
  echo "                                                     or"
  echo "                                                  local/anonymization/anon_output2/data-esr-anonim/"
  echo "             d                              -  Not necessary argument."
  echo "                                               You can switch ON the debug mode with it."
  echo "                                               And you can get extra log into the console."
  echo
}

if [ "$1" == "" ]; then
  echo -e "ERROR: Missing first argument [input path] !!"
  usage
  echo "Exiting..."
  exit 1
else
  WORKING_PATH=$1
fi

if [ "$2" == "" ]; then
  echo -e "ERROR: Missing second argument [maximum number of threads] !!"
  usage
  echo "Exiting..."
  exit 1
else if [ "$2" -gt "0" ]; then
       MAX_THREAD_NUMBER=$2
     else
       echo -e "ERROR: The second argument should be a number!!"
       usage
       echo "Exiting..."
       exit 1
     fi
fi

if [ "$3" == "" ]; then
  echo -e "ERROR: Missing third argument [output path] !!"
  usage
  echo "Exiting..."
  exit 1
else
  FINISHED_TAR_FOLDER=$3
  if [ ! -d "$FINISHED_TAR_FOLDER" ]; then
    mkdir -p $FINISHED_TAR_FOLDER
  fi
fi

if [ "$4" != "d" ]; then
  PATH_IN_THE_TAR_FILE="$4"
fi

if [ "$4" == "d" ]; then
  DEBUG="true"
fi

if [ "$5" == "d" ]; then
  DEBUG="true"
fi

LOG_FILE="$WORKING_PATH/esr_sorter-$ACTUAL_DATE.log"

declare -a tar_file_list

function esr_sorter () {
## Get and create working folder ==============================
  tar_index=$1
  tar_file_name=${tar_file_list[$tar_index]}  # tmoarknw-1482575400-1482661800.filter_output.1483448115.tar.gz
  folder="${tar_file_name%%.*}"   #tmoarknw-1482575400-1482661800

  echo "$((tar_index+1)) - $(date) - Get and create working folder [$folder] - started" >> $LOG_FILE

  if [ "$DEBUG" == "true" ]; then
    echo "$((tar_index+1)) - tar-index: $tar_index"
    echo "$((tar_index+1)) - tar-file-name: $tar_file_name"
    echo "$((tar_index+1)) - folder: $folder"
  fi

  echo -e "$((tar_index+1)) / ${#tar_file_list[@]}\t$(date)\tFile started: $tar_file_name"

  mkdir $WORKING_PATH/$folder.sorted.working

  echo "$((tar_index+1)) - $(date) - Get and create working folder [$folder] - finished" >> $LOG_FILE

## Extracting files ==================================================
  echo "$((tar_index+1)) - $(date) - Extracting files [$folder] - started" >> $LOG_FILE

  if [ "$DEBUG" == "true" ]; then
    echo "$((tar_index+1)) - tar -zxvf $WORKING_PATH/$tar_file_name -C $WORKING_PATH/$folder.sorted.working"
  fi

  tar --absolute-names -zxvf $WORKING_PATH/$tar_file_name -C $WORKING_PATH/$folder.sorted.working >> $LOG_FILE

  echo "$((tar_index+1)) - $(date) - Extracting files [$folder] - finished" >> $LOG_FILE

## Sorting files ======================================================
  echo "$((tar_index+1)) - $(date) - Sorting files [$folder] - started" >> $LOG_FILE

  if [ "$DEBUG" == "true" ]; then
    if [ -d "$WORKING_PATH/$folder.sorted.working/local/anonymization/anon_output/data-esr-anonim" ]; then
      echo "$((tar_index+1)) - \$WORKING_PATH/\$folder.sorted.working/local/anonymization/anon_output/data-esr-anonim: $WORKING_PATH/$folder.sorted.working/local/anonymization/anon_output/data-esr-anonim  <---  EXIST"
    fi
    if [ -d "$WORKING_PATH/$folder.sorted.working/local/anonymization/anon_output2/data-esr-anonim" ]; then
      echo "$((tar_index+1)) - \$WORKING_PATH/\$folder.sorted.working/local/anonymization/anon_output2/data-esr-anonim: $WORKING_PATH/$folder.sorted.working/local/anonymization/anon_output2/data-esr-anonim  <---  EXIST"
    fi
  fi

  unsorted_files_path=""

  if [ "$PATH_IN_THE_TAR_FILE" == "" ]; then
    if [ -d "$WORKING_PATH/$folder.sorted.working/local/anonymization/anon_output/data-esr-anonim" ]; then
      unsorted_files_path="$WORKING_PATH/$folder.sorted.working/local/anonymization/anon_output/data-esr-anonim/"
    else if [ -d "$WORKING_PATH/$folder.sorted.working/local/anonymization/anon_output2/data-esr-anonim" ]; then
           unsorted_files_path="$WORKING_PATH/$folder.sorted.working/local/anonymization/anon_output2/data-esr-anonim/"
         fi
    fi
  else
    unsorted_files_path=$PATH_IN_THE_TAR_FILE
  fi

  if [ "$unsorted_files_path" == "" ]; then
    echo -e "ERROR: the unsorted path is unknown after the extracting!!"
    usage
    echo "Exiting..."
    exit 1
  fi

  files_number=$(ls $unsorted_files_path | wc -l)

  if [ "$files_number" == "0" ]; then
    echo -e "ERROR: there are no any files on the given path in the .tar.gz file!!"
    usage
    echo "Exiting..."
    exit 1
  fi

  file_counter=0

  for file in $(ls $unsorted_files_path); do
    file_counter=$((file_counter+1))
    echo "$((tar_index+1)) - $(date) - sorting $file_counter. file from $files_number [$folder]" >> $LOG_FILE
    cat $unsorted_files_path/$file | grep -e "^148" | sort >> $WORKING_PATH/$folder.sorted.working/$file.sorted;
  done

  echo "$((tar_index+1)) - $(date) - Sorting files [$folder] - finished" >> $LOG_FILE

## Compress sorted files into the output folder ========================
  echo "$((tar_index+1)) - $(date) - Compress sorted files into the output folder [$folder] - started" >> $LOG_FILE

  if [ "$DEBUG" == "true" ]; then
    echo "$((tar_index+1)) - tar -zcvf \$FINISHED_TAR_FOLDER/\$folder.sorted.tar.gz \$WORKING_PATH/\$folder.sorted.working/*.sorted: tar -zcvf $FINISHED_TAR_FOLDER/$folder.sorted.tar.gz $WORKING_PATH/$folder.sorted.working/*.sorted"
  fi

  tar --absolute-names -zcvf $FINISHED_TAR_FOLDER/$folder.sorted.tar.gz $WORKING_PATH/$folder.sorted.working/*.sorted >> $LOG_FILE

  echo "$((tar_index+1)) - $(date) - Compress sorted files into the output folder [$folder] - finsihed" >> $LOG_FILE

## Delete temporarly folder and files ============================================================================
  echo "$((tar_index+1)) - $(date) - Delete temporarly folder and files [$folder] - started" >> $LOG_FILE

  if [ "$DEBUG" == "true" ]; then
    if [ "$WORKING_PATH/$folder.sorted.working" != "$FINISHED_TAR_FOLDER" ]; then
      echo "$((tar_index+1)) - The \$WORKING_PATH/\$folder.sorted.working [$WORKING_PATH/$folder.sorted.working] and the \$FINISHED_TAR_FOLDER \[$FINISHED_TAR_FOLDER\] are not equal."
      echo "$((tar_index+1)) - The \$WORKING_PATH/\$folder.sorted.working [$WORKING_PATH/$folder.sorted.working] is deleteable."
    else
      echo "$((tar_index+1)) - The \$WORKING_PATH/\$folder.sorted.working [$WORKING_PATH/$folder.sorted.working] and the \$FINISHED_TAR_FOLDER [$FINISHED_TAR_FOLDER] are equal!!"
      echo "$((tar_index+1)) - The \$WORKING_PATH/\$folder.sorted.working [$WORKING_PATH/$folder.sorted.working] is NOT deleteable."
    fi
    echo "$((tar_index+1)) - mv \$WORKING_PATH/\$folder.sorted.working $WORKING_PATH/\$folder.sorted.done: mv $WORKING_PATH/$folder.sorted.working $WORKING_PATH/$folder.sorted.done"
    echo "$((tar_index+1)) - rm -rf \$WORKING_PATH/\$folder.sorted.done: rm -rf $WORKING_PATH/$folder.sorted.done"
  fi

  if [ "$WORKING_PATH/$folder.sorted.working" != "$FINISHED_TAR_FOLDER" ]; then
    mv $WORKING_PATH/$folder.sorted.working $WORKING_PATH/$folder.sorted.done
    rm -rf $WORKING_PATH/$folder.sorted.done
  else
    echo "$((tar_index+1)) - $(date) - The INPUT_PATH/WORKING_FOLDER [$WORKING_PATH/$folder.sorted.working] and the OUTPUT_FOLDER [$FINISHED_TAR_FOLDER] are equal!!"
    echo "$((tar_index+1)) - $(date) - The INPUT_PATH/WORKING_FOLDER [$WORKING_PATH/$folder.sorted.working] and the OUTPUT_FOLDER [$FINISHED_TAR_FOLDER] are equal!!" >> $LOG_FILE
    echo "$((tar_index+1)) - $(date) - The INPUT_PATH/WORKING_FOLDER [$WORKING_PATH/$folder.sorted.working] is NOT deleteable."
    echo "$((tar_index+1)) - $(date) - The INPUT_PATH/WORKING_FOLDER [$WORKING_PATH/$folder.sorted.working] is NOT deleteable." >> $LOG_FILE
  fi

  echo "$((tar_index+1)) - $(date) - Delete temporarly folder and files [$folder] - finished" >> $LOG_FILE

  echo -e "$((tar_index+1)) / ${#tar_file_list[@]}\t$(date)\tFile finished: $tar_file_name"
}


## MAIN ============================================================================================================
echo

tar_file_list=( $(ls $WORKING_PATH | grep .tar.gz) )

for tarindex in ${!tar_file_list[@]}; do

  if [ "$MAX_THREAD_NUMBER" == "1" ]; then
    ## one thread execution =====================
    esr_sorter $tarindex
  else
    ## multi thread execution ===================
    if [[ "$(pgrep -P $OWN_PID | wc -l)" -lt "$MAX_THREAD_NUMBER" ]]; then
      esr_sorter $tarindex &
    else
      while [[ "$(pgrep -P $OWN_PID | wc -l)" -gt "$MAX_THREAD_NUMBER" ]]; do
        for x in {1..50000}; do :; done
      done
      esr_sorter $tarindex &
    fi
  fi

done

wait

echo
echo -e "\tLOG FILE: $WORKING_PATH/esr_sorter-$ACTUAL_DATE.log"
echo

exit 0
