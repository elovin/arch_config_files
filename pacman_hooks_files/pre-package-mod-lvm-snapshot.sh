#!/usr/bin/env bash


# lvm(8) man page:
# On invocation, lvm requires that only the standard file descriptors stdin, stdout
# and stderr are available. If others are found, they get closed and messages
# are issued warning about the leak.

# disabling the warnings for now as they dont seem dangerous
export LVM_SUPPRESS_FD_WARNINGS=1


#configure the number of concurrent backups
maximum_number_of_concurrent_backups=3
number_of_current_backups="$(lvs | awk '{print $1}' | grep 'backup_*' | wc -l)"


if [ "$number_of_current_backups" -ge "$maximum_number_of_concurrent_backups" ]
then

        for backup_name in $(lvs | grep "backup_*" | awk '{print $1}')
        do
                if [ "$number_of_current_backups" -lt "$maximum_number_of_concurrent_backups" ]
                then
                        break
                fi

                lvremove --yes "/dev/[VOLUME_GROUP_NAME]/$backup_name"
                number_of_current_backups="$(lvs | awk '{print $1}' | grep 'backup_*' | wc -l)"
        done
fi


unset backup_name


# also remove snapshots without remaning space
for backup_name in $(lvs | grep "backup_*" | grep "100.00" | awk '{print $1}')
do 
        lvremove --yes "/dev/[VOLUME_GROUP_NAME]/$backup_name"
done



# create new snapshot of root partition with current date as name
# consider moving /var to a different lvm volume so that snapshots grow slower
current_date=`date +"%Y-%m-%d-%H-%M-%S"`
lvcreate -L5G -s -n backup_"$current_date" /dev/[VOLUME_GROUP_NAME]/root
