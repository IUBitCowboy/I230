#!/bin/bash

# This is a script to prep a standard Vagrant ubuntu/xenial64 image
# for Homework 4 of I230.
VERIFICATION=0
PROJ_DIR=/usr/local/projects

if [ -d ${PROJ_DIR} ]; then
    echo "ERROR: Please delete the previous /usr/locoal/projects directory before proceeding."
    echo "ERROR:   try   sudo rm -fr /usr/local/projects"
    exit 1
fi

for GROUP in "ta" "students"; do
    if ! grep -E -q "^${GROUP}:" /etc/group; then
        echo "WARNING: Unable to locate group $GROUP. Was it successfully created?"
        ((VERIFICATION=VERIFICATION+1))
    fi
done

# Verify the users have been created
for USER in "vagrant" "student1" "student2" "instructor"; do
    if ! id -u $USER  >/dev/null 2>&1; then
        echo "WARNING: It doesn't look like $USER was successfully added."
        echo "WARNING: Make sure your adduser command did not emit errors."
        echo
        ((VERIFICATION=VERIFICATION+1))
    fi
done

for USER in "student1" "student2"; do
    if ! grep students /etc/group | grep -E -q -w ${USER}; then
        echo "WARNING: ${USER} not in group students."
        ((VERIFICATION=VERIFICATION+1))
    fi
done

if ! grep ta /etc/group | grep -E -q -w "instructor"; then
    echo "WARNING: instructor not in group ta."
    ((VERIFICATION=VERIFICATION+1))
fi


if [ $VERIFICATION -gt 0 ]; then
    echo "ERROR: Unable to verify the accounts or groups. $VERIFICATION"
    echo "ERROR: Directories were NOT created."
    exit 0;
fi

# Create the /usr/local/projects directory and a directory for each student
PROJ_DIR=/usr/local/projects

# Create a directory tree for showing permissions
sudo mkdir ${PROJ_DIR}

# For each student:
#   Create student directory
#   Change ownership of the directory to the student
#   Change the group of the student directory
#   Allow the owner full permissions in the student directory
#   Allow the group full permissions in the student directory
#   Remove permissions from all others in the system
for NUM in $(seq 2); do
    STUDENT=student${NUM}
    MSG="This is the report submitted by ${STUDENT}."
    STUD_DIR=${PROJ_DIR}/stud${NUM}_proj
    sudo mkdir ${STUD_DIR}
    sudo chown ${STUDENT} ${STUD_DIR}
    sudo chgrp ta ${STUD_DIR}
    sudo chmod u+rwx,g+rws,o-rwx ${STUD_DIR}
    sudo -u ${STUDENT} /bin/bash -c "echo $MSG > ${STUD_DIR}/my_report.txt"
done

echo "Many scripts and commands will not be so verbose and tell you if they"
echo "completed successfully like this one does. Directories created."
echo "Exiting successfully."
exit 0

