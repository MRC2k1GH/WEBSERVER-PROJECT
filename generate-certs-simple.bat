@echo off
echo ========================================
echo SSL Certificate Generator for Elasticsearch
echo ========================================
echo.

REM Create directory for certificates
if not exist "elasticsearch-certs" (
    echo Creating elasticsearch-certs directory...
    mkdir elasticsearch-certs
    echo Directory created successfully.
    echo.
)

REM Set OpenSSL path directly
set "OPENSSL_PATH=C:\Program Files\OpenSSL-Win64\bin\openssl.exe"

REM Check if OpenSSL exists at the specified path
if not exist "%OPENSSL_PATH%" (
    echo ERROR: OpenSSL not found at %OPENSSL_PATH%
    echo.
    echo Please check if OpenSSL is installed at this location.
    echo If not, please install OpenSSL from: https://slproweb.com/products/Win32OpenSSL.html
    echo.
    pause
    exit /b 1
)

echo OpenSSL found at: %OPENSSL_PATH%
echo.

echo Starting certificate generation...
echo.

echo Step 1: Generating CA certificate...
"%OPENSSL_PATH%" req -x509 -sha256 -nodes -days 3650 -newkey rsa:2048 -keyout "elasticsearch-certs\ca.key" -out "elasticsearch-certs\ca.crt" -subj "/C=US/ST=State/L=City/O=Organization/CN=elasticsearch-ca"
if %errorlevel% neq 0 (
    echo.
    echo ERROR: Failed to generate CA certificate
    echo Please check the error message above and try again.
    echo.
    pause
    exit /b 1
)
echo CA certificate generated successfully.
echo.

echo Step 2: Generating Elasticsearch certificate request...
"%OPENSSL_PATH%" req -new -newkey rsa:2048 -keyout "elasticsearch-certs\elasticsearch.key" -out "elasticsearch-certs\elasticsearch.csr" -subj "/C=US/ST=State/L=City/O=Organization/CN=elasticsearch"
if %errorlevel% neq 0 (
    echo.
    echo ERROR: Failed to generate Elasticsearch certificate request
    echo Please check the error message above and try again.
    echo.
    pause
    exit /b 1
)
echo Elasticsearch certificate request generated successfully.
echo.

echo Step 3: Signing the certificate with CA...
"%OPENSSL_PATH%" x509 -req -in "elasticsearch-certs\elasticsearch.csr" -CA "elasticsearch-certs\ca.crt" -CAkey "elasticsearch-certs\ca.key" -CAcreateserial -out "elasticsearch-certs\elasticsearch.crt" -days 3650
if %errorlevel% neq 0 (
    echo.
    echo ERROR: Failed to sign certificate
    echo Please check the error message above and try again.
    echo.
    pause
    exit /b 1
)
echo Certificate signed successfully.
echo.

echo Step 4: Converting to PKCS12 format for Elasticsearch...
"%OPENSSL_PATH%" pkcs12 -export -out "elasticsearch-certs\elastic-certificates.p12" -inkey "elasticsearch-certs\elasticsearch.key" -in "elasticsearch-certs\elasticsearch.crt" -certfile "elasticsearch-certs\ca.crt" -passout pass:elastic
if %errorlevel% neq 0 (
    echo.
    echo ERROR: Failed to convert to PKCS12 format
    echo Please check the error message above and try again.
    echo.
    pause
    exit /b 1
)
echo PKCS12 conversion completed successfully.
echo.

echo ========================================
echo SUCCESS: SSL certificates generated!
echo ========================================
echo.
echo Files created in elasticsearch-certs\ directory:
echo.
dir elasticsearch-certs
echo.
echo Next steps:
echo 1. Start Elasticsearch cluster: docker-compose up -d elasticsearch elasticsearch2 elasticsearch3
echo 2. Wait for cluster health, then start other services: docker-compose up -d
echo 3. Access your secured cluster at https://localhost:9200 (admin/pass)
echo.
echo Press any key to exit...
pause >nul
