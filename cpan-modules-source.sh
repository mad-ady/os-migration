#!/bin/bash -x

echo "This script extracts and archives user accounts on this system for transfer to a new system"

if [ "$UID" -ne "0" ]; then
    echo "This script needs to run as root!"
    exit;
fi

perl -MCPAN -eautobundle

echo "*** To install on a new system:
   mkdir /root/.cpan/Bundle
   cp Snapshot_*.pm /root/.cpan/Bundle/
   perl -MCPAN -e 'install Bundle::Snapshot_2019_12_10_00'
"
