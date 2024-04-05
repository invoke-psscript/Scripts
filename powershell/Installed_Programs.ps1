function Analyze($p, $f) {
Get-ItemProperty $p |foreach {
if (($_.DisplayName) -or ($_.version)) {
[PSCustomObject]@{
From = $f;
Name = $_.DisplayName;
Version = $_.DisplayVersion;
Install = $_.InstallDate
}
}
}
}
$s = @()
$s += Analyze 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*' 64
$s += Analyze 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*' 32
$s | Sort-Object -Property Name > .\Output.txt

$attachments = @()
$attachments += .\Output.txt
$compsys = Get-WmiObject win32_computersystem
$mail = "mail." + $compsys.Domain


Send-MailMessage -SmtpServer $mail -To "drush@evertz.com" -From "Reports@5288.IT" -Body $compsys.DnsHostname -Subject "Installed Programs" -attachments $attachments
Remove-Item .\Output.txt -Force