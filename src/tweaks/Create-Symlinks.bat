
:: Add Dropbox to Documents folder
cd %userprofile%\Documents
mklink /d Dropbox %userprofile%\Dropbox

:: ConEmu settings
del "C:\tools\cmder\vendor\conemu-maximus5\ConEmu.xml"
mklink /H "C:\tools\cmder\vendor\conemu-maximus5\ConEmu.xml" "%userprofile%\Dropbox\Programs\Settings\ConEmu.xml" 
