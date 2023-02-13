#!/bin/bash

#Constants; add more if necessary
MISSING_ARGS_MSG="Missing data file"

# FILL ME
if [ $# == 0 ] ; then
echo $MISSING_ARGS_MSG
exit 1;
fi

if [[ ! -f $1 ]]; then
  echo $MISSING_ARGS_MSG
  exit 1;
fi

header=$(head -1 $1)
IFS=" "
header_arr=($header)
lastIndex=$((${#header_arr[@]}-1))
last_header=${header_arr[lastIndex]}
# N=${N/Q/}
N=$(echo $last_header | sed  's/Q//g')


total=0
total_w=0
while read line || [[ -n $line ]]
do
	[[ $line = ID* ]] && continue
	IFS=" "
	arr=($line)

	# for i in `seq 1 10`
	for i in `eval echo {1..$N}`
	do 
		index=`expr $i + 1`
		weight_index=1
		weight=0
		for arg in "$@"
		do
		  
		  if [[ $weight_index == $index ]]; then
			  weight=$arg
			  break;
		  fi
		  let weight_index+=1
		  
		done
		[[ $weight == 0 ]] && weight=1
		# echo "arg: $weight_index = $weight "
		let weight_index-=1
		num=${arr[weight_index]}
		# echo $num
		sum=`expr $num \* $weight`
		# echo $sum

		# sum=`expr ${arr[i]} \* $w1 + ${arr[2]} \* $w2 + ${arr[3]} \* $w3 + ${arr[4]} \* $w4 + ${arr[5]} \* $w5`
		total=`expr $total + $sum`
		let total_w+=weight
		# echo "total: $total,  total_w:  $total_w "
	done
	
	
done < $1

echo `expr $total / $total_w`
