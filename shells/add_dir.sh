#!/bin/bash

BASEDIR=/test
[  -d $BASEDIR ] && rm -rf $BASEDIR/*
for i in $(seq 1 4)
do
    mkdir -p $BASEDIR/$i
    for j in $(seq 1 4)
    do 
        mkdir -p $BASEDIR/fileTest$i
    done
done