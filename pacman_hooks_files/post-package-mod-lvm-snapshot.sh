#!/usr/bin/env bash

# lvm(8) man page:
# On invocation, lvm requires that only the standard file descriptors stdin, stdout
# and stderr are available. If others are found, they get closed and messages
# are issued warning about the leak.

# disabling the warnings for now as they dont seem dangerous

export LVM_SUPPRESS_FD_WARNINGS=1

number_of_current_backups="$(lvs --all | awk '{print $1}' | grep 'backup_*' | wc -l)"


if [ "$number_of_current_backups" -gt 2 ]
then
	for number in $( seq 3 $number_of_current_backups )
	do
		lvremove --yes "/dev/vayu-arch/backup_$number"
	done
fi

for backup_volume_name in $(lvs | grep "backup_*" | grep "100.00" | awk '{print $1}')
do 
	lvremove --yes "/dev/vayu-arch/$backup_volume_name"
done
