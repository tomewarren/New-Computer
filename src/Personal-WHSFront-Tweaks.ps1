## Add Handbrake to system path
$AddedLocation ="C:\Program Files\Handbrake"
$Reg = "Registry::HKLM\System\CurrentControlSet\Control\Session Manager\Environment"
$OldPath = (Get-ItemProperty -Path "$Reg" -Name PATH).Path
$NewPath= $OldPath + ';' + $AddedLocation
Set-ItemProperty -Path "$Reg" -Name PATH –Value $NewPath

## Add Powershell modules
$documents = [environment]::getfolderpath("mydocuments")
$AddedLocation = "$documents\Programs\Scripts\Templates"
$Reg = "Registry::HKLM\System\CurrentControlSet\Control\Session Manager\Environment"
$OldPath = (Get-ItemProperty -Path "$Reg" -Name PSModulePath).PSModulePath
$NewPath= $OldPath + ';' + $AddedLocation
Set-ItemProperty -Path "$Reg" -Name PSModulePath –Value $NewPath
