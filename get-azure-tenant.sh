#!/bin/bash
if [[ $1 == '--help' || $1 == '-h' || -z $1 ]]; then
    echo "Attempt to identify a domain's azure tenant Id"
    echo "  Example: ./get-azure-tenant.sh <domain.tld>"
    exit
fi

curl -s "https://login.microsoftonline.com/$1/v2.0/.well-known/openid-configuration" | jq

