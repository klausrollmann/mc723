#!/bin/bash
if [ $# -ne 2 ]
then
	echo "./time_measure.sh [name_executable] [times_to_run]"
elif [ $2 -lt 1 ]
then
	echo "You cannot run it less than one time"
else
	for i in `seq 1 $2`; do
		time ./$1; 
	done 2>&1 | grep ^real | sed -e s/.*m// | awk 'NR == 1 { max=$1; min=$1; sum=0 } 
						{ if ($1>max) max=$1; if ($1<min) min=$1; sum+=$1;} 
				  END { printf "Min: %.4f\tMax: %.4f\tAverage: %.4f\n", min, max, sum/NR}'
fi
