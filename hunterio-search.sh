#!/bin/zsh
curl -o "$PWD/.hunterio-search.tmp" "https://api.hunter.io/v2/domain-search?domain=$1&api_key=$HUNTERIO_API_KEY";
emails=$(cat $PWD/hunterio_raw.json | jq -r '.data.emails' | grep '"value": "');
for entry in $emails; do
    echo $emails | cut -d '"' -f 4;#| jq -r '.value';
done
rm "$PWD/.hunterio-search.tmp";