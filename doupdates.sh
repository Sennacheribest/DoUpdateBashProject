#!/usr/bin/bash
#
# Initialize variables
_CHECK=1
_DO_REBOOT=0

# Main body of the program
# first we decide whether to do the updates or just check whether any are availables
if [ ${_CHECK} == 1 ]
then
	# Check for updates
	dnf check-update
fi

# Update the man page
mandb

# Update the man pages database
grub2-mkconfig -o /boot/grub2/grub.cfg

# Reboot if necessary
if [ ${_DO_REBOOT} == 1 ]
then
	reboot
else
	echo "Not rebooting."
fi
