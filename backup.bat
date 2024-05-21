@echo off
setlocal

REM Change directory to the RetroArch saves folder
cd /d C:\RetroArch-Win64\saves

REM Copy the memory card files from PCSX2
xcopy /e /i /y C:\Users\J\Downloads\pcsx2-v1.7.5474-windows-x64-Qt\memcards C:\RetroArch-Win64\saves\memcards

REM Check if there are any changes in the git repository
git status --porcelain >nul 2>&1
if errorlevel 1 (
    echo "No changes detected"
    exit /b 0
)

echo "Changes detected"

REM Add all changes to git
git add -A

REM Get the current date and time
for /f "tokens=1,2 delims= " %%a in ('date /t') do set currentdate=%%a
for /f "tokens=1 delims= " %%a in ('time /t') do set currenttime=%%a

REM Format the timestamp
set datetime=%currentdate:~6,4%-%currentdate:~3,2%-%currentdate:~0,2% %currenttime%

REM Commit the changes with a timestamp
git commit -m "Update [%datetime% EET]"

REM Push the changes to the remote repository
git push

endlocal
