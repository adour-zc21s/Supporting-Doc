@echo off
setlocal

:: Define source and destination paths
set "SOURCE_DIR=F:\Newfolder"
set "DEST_DIR=D:\Backup"
set "LOG_FILE=%DEST_DIR%\logs\backup_log_%DATE:~-4,4%%DATE:~-7,2%%DATE:~-10,2%_%TIME:~0,2%%TIME:~3,2%%TIME:~6,2%.log"

:: Create destination directory if it doesn't exist
if not exist "%DEST_DIR%" (
    mkdir "%DEST_DIR%"
    echo %DATE% %TIME% - Created backup directory: "%DEST_DIR%" >> "%LOG_FILE%"
)

:: Start backup process
echo %DATE% %TIME% - Starting backup from "%SOURCE_DIR%" to "%DEST_DIR%" >> "%LOG_FILE%"

:: Use xcopy for backup (or robocopy for more advanced options)
xcopy "%SOURCE_DIR%" "%DEST_DIR%" /s /e /h /y /d >> "%LOG_FILE%" 2>&1

:: Check for errors and log completion
if %errorlevel% neq 0 (
    echo %DATE% %TIME% - Backup completed with errors! Errorlevel: %errorlevel% >> "%LOG_FILE%"
) else (
    echo %DATE% %TIME% - Backup completed successfully. >> "%LOG_FILE%"
)

echo. >> "%LOG_FILE%"
endlocal