#!/bin/bash
if [[ $1 == '--help' || $1 == '-h' || -z $1 ]]; then
    echo "Attempt to verify validity of a given email address"
    echo "  Example: ./hunterio-verify.sh <username@domain.tld>"
    exit
fi

echo "$1: $(curl -s "https://api.hunter.io/v2/email-verifier?email=$1&api_key=$HUNTERIO_API_KEY" | jq -r '.data.status')";
