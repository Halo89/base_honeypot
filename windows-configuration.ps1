[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Invoke-WebRequest https://download.sysinternals.com/files/Sysmon.zip -OutFile "Sysmon.zip"

$syspath = "C:\Program Files\Sysmon"
New-Item -Path $syspath -ItemType Directory
Expand-Archive -LiteralPath Sysmon.zip -DestinationPath $syspath

Invoke-WebRequest https://raw.githubusercontent.com/SwiftOnSecurity/sysmon-config/master/sysmonconfig-export.xml -OutFile "C:\Program Files\Sysmon\sysmonconfig-export.xml"

#start 'C:\WINDOWS\system32\notepad.exe' "C:\Program Files\Sysmon\sysmonconfig-export.xml"
& "C:\Program/Files\Sysmon\sysmon" -accepteula -i "C:\Program Files\Sysmon\sysmonconfig-export.xml"

& "C:\Program Files\Sysmon\sysmon" -accepteula -i "C:\Program Files\Sysmon\sysmonconfig-export.xml"

########################################################################################
#winlogbeat install

$wlogbeatpath = "C:\Program Files\Winlogbeat"
New-Item -Path $wlogbeatpath -ItemType Directory
Invoke-WebRequest https://artifacts.elastic.co/downloads/beats/winlogbeat/winlogbeat-8.12.2-windows-x86_64.zip -OutFile "winlogbeat-8.12.2-windows-x86_64.zip"

Expand-Archive -LiteralPath winlogbeat-8.12.2-windows-x86_64.zip -DestinationPath $wlogbeatpath

Start-Service "C:\Program Files\Winlogbeat\winlogbeat-8.12.2-windows-x86_64\winlogbeat"

#Editar configuración de Winlogbeat y configurar dirección logstash
start 'C:\WINDOWS\system32\notepad.exe' "C:\Program Files\Winlogbeat\winlogbeat-8.12.2-windows-x86_64\winlogbeat.yml"

PowerShell.exe -ExecutionPolicy UnRestricted -File "C:\Program Files\Winlogbeat\winlogbeat-8.12.2-windows-x86_64\install-service-winlogbeat.ps1"

#Start-Service winlogbeat

#########################################################################################
#Creación de Grupo de Usuarios

New-LocalGroup Usuarios

#Creación de usuarios

$admin = ConvertTo-SecureString -String "Wyse#123" -AsPlainText -Force
New-LocalUser admin -PasswordNeverExpires -Password $admin
Add-LocalGroupMember -Group Usuarios -Member admin

$wasadmin = ConvertTo-SecureString -String "wasadmin" -AsPlainText -Force
New-LocalUser wasadmin -PasswordNeverExpires -Password $wasadmin
Add-LocalGroupMember -Group Usuarios -Member wasadmin

$maxadmin = ConvertTo-SecureString -String "maxadmin" -AsPlainText -Force
New-LocalUser maxadmin -PasswordNeverExpires -Password $maxadmin
Add-LocalGroupMember -Group Usuarios -Member maxadmin

$vagrant = ConvertTo-SecureString -String "vagrant" -AsPlainText -Force
New-LocalUser vagrant -PasswordNeverExpires -Password $vagrant
Add-LocalGroupMember -Group Usuarios -Member vagrant

$ftp = ConvertTo-SecureString -String "Wyse#123" -AsPlainText -Force
New-LocalUser ftp -PasswordNeverExpires -Password $ftp
Add-LocalGroupMember -Group Usuarios -Member ftp

$john = ConvertTo-SecureString -String "Password123!" -AsPlainText -Force
New-LocalUser john -PasswordNeverExpires -Password $john
Add-LocalGroupMember -Group Usuarios -Member john

$administrator = ConvertTo-SecureString -String "Wyse#123" -AsPlainText -Force
New-LocalUser administrator -PasswordNeverExpires -Password $administrator
Add-LocalGroupMember -Group Usuarios -Member administrator

Install-Module -Name PolicyFileEditor
