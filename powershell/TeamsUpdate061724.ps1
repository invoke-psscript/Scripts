# Define the URL for downloading the latest version of Microsoft Teams Windows App
$teamsDownloadUrl = "https://go.microsoft.com/fwlink/?linkid=2243204&clcid=0x409"

# Define the path to download the installer
$installerPath = "C:\Temp\TeamsBootstrapInstaller.exe"

# Function to check if Microsoft Teams Windows App is installed
function CheckIfTeamsInstalled {
    $teamsInstalled = Get-AppxProvisionedPackage | Where-Object { $_.Name -eq "MSTeams" }
    return [bool]$teamsInstalled
}

# Function to get the installed version of Microsoft Teams Windows App
function GetTeamsInstalledVersion {
    $teamsInstalled = Get-AppxProvisionedPackage | Where-Object { $_.Name -eq "MSTeams" }
    if ($teamsInstalled) {
        return $teamsInstalled.Version
    } else {
        return $null
    }
}

# Retrieve Latest Teams Version from Github Repo

$winget_Teams = Invoke-RestMethod -Uri "https://api.github.com/repos/microsoft/winget-pkgs/contents/manifests/m/Microsoft/Teams"

# Ensure $winget_Teams is an array and has enough items
if ($winget_Teams -is [System.Collections.IEnumerable] -and $winget_Teams.Count -ge 3) {
    $avoid_ClassicFree = ($winget_Teams.Count - 3)
    $teamName = $winget_Teams[$avoid_ClassicFree].Name
    Write-Output $teamName
} else {
    Write-Output "The response does not contain enough items or is not an array."
}

# Function to install or update Microsoft Teams Windows App
function InstallOrUpdateTeams {
    # Check if Microsoft Teams Windows App is already installed
    $installedVersion = GetTeamsInstalledVersion
    if ($installedVersion) {
        Write-Host "Microsoft Teams Windows App Latest version $installedVersion is already installed."
        if ($installedVersion -le $teamName) { # Change this version number to the latest version
            Write-Host "Microsoft Teams Windows App is outdated (Version: $installedVersion). Updating..."
            try {
                # Download the latest version of Microsoft Teams Windows App
                Invoke-WebRequest -Uri $teamsDownloadUrl -OutFile $installerPath

                # Install Microsoft Teams Windows App silently
                Start-Process -FilePath $installerPath -ArgumentList "/silent" -Wait

                # Clean up the installer
                Remove-Item $installerPath

                Write-Host "Microsoft Teams Windows App has been updated successfully."
            } catch {
                Write-Host "Failed to update Microsoft Teams Windows App. Error: $_"
            }
        }
    } else {
        Write-Host "Microsoft Teams Windows App is not installed."
        
    }
}

# Main script logic
InstallOrUpdateTeams
