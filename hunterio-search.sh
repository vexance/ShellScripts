#!/bin/bash
if [[ $1 == '--help' || $1 == '-h' || -z $1 ]]; then
    echo "Identify potential emails associated with a domain name"
    echo "  Example: ./hunterio-search.sh <domain.tld>"
    exit
fi

curl -o "$PWD/.hunterio-search.tmp" -s "https://api.hunter.io/v2/domain-search?domain=$1&api_key=$HUNTERIO_API_KEY";
emails=$(cat $PWD/.hunterio-search.tmp | jq -r '.data.emails' | grep '"value": "');
for entry in $emails; do
    echo $emails | cut -d '"' -f 4;#| jq -r '.value';
done
rm "$PWD/.hunterio-search.tmp";