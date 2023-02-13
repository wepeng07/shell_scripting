#!/bin/bash

# Constants; add more if necessary

MISSING_ARGS_MSG="input file and  dictionary missing"
BAD_ARG_MSG_1="missing no. of characters"
BAD_ARG_MSG_2="Third argument must be an integer greater than 0"
FILE_NOT_FOUND_MSG="not a file"

# FILL ME
if [ $# == 0 ] ; then
	echo "$MISSING_ARGS_MSG"
	exit 0;
fi

if [ $# -lt 2 ] ; then
	echo "$MISSING_ARGS_MSG"
	exit 0;
fi

if [ $# != 3 ] ; then
	echo $BAD_ARG_MSG_1
	exit 1;
fi

if [ $3 -gt 0 ] 2>/dev/null
then
	N=$3
else
	echo $BAD_ARG_MSG_2
	exit 1;
fi

if [ ! -f $1 ]; then
  data_file=${1##*/}
  echo "$data_file $FILE_NOT_FOUND_MSG"
  exit 1;
fi

if [ ! -f $2 ]; then
  dict_file=${2##*/}
  echo "$dict_file $FILE_NOT_FOUND_MSG"
  exit 1;
fi

data=($(grep -E -o "\b([[:alpha:]]|\-)+\b" $1 | awk '{print $1}'))
# echo ${#data[@]}
# echo "${data[@]}"
# echo

dict=($(cat $2 | tr A-Z a-z | awk '{print $1}'))
# echo "${dict[@]}"

for(( i=0;i<${#data[@]};i++));
do
	[[ ${#data[i]} != $3 ]] && continue
	match='n'
	for j in ${dict[@]}
	do
		word=$(echo ${data[i]} | tr A-Z a-z)
	    [ "$j" == "$word" ] && match='y'
	done

	if [[ $match == "n" ]] ; then
	    echo "$word; word position=`expr $i + 1`"
	fi

done
