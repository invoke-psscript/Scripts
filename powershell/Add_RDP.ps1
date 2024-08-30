Write-Host $args[0]

If ($args[0] -ne $null){

    $username = $args[0]
    Write-Host "Adding $username to the local Remote Desktop Users group"
    Add-LocalGroupMember -Group "Remote Desktop Users" -Member "$username"

}

Else {Write-Host "No username entered"}

