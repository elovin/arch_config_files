#!/usr/bin/env bash

# lvm(8) man page:
# On invocation, lvm requires that only the standard file descriptors stdin, stdout
# and stderr are available. If others are found, they get closed and messages
# are issued warning about the leak.

# disabling the warnings for now as they dont seem dangerous
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

                lvremove --yes "/dev/archBaseGroup/$backup_name"
                number=$((number+1))
        done
fi

unset backup_name

for backup_name in $(lvs | grep "backup_*" | grep "100.00" | awk '{print $1}')

do
        lvremove --yes "/dev/archBaseGroup/$backup_name"
done


current_date=`date +"%Y-%m-%d-%H-%M-%S"`

lvcreate -L5G -s -n backup_"$current_date" /dev/archBaseGroup/root
