#!/bin/bash
if [[ $1 == '--help' || $1 == '-h' || -z $1 ]]; then
    echo "Checks SPF and DMARC records for a given domain"
    echo "  Example: ./check-emailsec.sh <domain.tld>"
    exit
fi

host -t txt $1 | grep --color=auto -iE "$1|\"v=spf.*|has no TXT record|not found"
host -t txt "_dmarc.$1" | grep --color=auto -iE "_dmarc[.]$1|\"v=DMARC.*|none|has no TXT record|not found"
