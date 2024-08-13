logoff ((query user /server:localhost | where {$_ -like "*wsup*"}) -split ' +')[2]
