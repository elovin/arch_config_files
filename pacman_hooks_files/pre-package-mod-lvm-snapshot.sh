#!/usr/bin/env bash

number_of_current_backups="$(lvs --all | awk '{print $1}' | grep 'backup_*' | wc -l)"

for (( number=$number_of_current_backups; number>0; number-- ))
do
	lvrename vayu-arch "backup_$number" "backup_$((number+1))"
done

lvcreate -L5G -s -n backup_1 /dev/vayu-arch/root

