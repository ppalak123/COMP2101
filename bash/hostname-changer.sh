#!/bin/bash
#
# This script is for the bash lab on variables, dynamic data, and user input
# Download the script, do the tasks described in the comments
# Test your script, run it on the production server, screenshot that
# Send your script to your github repo, and submit the URL with screenshot on Blackboard

# Get the current hostname using the hostname command and save it in a variable

# Tell the user what the current hostname is in a human friendly way

# Ask for the user's student number using the read command

# Use that to save the desired hostname of pcNNNNNNNNNN in a variable, where NNNNNNNNN is the student number entered by the user

# If that hostname is not already in the /etc/hosts file, change the old hostname in that file to the new name using sed or something similar and
#     tell the user you did that
#e.g. sed -i "s/$oldname/$newname/" /etc/hosts

# If that hostname is not the current hostname, change it using the hostnamectl command and
#     tell the user you changed the current hostname and they should reboot to make sure the new name takes full effect
#e.g. hostnamectl set-hostname $newname

oldname=`hostname`

echo "Enter your student number:"
read number
newname="pc$number"

if grep -q "$newname" "/etc/hosts";
then
    echo "Hostname already exists"
else
	sudo sed -i "s/$oldname/$newname/g" /etc/hosts
	echo "/etc/hosts file has been edited changed from $oldname to $newname"
fi

if [[ "$newname" != "$oldname" ]];
then
	sudo hostnamectl set-hostname "$newname"
	echo "Hostname changed. Please reboot for changes to take effect!"
fi
