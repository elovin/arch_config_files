#!/usr/bin/env bash

sbsign --key /root/secure_boot/keys/db.key --cert /root/secure_boot/keys/db.crt --output /boot/EFI/systemd/systemd-bootx64.efi /boot/EFI/systemd/systemd-bootx64.efi
