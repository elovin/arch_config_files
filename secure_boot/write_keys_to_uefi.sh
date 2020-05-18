#!/usr/bin/env bash

cd keys || exit 1

efi-updatevar -e -f db.esl db || exit 1
efi-updatevar -e -f KEK.esl KEK || exit 1
efi-updatevar -f PK.auth PK || exit 1

cd -
