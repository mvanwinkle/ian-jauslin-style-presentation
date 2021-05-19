#!/bin/bash

count="${1:-10}"; shift
max_random="${1:-60}"; shift
max_random_from_random=32767

# If you want random numbers based off of host
# hostid=$[ 0x`hostid` ]
# random_seed=${random_seed:-$hostid}
# RANDOM="$random_seed"

function get_random_value {
	value=$RANDOM
	normalized_random=$(($value/($max_random_from_random/$max_random)))
	echo $normalized_random
}

for (( c=1; c<=$count; c++))
do
	r=$(get_random_value)
	printf "%s\t%s\n" $c $r
done
