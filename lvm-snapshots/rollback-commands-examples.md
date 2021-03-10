# fish

```
function rollback_last_backup
        sudo lvconvert --merge "/dev/vayu-arch/(sudo lvs | awk '{print $1}' | grep 'backup_*' | tail -n 1)"
end

function rollback_oldest_backup
        sudo lvconvert --merge "/dev/vayu-arch/(sudo lvs | awk '{print $1}' | grep 'backup_*' | head -n 1)"
end
```

# bash / zsh

```
rollback_last_backup(){
        sudo lvconvert --merge "vayu-arch/$(sudo lvs | grep backup | tail -n 1 | awk '{print $1}')"
}
```