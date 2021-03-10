function rollback_last_backup
        sudo lvconvert --merge "/dev/vayu-arch/(sudo lvs | awk '{print $1}' | grep 'backup_*' | tail -n 1)"
end

function rollback_oldest_backup
        sudo lvconvert --merge "/dev/vayu-arch/(sudo lvs | awk '{print $1}' | grep 'backup_*' | head -n 1)"
end

function rm
	echo "if you have to use rm use command rm .."
end

alias auth-thinkpad-dock='sudo boltctl authorize 0097d1a8-0a84-0801-ffff-ffffffffffff'
alias remove_pacman_lock_file='sudo /bin/rm /var/lib/pacman/db.lck'

alias max-power='sudo cpupower frequency-set -g performance'
alias min-power='sudo cpupower frequency-set -g powersave'
alias suspend='sudo systemctl suspend'
