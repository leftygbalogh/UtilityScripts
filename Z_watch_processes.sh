#!/bin/bash

DELAY=$1
PARENT_PID=$2
OUTPUT_FILE=$3
OWN_PID=$$

declare -a child_pid_list

function get_child_processes () {
  child_pid_list=()
  child_pid_list+=($(pgrep -P $PARENT_PID))
}

function get_actual_process_status () {
  while true; do
    if [ -e /proc/$PARENT_PID ]; then 
      get_child_processes
      my_cpuload=$(ps -p $OWN_PID -o %cpu | grep -v '%CPU')
#      printout="[My CPU load is: $my_cpuload], Filter CPU load: [P + ${#child_pid_list[@]} ch] Parent: ($PARENT_PID) $(ps -p $PARENT_PID -o %cpu | grep -v '%CPU'), "
      printout="[My: $my_cpuload], [P+${#child_pid_list[@]}]: [P:$(ps -p $PARENT_PID -o %cpu | grep -v '%CPU')],"
      for pid in ${child_pid_list[@]}; do
        printout="$printout$(ps -p $pid -o %cpu | grep -v '%CPU'),"
      done
      if [ "$OUTPUT_FILE" != "" ]; then
        echo "$(date).....$printout" >> $OUTPUT_FILE
      else
        tput el
        echo -en "\r$printout"
      fi
    else
      if [ "$OUTPUT_FILE" != "" ]; then
        echo "$(date).....Script end time: $(date)" >> $OUTPUT_FILE
      else
        tput el
        echo -e "\rScript end time: $(date)                                                                                                                                                                                          "
      fi        
      break
    fi
      sleep $DELAY
  done
}

if [ "$OUTPUT_FILE" != "" ]; then
  echo >> $OUTPUT_FILE
  echo "$(date).....Script start time:$(ps -eo pid,lstart | grep $PARENT_PID | grep -v color | awk '{$1=""; print $0}')" >> $OUTPUT_FILE
else
  echo
  echo "Script start time:$(ps -eo pid,lstart | grep $PARENT_PID | grep -v color | awk '{$1=""; print $0}')"
fi
get_actual_process_status

