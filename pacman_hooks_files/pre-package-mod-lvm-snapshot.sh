#!/usr/bin/env bash

# lvm(8) man page:
# On invocation, lvm requires that only the standard file descriptors stdin, stdout
# and stderr are available. If others are found, they get closed and messages
# are issued warning about the leak.

# disabling the warnings for now as they dont seem dangerous

export LVM_SUPPRESS_FD_WARNINGS=1


number_of_current_backups="$(lvs --all | awk '{print $1}' | grep 'backup_*' | wc -l)"

for (( number=$number_of_current_backups; number>0; number-- ))
do
	lvrename vayu-arch "backup_$number" "backup_$((number+1))"
done

lvcreate -L5G -s -n backup_1 /dev/vayu-arch/root

