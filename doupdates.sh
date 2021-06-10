#!/usr/bin/bash
#
#=====================
# Initialize variables
_CHECK=0
_DO_REBOOT=0
_NEEDS_REBOOT=0
_UPDATES_AVAILABLE=0
_UPDATES_FILE="/tmp/updates.list"
_NUM_OF_AVAILABLE_PACKAGES=0
#=====================

#=====================================================================
# Check for root
if [ ${UID} -ne 0 ]
then
	echo " ---> You don't have superuser privileges to run this script!"
	exit 1
fi
#=====================================================================

############################
# Main body of the program #
############################

#================================================
# Process command input options
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

#====================================================================================================
# take a snapshot of available updates and save it in _UPDATES_FILE variable
dnf check-update > ${_UPDATES_FILE}

# modify script logic to quit with a message if there are no updates available now
# facilitale the RC (Returen Code) from the command "dnf check-update"; 100: if available, 0: if not;
# and use that as a side effect to create a list of updates that can be searched for item that will 
# trigger a reboot logic.

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

#=====================================================
# Check for specific packages that need system reboots
# dose update list include a new kernel
if grep ^kernel ${_UPDATES_FILE} > /dev/null
then
	_NEEDS_REBOOT=1
	echo " ---> KERNEL update for ${HOSTNAME}"
fi
# does update list include a new glibc
if grep ^glibc ${_UPDATES_FILE} > /dev/null
then
	_NEEDS_REBOOT=1
	echo " ---> GLIBC update for ${HOSTNAME}"
fi
# does update list include a new systemd
if grep ^systemd ${_UPDATES_FILE} > /dev/null
then
	_NEEDS_REBOOT=1
	echo " ---> SYSTEMD update for ${HOSTNAME}"
fi
#=====================================================

# Update the man page
#====
#mandb
#====

#=====================================
# Update the man pages database
#grub2-mkconfig -o /boot/grub2/grub.cfg
#=====================================

#=======================================================================================
# Reboot if necessary
if [ ${_NEEDS_REBOOT} -eq 0 ]
then
	echo -e "\n ---> A system reboot is NOT required.\n"
elif [ ${_DO_REBOOT} -eq 1 ] && [ ${_NEEDS_REBOOT} -eq 1 ]
then
	echo -e "\n ---> System is REBOOTING...\n"
#	reboot
elif [ ${_DO_REBOOT} -eq 0 ] && [ ${_NEEDS_REBOOT} -eq 1 ]
then
	echo -e "\n ---> A system REBOOT is needed."
	echo -e " ---> Be sure to REBOOT the system at the earliest opportunity.\n"
else
	echo -e "\n ---> An ERROR has occured and the programm cannot determine whether"
	echo -e "        to reboot or not. INTERVENTION is required.\n"
fi
#=======================================================================================

