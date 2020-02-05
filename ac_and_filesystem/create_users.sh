#!/bin/bash

# create the groups for the the file system lab
groupadd ta
groupadd students

for N in $(seq 2); do
    useradd student${N}
    addgroup student${N} students
done

useradd instructor

addgroup instructor ta
