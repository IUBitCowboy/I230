#!/bin/bash

# This is a script to prep a standard Vagrant ubuntu/xenial64 image
# for Homework 4 of I230.


# Create a directory tree for showing permissions
sudo mkdir /usr/local/projects

# Create the /usr/local/projects directory and a directory for each student
sudo mkdir /usr/local/projects/stud_proj1
sudo mkdir /usr/local/projects/stud_proj2

# change the ownership of the student projects to the students
sudo chown student1 /usr/local/projects/stud_proj1
sudo chown student2 /usr/local/projects/stud_proj2


# change the group of the student projects to ta
sudo chgrp ta /usr/local/projects/stud_proj?

# Allow the owners of the student project directory have full permissions as with the ta's
sudo chmod u+rwx,g+rwx,o-rwx /usr/local/projects/stud_proj?


