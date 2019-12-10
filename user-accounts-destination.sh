#!/bin/bash -x

echo "This script restores and unpacks user accounts on this system from a backup".
echo "**** WARNING! The script can run only once and has no sanity checks! ****"
read -p "Press enter to continue"


if [ "$UID" -ne "0" ]; then
    echo "This script needs to run as root!"
    exit;
fi

if [ "$#" -eq "1" ]; then
    SRC=$1;
    #backup current users/accounts
    BKP=`mktemp -d -p "/root/"`;
    cp /etc/passwd /etc/shadow /etc/group /etc/gshadow "$BKP"
    cd "$SRC"
    cat passwd.mig >> /etc/passwd
    cat group.mig >> /etc/group
    cat shadow.mig >> /etc/shadow
    cp gshadow.mig /etc/gshadow

    #restore /home
    cd /
    tar -zxvf "$SRC/home.tar.gz"

    #restore crontabs
    cp "$SRC"/crontab/* /var/spool/crontabs

    echo "Done. Backups are in $BKP. You can delete $SRC."
else
    echo "Usage: $0 /path/to/backup/dir"
fi