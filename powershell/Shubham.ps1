$appName = "MSTeams"
$package = Get-AppxPackage | Where-Object { $_.Name -eq $appName }

# Uninstall the app
$packageFullName = $package.PackageFullName

   Get-AppxPackage | Where-Object { $_.PackageFullName -eq $packageFullName } | Remove-AppxPackage 

 
 # Define the URL of the Microsoft Teams MSIX installer
    $installerURL = "https://go.microsoft.com/fwlink/?linkid=2196106&clcid=0x409&culture=en-us&country=us"
 
 # Define the directory where the installer will be downloaded (if not already present)
    $installerPath = "$env:TEMP\MSTeams-x64.msix"

                    # Check if the installer file already exists
                    if (-not (Test-Path $installerPath)) {
                        Write-Output "Downloading Microsoft Teams MSIX installer..."
                        try {
                            Invoke-WebRequest -Uri $installerURL -OutFile $installerPath -ErrorAction Stop
                            Write-Output "Microsoft Teams MSIX installer downloaded successfully."
                        } catch {
                            Write-Error "Failed to download Microsoft Teams MSIX installer: $_"
                            exit 1
                        }
                    } else {
                        Write-Output "Microsoft Teams MSIX installer already exists."
                    }

# Install Microsoft Teams MSIX package
Write-Output "Installing Microsoft Teams MSIX package..."

try {
    Add-AppxPackage -Path $installerPath -Verbose -ForceApplicationShutdown
    Write-Output "Microsoft Teams MSIX package installed successfully."
} catch {
    Write-Error "Failed to install Microsoft Teams MSIX package: $_"
    exit 1
}


# Define the path to the Microsoft Teams executable
$teams = "C:\Program Files\WindowsApps\MSTeams*\ms-teams.exe"  

Start-Process -FilePath $teams

Write-Output "Microsoft Teams is now launching..."
