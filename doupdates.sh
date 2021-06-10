#!/usr/bin/bash
#
dnf check-update
mandb
grub2-mkconfig -o /boot/grub2/grub.cfg
# reboot
