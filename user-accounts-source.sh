#!/bin/bash

echo "This script extracts and archives user accounts on this system for transfer to a new system"

if [ "$UID" -ne "0" ]; then
    echo "This script needs to run as root!"
    exit;
fi

if [ "$#" -eq "1" ]; then
    DST=`mktemp -d -p "$1"`;
    if [ -z "$DST" ]; then
       echo "Unable to create destination temporary directory"
       exit;
    fi

    echo "*** Backing up user accounts to $DST ***"
    export UGIDLIMIT=500
    awk -v LIMIT=$UGIDLIMIT -F: '($3>=LIMIT) && ($3!=65534)' /etc/passwd > "$DST/passwd.mig"
    awk -v LIMIT=$UGIDLIMIT -F: '($3>=LIMIT) && ($3!=65534)' /etc/group > "$DST/group.mig"
    awk -v LIMIT=$UGIDLIMIT -F: '($3>=LIMIT) && ($3!=65534) {print $1}' /etc/passwd | tee - |egrep -f - /etc/shadow > "$DST/shadow.mig"
    cp /etc/gshadow "$DST/gshadow.mig"
    tar -zcvpf "$DST/home.tar.gz" /home

    echo "*** Export done to $DST ***"
else
    echo "Usage: $0 /path/to/temp/dir"
fi
