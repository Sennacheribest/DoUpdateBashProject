# Linuxed-bash Package Updater #1589F0
_`doupdates.sh`_ is an easy to deploy **BASH** script shell for **RPM-based** Linux derives.

## About doupdates.sh
There are two important points to be considered:
1. With Linux realm, performing other jobs on the system while installing updates is a bless.
2. If you were Windows evangelist, Seriousley! Ther are times when rebooting after installation updates is a good idea.
Linux does not do that for you automatically, _thanks to god!_

## Why Should I Care
- Performing updates specially for couple servers requires you to babysitting them while waiting to enter next command when the previous one complete without chaos  
- This would take a great deal of your time to moniter each computer as it went through update procedures.

## Requirements
1. A Linux **RPM** based systems.
2. **Superuser** privileges to run the script
3. Turn on the execution bit of the file as shown:
	```
	[user@host]$ su -
	 Password:
	[root@host]# chmod 700 doupdates.sh
	```
4. A smile on your face :)

## Main Structure of the Script 
- Determine whether any updates are available.
- Determine whether a package that requires a reboot is being updated such as:
	- [x] kernel
	- [x] glibc
	- [x] systemd
- Install those updates.
- If reboot is required, update man pages before hand; if this is not done, new and replacement man pages won't be accessible and old ones that have been removed will appear to be there even though they are not.
- Rebuild the **GRUB** bootloader configuration files so that it includes recovery options for each installed kernel.
- Finally do the reboot if it should.

## License
- Click [**License**](https://raw.githubusercontent.com/Sennacheribest/DoUpdateBashProject/main/LICENSE) for more information. 
