(Arguably) Useful Shellscripts
=================================

### Scripts
* `geoip.sh` Queries ipinfo.io for geolocation details on a given IP address.
* `hunterio-search.sh` Queries hunter.io for emails potentiall related to a given domain. Requires an API key to be set in an environment variable (HUNTERIO_API_KEY).
* `hunterio-verify.sh` Queries hunter.io to verify the validity of a provided email address. Requires HUNTERIO_API_KEY in the environment variable.
* `o365authcheck.sh` Checks the authentication method in use for a domain's Office 365 tenant. Managed authentication can be leveraged to enumerate usernames.
* `portsort.sh` Sorts masscan / nmap output into various IP lists based of port number / protocol name

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