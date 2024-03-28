$sharename = 5288IT_1

$folderpath = "C:\"

$username = Administrators

$permission = "Read"

New-SmbShare -Name $sharename -Path $folderpath -FullAccess $username

$sharename = 5288IT_2

$folderpath = "O:\"

$username = Administrators

$permission = "Read"

New-SmbShare -Name $sharename -Path $folderpath -FullAccess $username