$boxstarterfolder = Join-Path $env:APPDATA "Boxstarter" 
Resolve-Path $boxstarterfolder\Boxstarter.*\*.psd1 | 
    % { Import-Module $_.ProviderPath -DisableNameChecking -Force -ErrorAction SilentlyContinue }
Import-Module $boxstarterfolder\Boxstarter.Common\Boxstarter.Common.psd1 -Function Test-Admin

if(!(Test-Admin)) {
    Write-BoxstarterMessage "Not running with administrative rights. Attempting to elevate..."
    $command = "-ExecutionPolicy bypass -noexit -command &'C:\tools\Run-WindowsUpdates.ps1'"
    Start-Process powershell -verb runas -argumentlist $command
    Exit
}

$Host.UI.RawUI.WindowTitle="Windows Updates"
cd $env:SystemDrive\
Write-Output @"
Running Windows updates with the following command:
Install-BoxstarterPackage -PackageName C:\tools\Boxstarter-Update.txt
"@
Install-BoxstarterPackage -PackageName C:\tools\Boxstarter-Update.txt