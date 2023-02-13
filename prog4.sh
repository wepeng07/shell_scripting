#!/bin/bash

# Constants; add more if necessary

MISSING_ARGS_MSG="Score directory missing"
ERR_MSG="not a directory"

# FILL ME
if [ $# == 0 ] ; then
echo $MISSING_ARGS_MSG
exit 1;
fi

if [ $# -gt 1 ] ; then
echo $MISSING_ARGS_MSG
exit 1;
fi

if [[ ! -d $1 ]]; then
  echo $1" "$ERR_MSG
  exit 1;
fi

[[ $# -gt 1 ]] && w1=$2 || w1=1
[[ $# -gt 2 ]] && w2=$3 || w2=1
[[ $# -gt 3 ]] && w3=$4 || w3=1
[[ $# -gt 4 ]] && w4=$5 || w4=1
[[ $# -gt 5 ]] && w5=$6 || w5=1
let ww=$w1+$w2+$w3+$w4+$w5


for file in `find $1 -name "prob4-score*"`
do
	content=$(cat $file)
	[[ $content != ID* ]] && continue
	while read line
	do
		[[ $line = ID* ]] && continue
		IFS=","
		arr=($line)
		# echo ${arr[@]} 
		sum=`expr ${arr[1]} \* $w1 + ${arr[2]} \* $w2 + ${arr[3]} \* $w3 + ${arr[4]} \* $w4 + ${arr[5]} \* $w5`
		ws=`expr $sum \* 10 / $ww`
		if [ $ws -ge 93 ] && [ $ws -le 100 ];then
			echo ${arr[0]}" : A"
		elif [ $ws -ge 80 ] && [ $ws -le 92 ];then
			echo ${arr[0]}" : B"
		elif [ $ws -ge 65 ] && [ $ws -le 79 ];then
			echo ${arr[0]}" : C"
		else echo ${arr[0]}" : D"
		fi
	done < $file
done
