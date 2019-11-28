#!/bin/bash

echo "This script extracts manually installed yum packages from this system"
#https://askbot.fedoraproject.org/en/question/67231/retrieve-complete-list-of-manually-installed-packages/
#requires yum and sqlite3

if [ "$UID" -ne "0" ]; then
    echo "This script needs to run as root!"
    exit;
fi

if [ "$#" -eq "1" ]; then
    DST=`$1/yum-manual.txt`;
    echo "*** Extracting packages to $DST ***"
    SRC='/var/lib/yum/history/history-*.sqlite'
    sqlite3 "$SRC" "select cmdline from trans_cmdline" | grep -oP  "^(?:-y)?\s*install \K(.*)" | xargs echo > "$DST"
    sqlite3 "$SRC" "select cmdline from trans_cmdline" > "$1/yum-original.txt"
    echo "*** Export done to $DST ***"
else
    echo "Usage: $0 /path/to/temp/dir"
fi
