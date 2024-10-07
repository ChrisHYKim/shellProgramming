#!/bin/bash

FILES=/root/shell/user.list > $FILES

for i in (seq 1 100)
do
    echo "user $i   user$i" >> $FILES
done
