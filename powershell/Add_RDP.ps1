Write-Host "Note: Username must be entered in the form DOMAIN\username in the Command Line section of the script`n----------`n`n"

$username = $args[0]

If ($username.Length -gt 16){

    If ($username -ne $null){

        If ($username -in (Get-LocalGroupMember "Remote Desktop Users").Name){

            Write-Host "$username is already a member of the local Remote Desktop Users group"

        }
        
        Else {

            Write-Host "Adding $username to the local Remote Desktop Users group"
            Add-LocalGroupMember -Group "Remote Desktop Users" -Member "$username"

        }

    }

    Else {

        Write-Host "No username entered"
        
        }

}

Else { 

    Write-Host "Double-check your username input - Username MUST be entered in the form DOMAIN\username in the Command Line section of the script"

}
