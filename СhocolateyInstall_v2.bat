@echo off
cls

:: Check for administrator privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [91mThis script requires administrator privileges. Please run the command prompt as an administrator.[0m
    timeout /nobreak /t 3 >nul
    exit /b 1
)

:: Install Chocolatey
echo [92mInstalling Chocolatey...[0m
timeout /nobreak /t 3 >nul
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

:: Check the success of Chocolatey installation
choco --version >nul 2>&1
if %errorLevel% neq 0 (
    echo [92mChocolatey installation failed. Please check the error messages above.[0m
    timeout /nobreak /t 3 >nul
    exit /b 1
)

:: Install MinGW
echo [92mInstalling MinGW...[0m
timeout /nobreak /t 3 >nul
choco install mingw -y


:: Add MinGW to PATH
echo [92mAdding MinGW to PATH...[0m
timeout /nobreak /t 3 >nul
setx PATH "%PATH%;C:\ProgramData\chocolatey\lib\mingw\tools\install\mingw64\bin" /M

:: Display success message
echo.
echo [92mChocolatey and MinGW installation completed successfully.[0m
timeout /nobreak /t 3 >nul
pause
exit /b 0
