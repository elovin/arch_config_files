alias auth-thinkpad-dock='sudo boltctl authorize 0097d1a8-0a84-0801-ffff-ffffffffffff'
alias rollback_last_backup="sudo lvconvert --merge vayu-arch/$(sudo lvs | grep backup | tail -n 1 | awk '{print $1}')"
alias remove_pacman_lock_file='sudo rm /var/lib/pacman/db.lck'
