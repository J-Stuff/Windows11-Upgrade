#Requires -RunAsAdministrator
$ErrorActionPreference = 'Stop'
<# ... 
    .SYNOPSIS
    Powershell script to Upgrade the Specificed PC to Windows 11 25H2

    .DESCRIPTION
    Uses the PSWindowsUpdate module to set the target feature version to Windows 11 25H2
    Then, scans and runs all pending OS, Driver and Definition file updates.

    .EXAMPLE
    powershell.exe -ex Bypass -file .\Windows11-Upgrade.ps1
#>


# Start Logging
Start-Transcript -Path "C:\Windows\Temp\Windows11-Upgrade.log" -Append

# Enable TLS 1.2 (required by Install-Module command)
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Write-Host "TLS 1.2 Enabled" -ForegroundColor Gray

# Install module from Powershell Gallery
Write-Host "Installing PSWindowsUpdate from Powershell Gallery..." -ForegroundColor Gray
Install-Module -Name PSWindowsUpdate
Write-Host "Done"-ForegroundColor Green

Write-Host "Importing PSWindowsUpdate module..." -ForegroundColor Gray
Import-Module -Name PSWindowsUpdate
Write-Host "Done" -ForegroundColor Green


# Set target version for updates
Set-WUSettings -TargetReleaseVersion -TargetReleaseVersionInfo 25H2 -ProductVersion "Windows 11"
Write-Host "Target Release Version set to Windows 11 25H2" -ForegroundColor Green

# Get & Install required updates
Write-Host "Checking for updates & installing..." -ForegroundColor Gray
Write-Host "Your PC may reboot during this process!" -ForegroundColor Yellow
Install-WindowsUpdate -AcceptAll -Verbose -AutoReboot -ForceInstall


# Clean up post-execution
Stop-Transcript
