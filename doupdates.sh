#!/usr/bin/bash
#
# Initialize variables
#=====================
_CHECK=0
_DO_REBOOT=0
_NEEDS_REBOOT=0
_UPDATES_AVAILABLE=0
_UPDATES_FILE="/tmp/updates.list"
_NUM_OF_AVAILABLE_PACKAGES=0
#=====================

# Check for root
#=====================================================================
if [ ${UID} -ne 0 ]
then
	echo " ---> You don't have superuser privileges to run this script!"
	exit 1
fi
#=====================================================================

############################
# Main body of the program #
############################

# Process command input options
#================================================
while getopts ":cr" _OPTION;
do
	case ${_OPTION} in
		# Check option enablement
		c) # Check option enablement
		   _CHECK=1;;
		r) # Reboot option enablement
		   _DO_REBOOT=1;;
		\?) # Incorrect options
		    echo " ---> ERROR: invalid option."
		    exit 1;;
	esac
done
#================================================

<<obselet-code
if [ ${_CHECK} == 1 ]
then
	# Check for updates
	dnf check-update
fi
obselet-code

# take a snapshot of available updates and save it in _UPDATES_FILE variable
#===========================================================================
dnf check-update > ${_UPDATES_FILE}
#===========================================================================

# modify script logic to quit with a message if there are no updates available now
# facilitale the RC (Returen Code) from the command "dnf check-update"; 100: if available, 0: if not;
# and use that as a side effect to create a list of updates that can be searched for item that will 
# trigger a reboot logic.
#====================================================================================================
_UPDATES_AVAILABLE=${?}
if [ ${_UPDATES_AVAILABLE} -eq 0 ]
then
	echo " ---> Updates are NOT available for host ${HOSTNAME} at this time."
	exit 0
else
	_NUM_OF_AVAILABLE_PACKAGES=$(wc -l /tmp/updates.list | awk '{print $1}')
	echo " ---> ${_NUM_OF_AVAILABLE_PACKAGES} Updates are AVAILABLE for host ${HOSTNAME}."
	if [ ${_CHECK} -eq 1 ]
	then
		exit 0
	fi
fi
#====================================================================================================

# Update the man page
#====
#mandb
#====

# Update the man pages database
#=====================================
#grub2-mkconfig -o /boot/grub2/grub.cfg
#=====================================

# Reboot if necessary
#============================
if [ ${_DO_REBOOT} == 1 ]
then
	echo " ---> Oops! I'm rebooting..."	# Doing test check without actual reboot
	#reboot
else
	echo " ---> Not rebooting."
fi
#============================
