$netshinfo = netsh wlan sh d

$hostname = hostname

$netshinfo > C:\output.txt

$netsh = netsh wlan sh int

$netsh >> C:\output.txt

Send-MailMessage -SmtpServer mail -To 5292_IT@evertz.com -From Reports@5288.IT -Attachments C:\output.txt -Subject WifiCardCheck -Body $hostname