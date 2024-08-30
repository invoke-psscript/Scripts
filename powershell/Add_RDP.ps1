
If ($args[0] -ne $null){

    $username = $args[0]
    Write-Host $username

}

Else {Write-Host "No args entered"}

Add-LocalGroupMember -Group "Remote Desktop Users" -Member "EVERTZ_MICROSYS\$username"