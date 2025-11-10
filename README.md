# 🛡️ CyberSentinel Pro
A professional, menu-based **Windows Security Audit & Threat Scanner** built in Batch (BAT).  
Designed for IT professionals, system administrators, and cybersecurity students to **analyze Windows security**, **detect threats**, and **generate clean, automated security reports** — all through a simple command-line interface.

---

## 🧐 What Is This?
**CyberSentinel Pro** is an all-in-one Windows auditing and diagnostic tool that helps you:

- Audit your system’s security configuration  
- Check Windows Firewall and Defender status  
- Detect suspicious or potentially malicious processes  
- Analyze live network connections  
- Scan for open TCP ports  
- View failed login attempts  
- Verify system integrity and update status  

It’s completely offline, lightweight, and logs everything automatically.

---

## 🔧 What Can It Do?

| Option | Description |
|:------:|:-------------|
| 1 | **Quick System Security Audit** – OS, drive info, account policy, and admin users |
| 2 | **Check Firewall & Defender Status** – Verify if protection is active |
| 3 | **Suspicious Process Scan** – Detects potentially malicious or active scripts |
| 4 | **Network Connection Analysis** – Shows all active TCP sessions |
| 5 | **Port Scan** – Scans the top 20 common TCP ports on a selected host |
| 6 | **List Admin Accounts** – Displays all local administrator users |
| 7 | **Failed Login Audit** – Extracts Event Log entries for failed logins |
| 8 | **System Integrity & Update Check** – Runs `sfc /scannow` and lists installed updates |
| 9 | **Export Report** – Saves results to `CyberSentinelLog.txt` |
| 0 | Exit the tool safely |

---

## ⚙️ How It Works
CyberSentinel Pro runs using built-in Windows commands and PowerShell — no installations or external tools required.

✅ Uses `systeminfo`, `net`, and `wevtutil` for auditing  
✅ Reads Windows Defender status using `Get-MpComputerStatus`  
✅ Performs lightweight TCP scans via PowerShell’s `.NET TcpClient`  
✅ Runs integrity checks using `sfc` and `Get-HotFix`  
✅ Automatically logs every action to a timestamped file  

All output is appended to `CyberSentinelLog.txt` in the same folder for later review.

---

## 🖥️ Requirements
- Windows 10 or Windows 11  
- Must be run as **Administrator**  
- PowerShell 5.1 or higher (included by default)  
- No internet connection required (except for optional port scans against remote hosts)

---

## ▶️ How to Use 
1. Right-click `CyberSentinelPro.bat` → **Run as Administrator**.  
2. Select the menu option you want and let it run.  
3. Review results in the generated `CyberSentinelLog.txt`.

---

## 🛡️ Why Use CyberSentinel Pro?

- Quickly assess **system security health**  
- Identify **open ports**, **admin users**, and **failed login attempts**  
- Detect **malicious processes** in seconds  
- Great for **students**, **analysts**, or **IT admins** doing quick security checks  
- Generates a single, structured report file for easy review  
- Runs 100% offline, safe, and open-source

---

🧑‍💻 Made By Umar Ahamed Cybersecurity Student • Sri Lanka

Passionate about security automation, ethical hacking, and student empowerment

⭐ Connect via GitHub: https://github.com/User-Umar-Ahamed

