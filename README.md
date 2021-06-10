# BASH Script to Perform Updates
### `doupdates.sh` is an easy to deploy BASH script shell for RPM like dertives.

### About doupdates.sh
There are two important points to be considered:
1. With linux realm, performing other jobs on the system while installing updates is a bless.
2. If you were Windows evangelist; Seriousley!; ther are times when rebooting after installation updates is a good idea.
Linux does not do that for you automatically, _thanks to god!_

### Why Should I Care
- Performing updates specially for couple servers requires you to babysitting them while waiting to enter next command when the previous one complete without chaos  
- This would take a great deal of your time to moniter each computer as it went through update procedures.

### Main Structure of the Script 
- Determine whether any updates are available.
- Determine whether a package that requires a reboot is being updated such as:
	- [ ] kernel
	- [ ] glibc
	- [ ] systemd
- Install those updates.
- If reboot is required, update man pages before hand; if this is not done, new and replacement man pages won't be accessible and old ones that have been removed will appear to be there even though they are not.
- Rebuild the _grub_ boot loader configuration file so that it includes recovery options for each installed kernel.
- Finally do the reboot if it should.

### License
# Click [** License **](https://raw.githubusercontent.com/Sennacheribest/DoUpdateBashProject/main/LICENSE) to read more. 
