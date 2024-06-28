If ( !(Test-Path C:\Temp)) {
    $message = "C:\Temp does not exist - Attempting to create the folder"
    $message | Out-String
    New-Item "C:\Temp" -ItemType Directory
}
Else{
    $message = "C:\Temp already exists"
    $message | Out-String
}

Invoke-WebRequest -Uri "https://go.microsoft.com/fwlink/?linkid=2243204&clcid=0x409" -OutFile "C:\Temp\TeamsBootstrapInstaller.exe"

Start-Process -FilePath "C:\Temp\TeamsBootstrapInstaller.exe" -ArgumentList "-u" -PassThru -Wait
