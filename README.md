# Automated SOC Home Lab

A home Security Operations Center (SOC) that detects attacks and delivers enriched, human-readable alerts to an analyst's phone in seconds — no manual dashboard polling required.

## The Business Problem
Understaffed and small security teams face three costly gaps:
1. Slow triage / alert fatigue — analysts manually read raw alerts, copy IPs into threat-intel sites, and interpret results. This enrichment step alone costs several minutes per alert.
2. Missed detections — default rule sets miss discovery commands, encoded PowerShell, and brute-force patterns.
3. Delayed response — if no one watches the dashboard, a critical alert can sit unseen for hours.

This lab solves all three with automated detection + SOAR (Security Orchestration, Automation & Response).

## The Solution
End-to-end pipeline: Attack -> Wazuh detection (custom rules) -> n8n workflow -> AbuseIPDB enrichment -> Telegram alert on phone.
- Custom detection rules catch what defaults miss (discovery, encoded PowerShell, brute force), mapped to MITRE ATT&CK.
- Automated enrichment checks every external source IP against AbuseIPDB and auto-labels internal IPs.
- Instant alerting pushes a clean alert to Telegram — enrichment is done before the analyst opens the laptop.

## Key Results
| Metric | Manual (before) | Automated (after) |
|---|---|---|
| Analyst labor per alert (enrichment) | ~3-4 min | ~0 (hands-off) |
| Alert-to-notification latency | minutes-hours | ~seconds |
| Detection coverage | default rules only | + custom rules (discovery, encoded PS, brute force) |

Note: before/after figures are analytical estimates under lab conditions, documented with explicit assumptions. They are indicative, not stopwatch-measured production numbers.

## Architecture
See docs/architecture.md for the full data-flow diagram.

## Tech Stack
- SIEM/XDR: Wazuh 4.14
- SOAR / automation: n8n (Docker)
- Threat intelligence: AbuseIPDB API
- Alerting: Telegram Bot API
- Lab: VirtualBox — Windows 11 target, Ubuntu (Wazuh manager), attacker host
- Attack simulation: Atomic Red Team, Hydra / Ncrack

## Custom Detection Rules
| Rule ID | Detects | Level | MITRE |
|---|---|---|---|
| 100100 | Windows discovery commands (whoami, net, ipconfig) | 12 | Discovery (T1059) |
| 100200 | Encoded PowerShell (non-WMI) | 12 | T1059.001 |
| 100300 | Authentication brute force | 12 | T1110 |

## Repository Structure
- detection/ — custom Wazuh rules and the Wazuh-to-n8n integration block
- automation/ — exported n8n SOAR workflow
- scripts/ — helper scripts (benign noise generator for testing)
- docs/ — architecture diagram
- screenshots/ — dashboard, workflow, and alert screenshots
- incident-reports/ — sample incident-response write-ups

## How It Works (Reproduce)
1. Deploy the Wazuh manager (Ubuntu) and enroll the Windows 11 agent.
2. Add the custom rules from detection/local_rules.xml.
3. Configure the Wazuh-to-n8n integration (detection/ossec-integration.conf).
4. Import automation/soc-alert-workflow.json into n8n.
5. Add AbuseIPDB + Telegram credentials in n8n's credential store (never in code).
6. Simulate an attack and watch the enriched alert arrive on Telegram.

## Skills Demonstrated
- Detection engineering (custom Wazuh rules + MITRE ATT&CK mapping)
- SOAR workflow automation (n8n)
- Threat-intelligence integration & enrichment
- Incident-response documentation

## Security Note
No secrets are committed to this repository. API keys and bot tokens live only in n8n credentials / environment variables.

## Screenshots

### Wazuh SIEM Dashboard
![Wazuh Dashboard](screenshots/Screenshot%202026-07-20%20095018.png)

### n8n SOAR Workflow
![n8n Workflow](screenshots/Screenshot%202026-07-20%20094940.png)

### Telegram Alert Notification
![Telegram Alert](screenshots/Screenshot%202026-07-20%20094536.png)
