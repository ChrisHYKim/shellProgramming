#!/bin/bash

# (출력화면)
# 50% |=====>

NUM=1

echo -ne "50% |"

while [ $NUM -le 5 ]
do
	echo -ne "="
	sleep 1	
	NUM=`expr $NUM + 1`
done
echo -ne '>\n'