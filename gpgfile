#!/bin/sh


# edit this to match your key's real name
KEY="$GPGKEY"


if [ $# -gt 1 ];then
    echo "usage: $0 [file]"
    exit 1
fi

if ! which gpg >/dev/null 2>&1;then
    echo "gpg not found!"
    exit 1
fi

if ! gpg --list-keys "$KEY" >/dev/null 2>&1; then
    echo "Create your GPG key first and set identity in $0"
    exit 1
fi

if [ $# -lt 1 ];then
    FILE="$HOME/creds"
else
    FILE="$1"
fi


FILE_UNENCRYPTED=`mktemp 2>/dev/null` || exit 1
trap "rm -f $FILE_UNENCRYPTED" 0 1 2 5 15


# file does not contain GPG encrypted data, just move it to the unencrypted file
if [ -f "$FILE" ] && gpg -d --list-only "$FILE" >/dev/null 2>&1; then

    DISPLAY="" gpg --yes -d -r "$KEY" -o "$FILE_UNENCRYPTED" "$FILE" > /dev/null  2>&1 || exit 1

elif [ -f "$FILE" ];then

    mv "$FILE" "$FILE_UNENCRYPTED"

fi

$EDITOR "$FILE_UNENCRYPTED" 2> /dev/null
gpg --yes -e -r "$KEY" -o "$FILE" "$FILE_UNENCRYPTED" || \
    (mv "$FILE_UNENCRYPTED" "$FILE"; echo "gpg encryption failed, file $FILE not encrypted"; exit 1)
rm -f "$FILE_UNENCRYPTED"
