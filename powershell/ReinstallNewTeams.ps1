function Check-AppxOutput {

    $message = "Checking output of Get-AppxPackage and Get-AppxProvisionedPackage"
    $message | Out-String

    $AppxPackage = Get-AppxPackage -AllUsers | Where-Object Name -eq "MSTeams"
    $AppxProvisionedPackage = Get-AppxProvisionedPackage -Online | Where-Object DisplayName -eq "MSTeams"

    $message = "Output of Get-AppxPackage is:"
    $message | Out-String

    $message = $AppxPackage
    $message | Out-String

    $message = "Output of Get-AppxProvisionedPackage is:"
    $message | Out-String

    $message = $AppxProvisionedPackage
    $message | Out-String

}





$message = "Checking if C:\Temp exists"
$message | Out-String

If ( !(Test-Path C:\Temp)) {
    $message = "C:\Temp does not exist - Attempting to create the folder"
    $message | Out-String
    New-Item "C:\Temp" -ItemType Directory
}
Else{
    $message = "C:\Temp already exists"
    $message | Out-String
}

$message = "Downloading TeamsBootstrapInstaller.exe"
$message | Out-String

Invoke-WebRequest -Uri "https://go.microsoft.com/fwlink/?linkid=2243204&clcid=0x409" -OutFile "C:\Temp\TeamsBootstrapInstaller.exe"

$TeamsBootstrapInstaller = "C:\Temp\TeamsBootstrapInstaller.exe"

Check-AppxOutput

$message = "Attempting to remove MSTeams with teamsbootstrapinstaller.exe"
$message | Out-String

Start-Process -FilePath $teamsbootstrapinstaller -ArgumentList "-x" -WindowStyle Hidden -Wait

Check-AppxOutput

$message = "Downloading MSTeams-x64.msix"
$message | Out-String

If (Test-Path "C:\Temp\MSTeams-x64.msix"){
    Remove-Item "C:\Temp\MSTeams-x64.msix" -Force
}

Invoke-WebRequest -Uri "https://go.microsoft.com/fwlink/?linkid=2196106&clcid=0x409&culture=en-us&country=us" -OutFile "C:\Temp\MSTeams-x64.msix"

$TeamsMsixInstaller = "C:\Temp\MSTeams-x64.msix"

$message = "Attempting to install MSTeams with MSTeams-x64.msix"
$message | Out-String

Add-AppxProvisionedPackage -PackagePath $TeamsMsixInstaller -Online -SkipLicense | Out-String

Check-AppxOutput
