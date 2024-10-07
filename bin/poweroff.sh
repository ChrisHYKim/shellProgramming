#!/bin/bash
# ssh 192.168.10.10 poweroff
# sleep 3
# ssh 192.168.10.30 poweroff
# sleep 3
# ssh 192.168.10.20 poweroff

NET=192.168.10
CMD=poweroff
for i in 10 30 20
do 
    ssh $NET.$i "$CMD"
    sleep 3
done