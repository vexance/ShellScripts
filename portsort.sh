#!/bin/bash

# Check for help flag; provide example use
if [[ $1 == '--help' || $1 == '-h' || -z $1 ]]; then
    echo "Sort nmap / masscan live ports to various lists"
    echo "portsort.sh <path-to-masscan.txt> [<path-to-output-directory>]"
    exit
fi

# Check if masscan file exits
if [[ ! -f $1 ]]; then
    echo "[x] File '$1' not found, exiting!"
    exit
fi

# Check if output directory is specified
if [ $2 ]; then
    outdir="$2/"
else
    echo "[+] Output directory not specified, defaulting to './Lists/'"
    outdir="./Lists/"
fi

# Create output directory if necessary
if [ ! -d $outdir ]; then
    echo "[!] Directory '$outdir' not found, creating '$outdir'"
    mkdir -p $outdir
fi

# Sort IPs into port list files
echo "[+] Sorting masscan output by port"
for port in $(cat $1 | cut -d ' ' -f 4 | sort -u); do
    portnum=$(echo $port | cut -d '/' -f 1)
    echo "[+] Appending to p$portnum.lst"
    for ip in $(cat $1 | grep " $port" | cut -d ' ' -f 6); do
        echo $ip >> $outdir/p$portnum.lst
    done
done

for file in $(ls $outdir); do
    if   [ $file = "p21.lst" ]; then mv $outdir/$file $outdir/ftp.lst
    elif [ $file = "p22.lst" ]; then mv $outdir/$file $outdir/ssh.lst
    elif [ $file = "p23.lst" ]; then mv $outdir/$file $outdir/telnet.lst
    elif [ $file = "p25.lst" ]; then mv $outdir/$file $outdir/smtp.lst
    elif [ $file = "p53.lst" ]; then mv $outdir/$file $outdir/dns.lst
    elif [ $file = "p80.lst" ]; then mv $outdir/$file $outdir/http.lst
    elif [ $file = "p88.lst" ]; then mv $outdir/$file $outdir/kerberos.lst
    elif [ $file = "p111.lst" ]; then mv $outdir/$file $outdir/nfs.lst
    elif [ $file = "p137.lst" ]; then mv $outdir/$file $outdir/netbios.lst
    elif [ $file = "p161.lst" ]; then mv $outdir/$file $outdir/snmp.lst
    elif [ $file = "p389.lst" ]; then mv $outdir/$file $outdir/ldap.lst
    elif [ $file = "p443.lst" ]; then mv $outdir/$file $outdir/https.lst
    elif [ $file = "p445.lst" ]; then mv $outdir/$file $outdir/smb.lst
    elif [ $file = "p623.lst" ]; then mv $outdir/$file $outdir/ipmi.lst
    elif [ $file = "p636.lst" ]; then mv $outdir/$file $outdir/ldaps.lst
    elif [ $file = "p1433.lst" ]; then mv $outdir/$file $outdir/mssql.lst
    elif [ $file = "p3306.lst" ]; then mv $outdir/$file $outdir/mysql.lst
    elif [ $file = "p3389.lst" ]; then mv $outdir/$file $outdir/rdp.lst
    fi
done

exit
