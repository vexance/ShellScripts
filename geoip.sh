#!/bin/bash
if [[ $1 == '--help' || $1 == '-h' || -z $1 ]]; then
    echo "Get geographic location information for an IP address"
    echo "  Example: ./geoip.sh <ip.addr.to.check>"
    exit
fi

curl "ipinfo.io/$1"
