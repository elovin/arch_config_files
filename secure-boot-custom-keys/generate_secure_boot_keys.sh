#!/usr/bin/env bash

#identification uuid
uuidgen --random > sbGUID.txt

# gen platform key
openssl req -newkey rsa:4096 -nodes -keyout PK.key -new -x509 -sha256 -days 3650 -subj "/CN=archLinux Platform Key/" -out PK.crt
openssl x509 -outform DER -in PK.crt -out PK.cer
cert-to-efi-sig-list -g "$(< sbGUID.txt)" PK.crt PK.esl
sign-efi-sig-list -g "$(< sbGUID.txt)" -k PK.key -c PK.crt PK PK.esl PK.auth

# Sign an empty file to allow removing Platform Key when in "User Mode": 
sign-efi-sig-list -g "$(< sbGUID.txt)" -c PK.crt -k PK.key PK /dev/null rm_PK.auth

# Key Exchange key
openssl req -newkey rsa:4096 -nodes -keyout KEK.key -new -x509 -sha256 -days 3650 -subj "/CN=archLinux Key Exchange Key/" -out KEK.crt
openssl x509 -outform DER -in KEK.crt -out KEK.cer
cert-to-efi-sig-list -g "$(< sbGUID.txt)" KEK.crt KEK.esl
sign-efi-sig-list -g "$(< sbGUID.txt)" -k PK.key -c PK.crt KEK KEK.esl KEK.auth


#Signature Database key: 
openssl req -newkey rsa:4096 -nodes -keyout db.key -new -x509 -sha256 -days 3650 -subj "/CN=archLinux Signature Database key/" -out db.crt
openssl x509 -outform DER -in db.crt -out db.cer
cert-to-efi-sig-list -g "$(< sbGUID.txt)" db.crt db.esl
sign-efi-sig-list -g "$(< sbGUID.txt)" -k KEK.key -c KEK.crt db db.esl db.auth




