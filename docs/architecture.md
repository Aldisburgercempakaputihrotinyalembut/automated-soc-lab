# Lab Architecture

```mermaid
flowchart LR
A["Attacker Host 192.168.56.1"] -->|"Discovery / Encoded PS / Brute force"| B["Windows 11 Target (Wazuh Agent) 192.168.56.101"]
B -->|"Security events"| C["Wazuh Manager (Ubuntu) 192.168.56.10"]
C -->|"Custom rules 100100 / 100200 / 100300"| D{"Alert level >= threshold"}
D -->|"Integration hook (JSON)"| E["n8n Workflow"]
E -->|"External IP"| F["AbuseIPDB Enrichment"]
E -->|"Internal IP"| G["Label internal_lab"]
F --> H["Merge + verdict is_malicious"]
G --> H
H -->|"Formatted message"| I["Telegram Bot -> Analyst Phone"]
```

1. Attacker melakukan discovery, encoded PowerShell, atau brute force ke target Windows.
2. Wazuh agent meneruskan event ke Wazuh manager.
3. Custom rules memicu alert severity tinggi.
4. Alert dikirim lewat integration hook ke webhook n8n.
5. n8n memperkaya IP eksternal via AbuseIPDB dan melabeli IP internal otomatis.
6. Hasil digabung jadi satu verdict dan alert bersih dikirim ke Telegram.
