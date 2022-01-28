#!/bin/bash
pushd ~/data
RANDOM_MAX='32767'
MAX=$(printf "%d" 0x3e92f60 ) # max file count
ITER=$( expr "$RANDOM" % 96 )
SMAX=$( expr "$MAX" '-' "$RANDOM_MAX" )
for iter in $( seq '0' "$ITER" )
do
	P=$( expr "$RANDOM$RANDOM" % "$SMAX" )
	L=$( expr "$P" + "$RANDOM" )
	if [ "$L" -gt "$MAX" ]
	then
		L=$MAX
	fi
	seq $P $L | xargs printf '%x\n' | sed 's@$@.txt@' | xargs fgrep -f $1
done
popd
