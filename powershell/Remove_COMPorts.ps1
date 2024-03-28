# Variables

$filepath = "C:\5288_IT$\Logs"

$hostname = hostname

$domain = (Get-DnsClientGlobalSetting).SuffixSearchList[0]

$attachments = @()


# Remove COM ports
try {
  $log = $filepath + "COMportsStart.txt"
  Get-PnpDevice >> $log
  $attachments += $log
  Get-PnpDevice | Where { $_.Class -eq "Ports" -and $_.Status -eq "Unknown" } | ForEach {pnputil /remove-device $_.DeviceId}
  $log = $filepath + "COMportsEnd.txt"
  Get-PnpDevice >> $log
  $attachments += $log
}
catch{
  $ErrorOutput = $_.Exception.Message
  "#task error`n-----`n`n" + $ErrorOutput | Out-File -FilePath $filepath\errors.txt -Append
}


# Send email report
try{
    Send-MailMessage -SmtpServer mail.$domain -From Reports@5288.IT -To drush@evertz.com -Subject "COM Ports" -Attachments $attachments -Body $hostname
}
catch{
    try{
        Send-MailMessage -SmtpServer mxa-008b7801.gslb.pphosted.com -From Reports@5288.IT -To drush@evertz.com -Subject "Network Connection" -Attachments $attachments -Body $hostname
    }
    catch{
        Send-MailMessage -SmtpServer mxb-008b7801.gslb.pphosted.com -From Reports@5288.IT -To drush@evertz.com -Subject "Network Connection" -Attachments $attachments -Body $hostname
    }
}