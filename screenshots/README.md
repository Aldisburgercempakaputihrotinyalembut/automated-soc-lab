## 📸 Screenshots

### Wazuh SIEM Dashboard
Alert real-time terklasifikasi per severity (Critical/High/Medium/Low).

![Wazuh Dashboard](screenshots/Screenshot%202026-07-20%20095018.png)

### n8n SOAR Workflow
Pipeline otomatis: Wazuh webhook → parsing → cek IP privat → enrichment AbuseIPDB → notifikasi Telegram.

![n8n Workflow](screenshots/Screenshot%202026-07-20%20094940.png)

### Telegram Alert Notification
Alert terkirim ke analis, lengkap dengan hasil enrichment (internal vs AbuseIPDB).

![Telegram Alert](screenshots/Screenshot%202026-07-20%20094536.png)
