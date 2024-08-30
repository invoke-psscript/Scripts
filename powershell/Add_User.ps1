Write-Host "Note: Username must be entered in the form DOMAIN\username in the Command Line section of the script`n----------`n`n"

$username = $args[0]

If ($username.Length -gt 16){

    If ($username -ne $null){

        If ($username -in (Get-LocalGroupMember "Administrators").Name){

            Write-Host "$username is already a member of the local Administrators group"

        }
        
        Else {

            Write-Host "Adding $username to the local Administrators group"
            Add-LocalGroupMember -Group "Administrators" -Member "$username"

        }

    }

    Else {

        Write-Host "No username entered"
        
        }

}

Else { 

    Write-Host "Double-check your username input - Username MUST be entered in the form DOMAIN\username in the Command Line section of the script"

}
