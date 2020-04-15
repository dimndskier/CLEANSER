#!/usr/bin/bash

# Version:=0.1.2

# VARS
# set variables using the source command and vars4CLEANSER file.
source vars4CLEANSER

# Suggest what files are available for being actually cleansed
find ${APPHome}/0originals/

# Ask user for filename to cleanse
read -p "What is the full path to the file you wish to cleanse? " FILE
FILE=`basename $FILE`
newFILE="`echo ${FILE%%.orig*}`.filtered"

sed -f ${APPHome}/sed.cleanser < ${APPHome}/0originals/$FILE > ${APPHome}/0filtered/${newFILE}
