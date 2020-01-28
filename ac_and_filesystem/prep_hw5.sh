#!/bin/bash

# This is a script to prep a standard Vagrant ubuntu/xenial64 image
# for Homework 4 of I230.
VERIFICATION=1

# Verify the users and groups have been created
for USER in "vagrant" "student1" "student2" "instructor"; do
    if ! id -u $USER  >/dev/null 2>&1; then
        echo "It doesn't look like $USER was successfully added."
        echo "Make sure your adduser command did not emit errors."
        echo
        VERIFICATION=0
    fi
done

for GROUP in "ta" "students"; do
    if ! id -g $GROUP > /dev/null 2>&1; then
        echo "Unable to locate group $GROUP. Was it successfully created?"
        VERIFICATION=0
    fi
done

if [ $VERIFICATION!=1 ]; then
    exit 0;
fi

# Create a directory tree for showing permissions
sudo mkdir /usr/local/projects

# Create the /usr/local/projects directory and a directory for each student
PROJ_DIR=/usr/local/projects

# For each student:
#   Create student directory
#   Change ownership of the directory to the student
#   Change the group of the student directory
#   Allow the owner full permissions in the student directory
#   Allow the group full permissions in the student directory
#   Remove permissions from all others in the system
for NUM in 1 2; do
    STUD_DIR=${PROJ_DIR}/stud${NUM}_proj
    sudo mkdir ${STUD_DIR}
    sudo chown ${STUD_DIR}
    sudo chgrp ta ${STUD_DIR}
    sudo chmod u+rwx,g+rws,o-rwx ${STUD_DIR}
done



