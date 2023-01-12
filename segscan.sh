#!/bin/bash

# Check help (--help, -h, or no args)
if [[ $1 == '--help' || $1 == '-h' || -z $1 || -z $2 ]]; then
    echo "Execute ping sweep, limited UDP scan, and TCP top 1,500 portscan for segementation checks"
    echo "segscan.sh <scope.txt> <from-vlan-id> <output-dir> [<extra-args>]"
    echo "  scope.txt    : Path to file containing CDE VLANs. Format is VLAN-CIDR (e.g., 1024-10.2.4.0/24)"
    echo "  from-vlan-id : VLAN ID / number from which scan is conducted from (e.g., 802)"
    echo "  output-dir   : Path to output file directory [default: ./SegScanResults]"
    echo "  extra-args    : (Optional) Additional nmap args; use ''"
    exit
fi

if [ -z $3 ]; then
    echo "[x] Output directory not specified, exiting!"
    exit
fi
# Check if output directory exists, create it if not
if [ $3 ]; then
    outdir="$3/"
else
    echo "[x] Directory '$outdir' not found, exiting!'"
    exit
fi

if [ -z $4]; then
    args=""
else
    args=$4
fi

# Loop through each line in scope.txt doc; VLAN ID determines filename, CIDR determines scan targets

echo "[+] [$(date)] segscan intiated"
for entry in $(cat $1); do
    vlanId=$(echo $entry | cut -d '-' -f 1);
    cidr=$(echo $entry | cut -d '-' -f 2);
    
    echo "[+] [$(date)] Starting segscan on $cidr"
    # icmp / ping sweep
    nmap $args -sn -vv -T4 -oX "$outdir/nmap_from_vlan$2_to_vlan$vlanId-icmp.xml" -oN "$outdir/nmap_from_vlan$2_to_vlan$vlanId-icmp.txt" $cidr;
    # UDP - DNS, Kerberos UDP, NFS, SNMP
    masscan $args  --rate 500 -p 'U:53,U:88,U:111,U:161,U:162,U:2049' -oB "$outdir/masscan_from_$2_to_$vlanId-udp.bin" $cidr;
    # TCP - Top 1.5k
    masscan $args --rate 1000 --top-ports 1500 -oB "$outdir/masscan_from_$2_to_$vlanId-tcp.bin" $cidr;
    
    echo "[+] [$(date)] Finished segscan of $cidr"
done
echo "[+] [$(date)] segscan complete"

