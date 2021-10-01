#!/bin/bash
if [[ $1 == '--help' || $1 == '-h' || -z $1 ]]; then
    echo "Identify configuration of DNSSEC on a provided domain"
    echo "  Example: ./check-dnssec.sh <domain.tld>"
    exit
fi

for type in {'ds','rrsig','dnskey'}; do host -t $type $1; done
