@echo off
echo ========================================
echo OpenSSL Installer for Windows
echo ========================================
echo.

echo This script will help you install OpenSSL using Chocolatey package manager.
echo.

REM Check if Chocolatey is installed
echo Checking if Chocolatey is installed...
where choco >nul 2>&1
if %errorlevel% neq 0 (
    echo Chocolatey is not installed. Installing Chocolatey first...
    echo.
    echo Installing Chocolatey package manager...
    echo This requires Administrator privileges.
    echo.
    pause
    
    REM Install Chocolatey
    powershell -Command "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"
    
    if %errorlevel% neq 0 (
        echo.
        echo ERROR: Failed to install Chocolatey
        echo Please run this script as Administrator and try again.
        echo.
        pause
        exit /b 1
    )
    
    echo Chocolatey installed successfully!
    echo.
) else (
    echo Chocolatey is already installed.
    echo.
)

echo Installing OpenSSL...
choco install openssl -y

if %errorlevel% neq 0 (
    echo.
    echo ERROR: Failed to install OpenSSL
    echo Please try running: choco install openssl -y
    echo.
    pause
    exit /b 1
)

echo.
echo OpenSSL installed successfully!
echo.
echo Please close and reopen your command prompt/PowerShell to ensure PATH is updated.
echo Then run the generate-certs.bat or generate-certs.ps1 script.
echo.
pause
