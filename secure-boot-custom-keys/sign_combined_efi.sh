#!/usr/bin/env bash

mkdir -p /root/secure_boot &> /dev/null

kernel_name="$1"
initrd_name="$2"
cpu_ucode_name="$3"

#its important that the ucode will be added first
cat "/boot/$cpu_ucode_name" "/boot/$initrd_name" > "/root/secure_boot/$kernel_name-combined_initrd.img" || exit 1

/usr/bin/objcopy \
	--add-section .osrel="/usr/lib/os-release" --change-section-vma .osrel=0x20000 \
	--add-section .cmdline="/root/secure_boot/kernel-command-line.txt" --change-section-vma .cmdline=0x30000 \
	--add-section .splash="/usr/share/systemd/bootctl/splash-arch.bmp" --change-section-vma .splash=0x40000 \
	--add-section .linux="/boot/$kernel_name" --change-section-vma .linux=0x2000000 \
	--add-section .initrd="/root/secure_boot/$kernel_name-combined_initrd.img" --change-section-vma .initrd=0x3000000 \
	"/usr/lib/systemd/boot/efi/linuxx64.efi.stub" "/root/secure_boot/$kernel_name-arch_linux.efi" || exit 1


# the warning about gaps between PE/COFF sections can be savely ignored  
sbsign --key /root/secure_boot/keys/db.key --cert /root/secure_boot/keys/db.crt --output "/boot/$kernel_name-arch_linux.efi" "/root/secure_boot/$kernel_name-arch_linux.efi"
