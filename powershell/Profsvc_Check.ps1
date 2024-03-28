Get-ChildItem C:\Users

Get-ChildItem O:\ProfilesFolder\Users

Get-Process 

Get-Service profsvc | select *

(Get-Service profsvc).dependentservices

Get-Process FWAService | Select -ExpandProperty Modules | Group -Property Filename | Select Name

