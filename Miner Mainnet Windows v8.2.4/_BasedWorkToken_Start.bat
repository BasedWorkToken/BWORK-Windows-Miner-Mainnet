@echo off

echo "I am sleeping for 3 seconds before launch."
timeout /t 3 /nobreak >nul

:startProgram
:: Redirect output to screen and a file using a for loop
BasedWorkToken.exe 

:: Check the actual program exit code
if %errorlevel% EQU 22 (
    echo Exit code 22 detected - restarting...
    timeout /t 5
    goto startProgram
)

pause
