#!/bin/bash
if [[ $1 == '--help' || $1 == '-h' || -z $1 ]]; then
    echo "Check domain Office 364 authentication type"
    echo "  Example: ./o365authcheck.sh <domain.tld>"
    exit
fi

curl -s "https://login.microsoftonline.com/getuserrealm.srf?login=username@$1&xml=1" | xmllint --format - | grep -A 1 -B 1 "<NameSpaceType>.*</NameSpaceType>" --color=auto
