$message = Remove-Item -Path "O:\ProfilesFolder\Users\ajose" -Recurse -Force

Send-MailMessage -To drush@evertz.com -From Reports@5288.IT -SmtpServer mail.burlington.evertz.tv -Subject RemoveFolder -Body ($message | Out-String)
