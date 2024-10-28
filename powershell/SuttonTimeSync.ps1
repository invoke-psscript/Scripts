Write-Host "Note: Ensure you have entered the correct ntp server in the Command Line section of the script`n----------`n`n"

"Getting current time:"
Write-Host (Get-Date)
""
"Applying DynamicDaylightTimeDisabled setting. Output is before/after:"
""
Write-Host (Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\TimeZoneInformation" -Name "DynamicDaylightTimeDisabled")
""
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\TimeZoneInformation" -Name "DynamicDaylightTimeDisabled" -Value 0

Write-Host (Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\TimeZoneInformation" -Name "DynamicDaylightTimeDisabled")
""
"----------"

$ntp = $args[0]

""
"The ntp server entered is $ntp"
""

If ($ntp.Length -eq 12){

    $w32time = Get-Service -Name W32Time
    Write-Host "w32time Status=$($w32time.Status), StartType=$($w32time.StartType)"
    if (!($w32time.Status -eq "Running") -or !($w32time.StartType -eq "Automatic")) {
        Write-Host "Running and setting automatic startup for w32time..."
        Set-Service -Name W32Time -Status Running -StartupType Automatic
        $w32time = Get-Service -Name W32Time
        Write-Host "w32time Status=$($w32time.Status), StartType=$($w32time.StartType)"
    }
    ""

    net stop w32time

    w32tm /config /syncfromflags:manual /manualpeerlist:$ntp

    net start w32time

    w32tm /config /update

    w32tm /resync /rediscover
    
}

Else {

    Write-Host "Verify your ntp server input"

}

"Getting current time after script execution:"
Write-Host(Get-Date)