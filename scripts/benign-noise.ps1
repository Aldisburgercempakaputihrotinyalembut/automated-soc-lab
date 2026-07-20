# === Benign Noise Generator (SOC-008b) - baseline aktivitas normal ===
$dir = "C:\LabBenign"
$log = Join-Path $dir "benign.log"
if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir | Out-Null }
function Write-Log($msg) { "$(Get-Date -Format o)  $msg" | Out-File -FilePath $log -Append -Encoding utf8 }

Write-Log "=== siklus benign mulai ==="

# 1) PowerShell benign -> proses baru (Sysmon Event ID 1)
Get-Process   | Select-Object -First 5 | Out-Null
Get-Service   | Select-Object -First 5 | Out-Null
Get-ChildItem C:\Windows\System32 | Select-Object -First 5 | Out-Null
Write-Log "cmdlet benign dijalankan (Get-Process/Service/ChildItem)"

# 2) Operasi file benign -> Sysmon Event ID 11
$tmp = Join-Path $dir ("kerja_" + [guid]::NewGuid().ToString() + ".txt")
"catatan kerja rutin $(Get-Date)" | Out-File -FilePath $tmp -Encoding utf8
Get-Content $tmp | Out-Null
Remove-Item $tmp -Force
Write-Log "operasi file benign (buat/baca/hapus) selesai"

# 3) Traffic jaringan benign lokal -> koneksi ke SIEM
Test-NetConnection -ComputerName 192.168.56.10 -Port 443 -InformationLevel Quiet | Out-Null
Write-Log "cek koneksi jaringan benign ke 192.168.56.10:443"

Write-Log "=== siklus benign selesai ==="
