#!/bin/bash

NUM=1

while [ $NUM -le 10 ]
do
	echo -ne "="
	sleep 1	
	NUM=`expr $NUM + 1`
done
echo