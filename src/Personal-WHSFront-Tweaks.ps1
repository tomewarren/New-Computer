## Add Handbrake to system path
$AddedLocation ="C:\Program Files\Handbrake"
$Reg = "Registry::HKLM\System\CurrentControlSet\Control\Session Manager\Environment"
$OldPath = (Get-ItemProperty -Path "$Reg" -Name PATH).Path
$NewPath= $OldPath + ';' + $AddedLocation
Set-ItemProperty -Path "$Reg" -Name PATH –Value $NewPath

## Add Powershell modules
New-Item "$env:USERPROFILE\Documents\WindowsPowerShell" -type directory -force
cd "$env:USERPROFILE\Documents\WindowsPowerShell"
cmd /c mklink /d Modules $env:USERPROFILE\Dropbox\Programs\Scripts\Templates
