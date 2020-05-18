#!/usr/bin/env bash

/usr/bin/sbsign --key /root/secure_boot/keys/db.key --cert /root/secure_boot/keys/db.crt --output /usr/lib/fwupd/efi/fwupdx64.efi /usr/lib/fwupd/efi/fwupdx64.efi
