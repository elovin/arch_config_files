#!/usr/bin/env bash

number_of_current_backups="$(lvs --all | awk '{print $1}' | grep 'backup_*' | wc -l)"


if [ "$number_of_current_backups" -gt 2 ]
then
	for number in $( seq 3 $number_of_current_backups )
	do
		lvremove --yes "/dev/vayu-arch/backup_$number"
	done
fi
