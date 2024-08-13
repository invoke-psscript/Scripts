$attachments = @()

$netsh_devices = netsh wlan sh d

$hostname = hostname

$netsh_devices > C:\output.txt

$netsh_int = netsh wlan sh int

$netsh_int >> C:\output.txt

$netsh_all = netsh wlan sh all

$netsh_all >> C:\output.txt

$attachments += "C:\output.txt"

netsh wlan sh wlanreport duration="2"

$attachments += "C:\ProgramData\Microsoft\Windows\WlanReport\wlan-report-latest.html"

Send-MailMessage -SmtpServer mail -To drush@evertz.com -From Reports@5288.IT -Attachments $attachments -Subject WifiCardReport -Body $hostname