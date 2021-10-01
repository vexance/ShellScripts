(Arguably) Useful Shellscripts
=================================
A small collection of short shellscripts / bash one-liners that *may* improve a security tester's QoL.

### Scripts
* `geoip.sh` Queries ipinfo.io for geolocation details on a given IP address.
* `hunterio-search.sh` Queries hunter.io for emails potentiall related to a given domain. Requires an API key to be set in an environment variable (HUNTERIO_API_KEY).
* `hunterio-verify.sh` Queries hunter.io to verify the validity of a provided email address. Requires HUNTERIO_API_KEY in the environment variable.
* `o365authcheck.sh` Checks the authentication method in use for a domain's Office 365 tenant. Managed authentication can be leveraged to enumerate usernames.
* `portsort.sh` Sorts masscan / nmap output into various IP lists based of port number / protocol name
* `check-dnssec.sh` Checks a domain's DNS records for DS, DNSKEY, and RRSIG records to see if DNSSEC is configured
* `check-emailsec.sh` Checks a domain's DNS records for TXT entries indicating SPF and DMARC policies
---

#### Examples
```bash
geoip.sh 8.8.8.8
{
  "ip": "8.8.8.8",
  "hostname": "dns.google",
  "anycast": true,
  "city": "Mountain View",
  "region": "California",
  "country": "US",
  "loc": "37.4056,-122.0775",
  "org": "AS15169 Google LLC",
  "postal": "94043",
  "timezone": "America/Los_Angeles",
  "readme": "https://ipinfo.io/missingauth"
}
```

```bash
hunterio-search.sh example.com
exampleone@example.com
exampletwo@example.com
```

```bash
hunterio-verify.sh exampleone@example.com
exampleone@example.com: invalid

hunterio-verify.sh exampletwo@example.com
exampletwo@example.com: valid
```

```bash
o365authcheck.sh example.com
  <Login>username@example.com</Login>
  <NameSpaceType>Managed</NameSpaceType>
  <DomainName>example.com</DomainName>
```

```bash
portsort.sh ./path/to/masscan.txt ./path/to/output/directory
```
```bash
check-dnssec.sh test.com
test.com has no DS record
test.com has no RRSIG record
test.com has no DNSKEY record

check-dnssec.sh example.com
example.com has DS record 31406 8 1 189968811E6EBA862DD6C209F75623D8D9ED9142
example.com has DS record 31589 8 1 3490A6806D47F17A34C29E2CE80E8A999FFBE4BE
example.com has DS record 43547 8 1 B6225AB2CC613E0DCA7962BDC2342EA4F1B56083
example.com has DS record 43547 8 2 615A64233543F66F44D68933625B17497C89A70E858ED76A2145997E DF96A918
example.com has DS record 31406 8 2 F78CF3344F72137235098ECBBD08947C2C9001C7F6A085A17F518B5D 8F6B916D
example.com has DS record 31589 8 2 CDE0D742D6998AA554A92D890F8184C698CFAC8A26FA59875A990C03 E576343C
example.com has RRSIG record DS 8 2 86400 20211006041604 20210929030604 39343 com. SesDgMyKkKtREdNP+0LMWAch0Iy7EJ4I3+uEO7Phs/aHFtByUMukwELw QkRxL9fbzVx6TYyO3Nu284vnEj93yTLM5ePLizI00p/eC0KrW0aJGO2E TH4cLLQysmhRqsT4fcQo8fcmTBBDttnURkpAUzDKRkLXLdgf3lDUU139 gA87NZbaICssplR3xXgHhLzrpZt04zh1PeCBkxF0GzePJA==
example.com has DNSKEY record 257 3 8 AwEAAZ0aqu1rJ6orJynrRfNpPmayJZoAx9Ic2/Rl9VQWLMHyjxxem3VU SoNUIFXERQbj0A9Ogp0zDM9YIccKLRd6LmWiDCt7UJQxVdD+heb5Ec4q lqGmyX9MDabkvX2NvMwsUecbYBq8oXeTT9LRmCUt9KUt/WOi6DKECxoG /bWTykrXyBR8elD+SQY43OAVjlWrVltHxgp4/rhBCvRbmdflunaPIgu2 7eE2U4myDSLT8a4A0rB5uHG4PkOa9dIRs9y00M2mWf4lyPee7vi5few2 dbayHXmieGcaAHrx76NGAABeY393xjlmDNcUkF1gpNWUla4fWZbbaYQz A93mLdrng+M=
example.com has DNSKEY record 257 3 8 AwEAAbOFAxl+Lkt0UMglZizKEC1AxUu8zlj65KYatR5wBWMrh18TYzK/ ig6Y1t5YTWCO68bynorpNu9fqNFALX7bVl9/gybA0v0EhF+dgXmoUfRX 7ksMGgBvtfa2/Y9a3klXNLqkTszIQ4PEMVCjtryl19Be9/PkFeC9ITjg MRQsQhmB39eyMYnal+f3bUxKk4fq7cuEU0dbRpue4H/N6jPucXWOwiMA kTJhghqgy+o9FfIp+tR/emKao94/wpVXDcPf5B18j7xz2SvTTxiuqCzC MtsxnikZHcoh1j4g+Y1B8zIMIvrEM+pZGhh/Yuf4RwCBgaYCi9hpiMWV vS4WBzx0/lU=
example.com has DNSKEY record 256 3 8 AwEAAd0r756MOcFM1jtDwNY/45mvMBIvpnxz7X7pIZ/KzhFuBQ8n7Wlo KUCvlrlF6hljlsO0dXDJUvY9N1Q+kjWGTVQjXRHwEngIfU8cVwOraYoM bIcp9ty0hSXqgijNu7sVVRrWfhsfyFI82AFMjXpoKwyaMUe8/VT4OUkl E5gdYXAR
```
```bash
check-emailsec.sh example.com
example.com descriptive text "8j5nfqld20zpcyr8xjw0ydcfq9rk8hgm"
example.com descriptive text "v=spf1 -all"
Host _dmarc.example.com not found: 3(NXDOMAIN)
```