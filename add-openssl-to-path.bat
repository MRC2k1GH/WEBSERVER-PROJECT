@echo off
echo ========================================
echo Adding OpenSSL to System PATH
echo ========================================
echo.

REM Check if running as Administrator
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: This script must be run as Administrator
    echo.
    echo Right-click on this file and select "Run as Administrator"
    echo.
    pause
    exit /b 1
)

echo Running as Administrator - proceeding...
echo.

REM Set OpenSSL path
set "OPENSSL_PATH=C:\Program Files\OpenSSL-Win64\bin"

REM Check if OpenSSL exists
if not exist "%OPENSSL_PATH%\openssl.exe" (
    echo ERROR: OpenSSL not found at %OPENSSL_PATH%
    echo.
    echo Please install OpenSSL first, then run this script.
    echo.
    pause
    exit /b 1
)

echo OpenSSL found at: %OPENSSL_PATH%
echo.

REM Check if already in PATH
echo %PATH% | find /i "%OPENSSL_PATH%" >nul
if %errorlevel% equ 0 (
    echo OpenSSL is already in your PATH.
    echo.
    echo Current PATH contains: %OPENSSL_PATH%
    echo.
    pause
    exit /b 0
)

echo Adding OpenSSL to system PATH...
echo.

REM Add to system PATH
setx PATH "%PATH%;%OPENSSL_PATH%" /M

if %errorlevel% neq 0 (
    echo.
    echo ERROR: Failed to add OpenSSL to PATH
    echo Please try running this script as Administrator again.
    echo.
    pause
    exit /b 1
)

echo.
echo SUCCESS: OpenSSL has been added to your system PATH!
echo.
echo IMPORTANT: You need to close and reopen your command prompt/PowerShell
echo for the PATH changes to take effect.
echo.
echo After reopening, you can test with: openssl version
echo.
echo Press any key to exit...
pause >nul
