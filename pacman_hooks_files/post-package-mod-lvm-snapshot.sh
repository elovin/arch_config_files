#!/usr/bin/env bash

export LVM_SUPPRESS_FD_WARNINGS=1

number_of_current_backups="$(lvs --all | awk '{print $1}' | grep 'backup_*' | wc -l)"


if [ "$number_of_current_backups" -gt 3 ]
then
	number=1

	for backup_name in $(lvs | grep "backup_*" | awk '{print $1}')
	do
		if [ $((number+3)) -gt "$number_of_current_backups" ]
		then
			break
		fi
		lvremove --yes "/dev/vayu-arch/$backup_name"
		number=$((number+1))
	done
fi

unset backup_name

for backup_name in $(lvs | grep "backup_*" | grep "100.00" | awk '{print $1}')
do 
	lvremove --yes "/dev/vayu-arch/$backup_name"
done
