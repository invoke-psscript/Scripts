Write-Host "Note: Username must be entered in the form DOMAIN\username in the Command Line section of the script"

If ($args[0] -ne $null){

    $username = $args[0]

    If ($username -in (Get-LocalGroupMember "Remote Desktop Users").Name){

        Write-Host "$username is already a member of the local Remote Desktop Users group"

    }
    
    Else {

        Write-Host "Adding $username to the local Remote Desktop Users group"
        Add-LocalGroupMember -Group "Remote Desktop Users" -Member "$username"

    }

}

Else {Write-Host "No username entered"}