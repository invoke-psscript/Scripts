New-LocalUser -Name user2024 -NoPassword

Add-LocalGroupMember -Group "Administrators" -Member "user2024"