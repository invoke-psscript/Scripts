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

$Output = Get-Content .\Output.txt -Raw
$compsys = Get-WmiObject win32_computersystem
$mail = "mail." + $compsys.Domain
$Body = $compsys.DnsHostname + "`n`n" + $Output

Send-MailMessage -SmtpServer $mail -To "drush@evertz.com" -From "Reports@5288.IT" -Body $Body -Subject "Installed Programs"
Remove-Item .\Output.txt -Force