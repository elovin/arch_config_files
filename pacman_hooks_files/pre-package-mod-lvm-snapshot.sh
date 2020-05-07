#!/usr/bin/env bash

# lvm(8) man page:
# On invocation, lvm requires that only the standard file descriptors stdin, stdout
# and stderr are available. If others are found, they get closed and messages
# are issued warning about the leak.

# disabling the warnings for now as they dont seem dangerous

export LVM_SUPPRESS_FD_WARNINGS=1

current_date=`date +"%Y-%m-%d-%H-%M-%S"`
lvcreate -L5G -s -n backup_"$current_date" /dev/vayu-arch/root

