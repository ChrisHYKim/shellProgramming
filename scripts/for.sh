#!/bin/bash

for VAR in A B C D
do 
    echo $VAR
done

for VAR in (1..5) 
do 
    echo $VAR 
done

for VAR in $(seq 1 5) 
do 
    echo $VAR 
done

