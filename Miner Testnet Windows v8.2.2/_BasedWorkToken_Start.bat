@echo off

echo "I am sleeping for 3 seconds before launch."

timeout /t 3 /nobreak >nul

@echo off
pushd %~dp0

for %%X in (dotnet.exe) do (set FOUND=%%~$PATH:X)
if defined FOUND (goto dotNetFound) else (goto dotNetNotFound)

:dotNetNotFound

@echo off
setlocal EnableDelayedExpansion

:: Check if running as administrator
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    powershell Start-Process -Verb RunAs '%0' 2>nul
    exit /b
)

:: Set download URL for .NET 6.0 Runtime
set "DOTNET_DOWNLOAD_URL=https://github.com/BasedWorkToken/Based-Work-Token-Soldiity-Code/raw/refs/heads/main/miner%20dependicies/dotnet-runtime-6.0.0-win-x64.exe"

:: Temporary download path
set "DOWNLOAD_PATH=%TEMP%\dotnet-runtime-6.0-installer.exe"

:: Download .NET 6.0 Runtime
echo Downloading .NET 6.0 Runtime...
powershell -Command "(New-Object Net.WebClient).DownloadFile('%DOTNET_DOWNLOAD_URL%', '%DOWNLOAD_PATH%')"

if exist "%DOWNLOAD_PATH%" (
    echo Download complete. Installing .NET 6.0 Runtime...
    
    :: Silent install with no restart
    start /wait "" "%DOWNLOAD_PATH%" /quiet /norestart
    
    if %errorlevel% equ 0 (
        echo .NET 6.0 Runtime installed successfully.
    ) else (
        echo Installation failed. Error code: %errorlevel%
        echo .NET Core is not found or not installed,
        echo download and install from https://www.microsoft.com/net/download/windows/run
        goto end
    )
    
    :: Clean up installer
    del "%DOWNLOAD_PATH%"
) else (
    echo Download failed. Please check your internet connection.
    echo .NET Core is not found or not installed,
    echo download and install from https://www.microsoft.com/net/download/windows/run
    goto end
)

    

:dotNetFound
:startMiner
BasedWorkToken.exe

if %errorlevel% EQU 22 (
  goto startMiner
)
pause

:end
echo Run script again if u just installed things
pause
echo Run script again if u just installed things
pause