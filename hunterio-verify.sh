#!/bin/zsh
echo "$1: $(curl -s "https://api.hunter.io/v2/email-verifier?email=$1&api_key=$HUNTERIO_API_KEY" | jq -r '.data.status')";
