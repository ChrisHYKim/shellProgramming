#!/bin/bash

IP=172.16.8.254

if [ "X${IP}" != "X" ] ; then
    ping -s ${IP}    
fi