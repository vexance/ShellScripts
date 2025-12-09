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
    echo "[+] Appending to p$portnum.txt"
    for ip in $(cat $1 | grep " $port" | cut -d ' ' -f 6); do
        echo $ip >> $outdir/p$portnum.txt
    done
done

for file in $(ls $outdir); do
    if   [ $file = "p21.txt" ]; then mv $outdir/$file $outdir/ftp.txt
    elif [ $file = "p22.txt" ]; then mv $outdir/$file $outdir/ssh.txt
    elif [ $file = "p23.txt" ]; then mv $outdir/$file $outdir/telnet.txt
    elif [ $file = "p25.txt" ]; then mv $outdir/$file $outdir/smtp.txt
    elif [ $file = "p53.txt" ]; then mv $outdir/$file $outdir/dns.txt
    elif [ $file = "p80.txt" ]; then mv $outdir/$file $outdir/http.txt
    elif [ $file = "p88.txt" ]; then mv $outdir/$file $outdir/kerberos.txt
    elif [ $file = "p111.txt" ]; then mv $outdir/$file $outdir/nfs.txt
    elif [ $file = "p137.txt" ]; then mv $outdir/$file $outdir/netbios.txt
    elif [ $file = "p161.txt" ]; then mv $outdir/$file $outdir/snmp.txt
    elif [ $file = "p389.txt" ]; then mv $outdir/$file $outdir/ldap.txt
    elif [ $file = "p443.txt" ]; then mv $outdir/$file $outdir/https.txt
    elif [ $file = "p445.txt" ]; then mv $outdir/$file $outdir/smb.txt
    elif [ $file = "p623.txt" ]; then mv $outdir/$file $outdir/ipmi.txt
    elif [ $file = "p636.txt" ]; then mv $outdir/$file $outdir/ldaps.txt
    elif [ $file = "p1433.txt" ]; then mv $outdir/$file $outdir/mssql.txt
    elif [ $file = "p3306.txt" ]; then mv $outdir/$file $outdir/mysql.txt
    elif [ $file = "p3389.txt" ]; then mv $outdir/$file $outdir/rdp.txt
    elif [ $file = "p5900.txt" ]; then mv $outdir/$file $outdir/vnc.txt
    fi
done

exit
