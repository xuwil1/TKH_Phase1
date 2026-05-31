# Phase 1 Final Reckoning — TEPP Post-Mortem
**Operator:** [Willie Xu]  
**Date:** May 28, 2026  
**Repository:** [https://github.com/xuwil1/TKH_Phase1/tree/main]  
**TKH Innovation Fellowship 2026 | Phase 1 | Cybersecurity**

---

## Phase 0: Reconnaissance

### Triage Network — 172.100.0.0/24  
A network sweep of 172.100.0.0/24 subnet successfully identified three live target hosts at IP addresses 172.100.0.11, 172.100.0.12, and 172.100.0.13. Further port scanning showed that host 172.100.0.11 left port 6379 wide open, exposing an unauthenticated Redis key-value store running version 8.6.2. Port scanning host 172.100.0.12 exposed an active FTP service on port 21 running vsftpd version 3.0.2. Port scanning ost 172.100.0.13 did not exhibit any exposed external TCP ports, indicating a hardened exterior or an exclusively internal-facing deployment strategy.
### Breach Network — 172.80.0.0/24  
An initial host discovery sweep utilizing Nmap ping scans was executed across the entire 172.80.0.0/24 network segment. The scan results indicated that the only active node was 172.80.0.1. Consequently, this network was triaged as inactive. The lack of external perimeter vulnerabilities in this subnet informs the Phase 2 approach by focusing all lateral movement and credential-cracking analysis on the assets compromised within the active 172.100.0.x hosts.
### Exploitation Network — 172.60.0.0/24  
Nmap ping scans was conducted on the 172.60.0.0/24 subnet to enumerate live targets. Similar to the breach network, host discovery confirmed that zero external target servers were active within this subnet. Similiar to the breach network, because no live hosts or open network sockets were exposed on this segment, all efforts were focused on the exposed active 172.100.0.x hosts.  

---

## Phase 1: Rapid Triage

### Server 1 — 172.100.0.11  
**Vulnerability Identified:**  
The target host is running an unauthenticated Redis key-value store (version 8.6.2) bound to all network interfaces on port 6379. This was confirmed by using Nmap to scan target 172.100.0.11.
**Remediation Commands:**  
sudo docker exec -it broken_server_1 sh
netstat -tlnp
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -p tcp --dport 6379 -j DROP
**Before State:**  
Prior to remediation the Redis service inside the container allowed the database engine to listen indiscrimantely on port 6379 across all external interface.
**After State:**  
A scan report shows that port 6379/tcp transitioned from an open status to a filtered status. 

**Analysis:**  
An unauthenticated Redis database deployment inside an enterprise network perimeter presents a severe vulnerability layer that amplifies the threat of lateral movement and full system compromise. The database engine executes commands natively without verifying access tokens, meaning, attackers can manipulate critical application variables, extract memory datasets, or perform unauthorized administrative reconfigurations. Furthermore, if the server context possesses write permissions to the underlying host filesystem, attackers can abuse data-persistence functions to overwrite configuration folders, insert rogue SSH authorized keys, or plant arbitrary code execution web-shells that facilitate a complete operational takeover.  
### Server 2 — 172.100.0.12
**Vulnerability Identified:**  
A rogue FTP service was running. This was confirmed using Nmap scan of 172.100.0.12.  
**Remediation Commands:**  
sudo docker exec -it broken_server_2 sh
pkill vsftpd
sudo docker rm broken_server_2  
**Before State:**  
A rogue instance of vsftpd 3.0.2 application layer was actively running inside the broken_server_2 container and exposing ports 20 and 21 to the local network architecture.  
**After State:**  
After termination, a scan report utilizing Nmap was run on target host 172.100.0.12 resulting in zero active hosts in the server.
**Analysis:**  
An enterprise network environment containing a rogue FTP service exposes the organization to severe risks such as the protocol transimitting all session authentication handles and raw payloads over the internet in cleartext format. Malicious attackers can easily harvest administrative credentials using basic packet-sniffing utilities to exfiltrate data. The presence of rogue software compromises compliance frameworks and establishes unmonitored backdoors that bypass centralized access controls.  
### Server 3 — 172.100.0.13
**Vulnerability Identified:**  
The web application root directory /var/www/html had '777' permission.  
**Remediation Commands:**  
sudo docker exec -it broken_server_3 sh  
cd /var/www  
chmod 755 html  
**Before State:**  
Prior to remediation, the web application deployment root directory /var/www/html was left world-writable ('777'). This permitted any local user or compromised service account on the system to inject, modify, or erase application source code payloads.  
**After State:**  
After adjusting html, the web root folder was sucessfully locked down to standard baseline security settings('755'). Public the execution of the chmod adjustment, the web root folder was successfully locked down to standard baseline security settings ('755'). The owner can read, write, and run. Meanwhile everyone else is restricted to reading and executing only.  
**Analysis:**  
Leaving deployment or web root paths world-writable ('777') introduces severe systemic risk by opening direct pathways for local privilege escalation and persistent code injection. If an attacker leverages a vulnerability in a separate application to gain a low-privileged foothold on the asset, they can exploit this permission leak to plant web shells or modify operational binaries. Restricting filesystem nodes using strict directory baseline controls enforces the Principle of Least Privilege and preserves environment integrity.

---

## Phase 2: The Breach

**Cracked Credentials:**
- Username: [root]
- Password: [admin123]

**Forensic Evidence:**
- Exact Timestamp of Successful Login: [N/A no timestamp in log]
- Attacker IP Address: [172.80.0.2 port 47336]

**Engineered iptables Rule:**
iptables -A INPUT -s 172.80.0.2 -j DROP

**SOC Analysis:**  
A single iptables rule is an insufficient standalone defense because it cannot fix root flaws like weak credentials or permissive access policies. A robust SOC must implement defense-in-depth such as deploying multi-factor authentication (MFA), public-key infrastructure (PKI) to eliminate password-based entry, host-based intrusion prevention (HIPS) to throttle brute-force attacks, and SIEM log correlation to catch anomalies before a breach occurs.
---

## Phase 3: Full Spectrum

**Listener Configuration:**
[What tool, what port, what command did you use to set up your listener?]

**Reverse Shell Payload:**
[The exact curl command you crafted to trigger the exploit]

**Command Injection Explanation:**
[2–3 sentences in APA style — how does command injection work and
why is this application susceptible to it?]

**Forensic Evidence:**
- Process ID (PID): [PID from access.log]
- User-Agent: [User-Agent string from access.log]

**Lockdown Command:**
[Exact iptables command applied inside the container]

**Final Analytical Paragraph:**
[4–6 sentences in APA style responding to: You have now played both
sides of this operation. What does executing this attack teach you
about defending against it? What single defensive control, if it had
been in place before you attacked, would have stopped this breach
entirely — and why?]

---

## References
[APA format. Any tools, documentation, or resources referenced
during this operation.
Example: Hydra Project. (2024). THC-Hydra: A fast and flexible
online password cracking tool. https://github.com/vanhauser-thc/thc-hydra]
