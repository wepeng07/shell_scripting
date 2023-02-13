#!/bin/bash

# Constants; add more if necessary
WRONG_ARGS_MSG="data file or output file missing"
FILE_NOT_FOUND_MSG="file not found"

# FILL ME
if [ $# == 0 ] ; then
echo $WRONG_ARGS_MSG
exit 1;
fi

if [ $# != 2 ] ; then
echo $WRONG_ARGS_MSG
exit 1;
fi

if [ ! -f $1 ]; then
  srcDir=${1##*/}
  echo $srcDir" file not found"
  exit 1;
fi

if [ ! -f $2 ]; then
  touch $2
fi

# echo "" > $2

col=0
while :
do
	((col++));
	arr=($(cat $1 | awk -F'[,;:]' -v  col_num="${col}" '{print $col_num}'))
	if [ ${#arr[@]} == 0 ] ; then
		break;
	fi
	sum=0
	for (( i=0;i<${#arr[*]};i++))
	do
	    let sum=sum+${arr[$i]}
	done
	echo "Col "$col" : "$sum >> $2
	
done
