
If ($args[0] -ne $null){

    $username = $args[0]
    Write-Host $username

}

Else {Write-Host "No username entered"}

Add-LocalGroupMember -Group "Remote Desktop Users" -Member "$username"