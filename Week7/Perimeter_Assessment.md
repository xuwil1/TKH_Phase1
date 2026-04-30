# TITANCORP: PERIMETER ASSESSMENT REPORT
**Operator:Willie** **Target Subnet:** 172.88.0.0/24

## PHASE 1: ACTIVE ENUMERATION (NMAP)
*(List the live IPs discovered and their running services/versions)*
* **Host 1 ([172.88.0.10]):** [http    nginx 1.14.2]
* **Host 2 ([172.88.0.15]):** [closed tcp ports]
* **Host 3 ([172.88.0.20]):** [http    Apache httpd 2.4.66 ((Unix))]

## PHASE 2: VULNERABILITY AUDIT (NIKTO)
*(Run Nikto against the TWO web servers discovered above. List one major finding for each.)*
* **Web Server 1 Finding:** [
---------------------------------------------------------------------------
+ Target IP:          172.88.0.10
+ Target Hostname:    172.88.0.10
+ Target Port:        80
+ Start Time:         2026-04-29 23:57:56 (GMT0)
---------------------------------------------------------------------------
+ Server: nginx/1.14.2
+ Server leaks inodes via ETags, header found with file /, fields: 0x5cad421a 0x264 
+ The anti-clickjacking X-Frame-Options header is not present.
+ No CGI Directories found (use '-C all' to force check all possible dirs)
+ 6544 items checked: 0 error(s) and 2 item(s) reported on remote host
+ End Time:           2026-04-29 23:58:03 (GMT0) (7 seconds)
---------------------------------------------------------------------------                                
                            ]
* **Web Server 2 Finding:** [
---------------------------------------------------------------------------
+ Target IP:          172.88.0.20
+ Target Hostname:    172.88.0.20
+ Target Port:        80
+ Start Time:         2026-04-29 23:58:55 (GMT0)
---------------------------------------------------------------------------
+ Server: Apache/2.4.66 (Unix)
+ Server leaks inodes via ETags, header found with file /, fields: 0xbf 0x642fce432f300 
+ The anti-clickjacking X-Frame-Options header is not present.
+ No CGI Directories found (use '-C all' to force check all possible dirs)
+ Allowed HTTP Methods: HEAD, GET, POST, OPTIONS, TRACE 
+ OSVDB-877: HTTP TRACE method is active, suggesting the host is vulnerable to XST
+ 6544 items checked: 0 error(s) and 4 item(s) reported on remote host
+ End Time:           2026-04-29 23:59:02 (GMT0) (7 seconds)
---------------------------------------------------------------------------
]

## PHASE 3: RISK TRIAGE
*(Review your findings. Identify the SINGLE highest-risk vulnerability across the entire DMZ. Justify why it is the top priority using the Likelihood x Impact formula.)*

* **Top Priority Remediation:** [The anti-clickjacking X-Frame-Options header is not present]
* **Justification:** [A hacker can trick the user into clicking buttons they didn't mean to click]
