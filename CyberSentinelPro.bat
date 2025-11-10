@echo off
setlocal EnableExtensions EnableDelayedExpansion
title CyberSentinel Pro - Windows Security Audit & Threat Scanner (By Umar Ahamed)
color 0A

REM ======== SAFER POWERSHELL SHORTHAND =========
set "PS=powershell.exe -NoProfile -ExecutionPolicy Bypass"

REM ======== ADMIN CHECK =========
>nul 2>&1 net session || (
  color 0C
  echo ===========================================================
  echo   WARNING: This tool must be run as Administrator!
  echo   Please right-click and select "Run as administrator".
  echo ===========================================================
  pause
  exit /b
)

REM ======== LOG SETUP =========
set "LOG=%~dp0CyberSentinelLog.txt"
if not exist "%LOG%" type nul > "%LOG%"
>>"%LOG%" echo === CyberSentinel Pro started: %date% %time% ===
>>"%LOG%" echo.

REM ======== MENU LOOP =========
:MENU
cls
color 0A
echo ==============================================================
echo              CyberSentinel Pro - Security Audit Tool
echo                     Developed by Umar Ahamed
echo ==============================================================
echo [1] Quick System Security Audit
echo [2] Check Windows Firewall and Defender
echo [3] Scan for Suspicious Processes
echo [4] Analyze Active Network Connections
echo [5] Port Scan (Top 20 Common Ports)
echo [6] List Admin Users and Privileges
echo [7] Detect Failed Login Attempts (Event Log)
echo [8] System Integrity and Update Check
echo [9] Export Security Report
echo [0] Exit
echo ==============================================================
set "CH="
set /p CH=Enter your choice (0-9): 

if "%CH%"=="1"  goto AUDIT
if "%CH%"=="2"  goto FIREWALL_DEFENDER
if "%CH%"=="3"  goto SUSPICIOUS
if "%CH%"=="4"  goto NETSCAN
if "%CH%"=="5"  goto PORTSCAN
if "%CH%"=="6"  goto ADMINS
if "%CH%"=="7"  goto LOGINFAIL
if "%CH%"=="8"  goto INTEGRITY
if "%CH%"=="9"  goto EXPORT
if "%CH%"=="0"  goto END
goto MENU

REM ======== HELPERS =========
:Log
REM usage: call :Log message...
echo [%date% %time%] %*>>"%LOG%"
goto :eof

:PauseReturn
echo.
echo Press Enter to return to menu...
pause >nul
goto MENU

REM ======== 1. SYSTEM AUDIT =========
:AUDIT
cls
call :Log Running system security audit...
echo Running system security audit...
systeminfo | findstr /i "OS Name OS Version System Manufacturer System Model" >>"%LOG%" 2>&1
net accounts >>"%LOG%" 2>&1
net localgroup administrators >>"%LOG%" 2>&1
call :Log System audit completed.
echo System audit completed.
goto PauseReturn

REM ======== 2. FIREWALL & DEFENDER =========
:FIREWALL_DEFENDER
cls
call :Log Checking Windows Firewall and Defender...
echo Checking Windows Firewall and Defender...
netsh advfirewall show allprofiles | findstr /ri "State" >>"%LOG%" 2>&1
sc query windefend | findstr /ri "STATE" >>"%LOG%" 2>&1
%PS% -Command "Try{Get-MpComputerStatus | Select AMServiceEnabled,AntivirusEnabled,RealTimeProtectionEnabled | Out-String}|Catch{ 'Windows Defender status unavailable' }" >>"%LOG%" 2>&1
call :Log Firewall and Defender check complete.
echo Firewall and Defender check completed.
goto PauseReturn

REM ======== 3. SUSPICIOUS PROCESSES =========
:SUSPICIOUS
cls
call :Log Scanning for suspicious processes...
echo Scanning for suspicious processes...
tasklist /v | findstr /i "powershell.exe cmd.exe wscript.exe cscript.exe rundll32.exe regsvr32.exe" >>"%LOG%" 2>&1
netstat -ano | findstr /i "ESTABLISHED" >>"%LOG%" 2>&1
call :Log Process scan complete.
echo Suspicious process scan completed.
goto PauseReturn

REM ======== 4. NETWORK CONNECTIONS =========
:NETSCAN
cls
call :Log Analyzing active network connections...
echo Analyzing active network connections...
netstat -ano | findstr /i "ESTABLISHED" >>"%LOG%" 2>&1
call :Log Network analysis complete.
echo Network analysis complete.
goto PauseReturn

REM ======== 5. PORT SCAN (SAFE, FAST, NO TEST-NETCONNECTION) =========
:PORTSCAN
cls
set "TARGET="
set /p TARGET=Enter target IP or hostname: 
if not defined TARGET (
  echo No target entered. Returning to menu...
  timeout /t 2 >nul
  goto MENU
)
call :Log Starting port scan on %TARGET%...
echo Scanning ports on %TARGET%...
REM Use raw .NET TcpClient for reliability/speed
for %%P in (21 22 23 25 53 80 110 135 139 143 443 445 3306 3389 8080 8443 161 389 1433) do (
  %PS% -Command "Try{ $c=New-Object Net.Sockets.TcpClient; $ar=$c.BeginConnect('%TARGET%',%%P,$null,$null); $ok=$ar.AsyncWaitHandle.WaitOne(800); if($ok -and $c.Connected){$c.EndConnect($ar); 'Port %%P OPEN'} else {'Port %%P CLOSED'}; $c.Close() } Catch { 'Port %%P CLOSED' }" >>"%LOG%" 2>&1
)
call :Log Port scan finished.
echo Port scan complete.
goto PauseReturn

REM ======== 6. ADMIN USERS =========
:ADMINS
cls
call :Log Listing admin users...
echo Listing admin users...
net localgroup administrators >>"%LOG%" 2>&1
call :Log Admin user listing complete.
echo Admin user listing complete.
goto PauseReturn

REM ======== 7. FAILED LOGIN ATTEMPTS =========
:LOGINFAIL
cls
call :Log Checking failed login attempts...
echo Checking failed login attempts...
wevtutil qe Security /q:"*[System[EventID=4625]]" /c:10 /f:text >>"%LOG%" 2>&1
call :Log Failed login attempt log extracted.
echo Failed login attempts logged.
goto PauseReturn

REM ======== 8. INTEGRITY & UPDATE CHECK =========
:INTEGRITY
cls
call :Log Running system integrity and update check...
echo Running integrity and update check (this can take several minutes)...
sfc /scannow >>"%LOG%" 2>&1
%PS% -Command "Get-HotFix | Select Description,InstalledOn | Sort-Object InstalledOn -Descending | Out-String" >>"%LOG%" 2>&1
call :Log Integrity and update scan complete.
echo Integrity and update scan completed.
goto PauseReturn

REM ======== 9. EXPORT =========
:EXPORT
cls
call :Log Export requested.
echo Security report saved at: %LOG%
goto PauseReturn

REM ======== EXIT =========
:END
cls
color 0A
echo ===========================================================
echo CyberSentinel Pro closed successfully.
echo Log saved at: %LOG%
echo ===========================================================
timeout /t 2 >nul
exit /b 0
