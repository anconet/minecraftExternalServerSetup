@echo off
setlocal enabledelayedexpansion

set "DOWNLOAD_DIR=%TEMP%\anconalabs-cloudflared"
set "CLOUDFLARED_EXE=%DOWNLOAD_DIR%\cloudflared.exe"
set "CLOUDFLARED_URL=https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-windows-amd64.exe"

if not exist "%DOWNLOAD_DIR%" mkdir "%DOWNLOAD_DIR%"

echo Downloading cloudflared for Windows...
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$ProgressPreference='SilentlyContinue'; Invoke-WebRequest -Uri '%CLOUDFLARED_URL%' -OutFile '%CLOUDFLARED_EXE%'"

if errorlevel 1 (
  echo Failed to download cloudflared.
  pause
  exit /b 1
)

echo Starting the local tunnel...
"%CLOUDFLARED_EXE%" access tcp --hostname mc.anconalabs.com --url localhost:25565

pause