#!/usr/bin/bash

# Version:=0.1.2

# Purpose: This script is used to find all data that matches the patterns of concern, such as:
#		- TO_email addresses, to be replaced with recptAddr (in another script)
#		- FROM_email addresses, to be replaced with senderAddr (in another script)
#		- IP Addresses (masking certain bytes with a letter code to help reverse engineer)
#		- This_Servers_Name

# How It Works
# Run the script, provide the _single_ filename to be checked when prompted or on the commandline.
#  The script will output all of the possible pattern matches for _YOU_ to determine what is legitimate.
#  You copy them to the cleanser.sed into the appropriate sections for what you want to be replaced, where.
#
# Limitations
# As of this version, this script can only be used against a single file to tease out the details 
#  being sought after (TO_email, FROM_email, IP Addresses)

source vars4CLEANSER

#  Make, only if necessary, the subdirectories of CLEANSER; to ensure success.
test ! -d ${APPHome}/0originals && mkdir 0originals && echo "Subdirectory 0originals created."
test ! -d ${APPHome}/0filtered  && mkdir 0filtered  && echo "Subdirectory 0filtered created."
test ! -d ${APPHome}/0targets   && mkdir 0targets   && echo "Subdirectory 0targets created."

# Determine the hostname in the file, if relevant
SRVR=`less /var/log/messages | awk '{ print $4 }'| uniq`

if [ $# -eq 1 ]; then
    # What file to seek out patterns from
    infile="$1"
    # truncate the path from the infile given
    justfile=`basename $1`
    # Define the new path for the output of what details to seek out from the justfile copy
    outfile="${APPHome}/0targets/${justfile}.out.$$"
    
    # Copy original file into backup location, to prevent potential damage
    cp $infile ${APPHome}/0originals/${justfile}.orig 
    
    # Found "TO_Emails"
    echo -e "DataSource=${SRVR}@${infile}\n\n\nTO_Emails:::" > ${outfile}
    egrep -n "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" $infile | egrep -v "42.service" >> ${outfile}
    # Found "FROM_Emails"
    echo -e "\n\n\nFROM_Emails:::" >> ${outfile}
    egrep -n "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" $infile | egrep -v "42.service" >> ${outfile}
    # Found IP Addresses
    echo -e "\n\n\nIP_Addrs:::" >> ${outfile}
    egrep -n "[[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}" $infile >> ${outfile}
else
  echo "This many items were found on the line: $#"
  exit
fi

