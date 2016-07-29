:: Run this in an admin CMD window
@powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin

powershell

## Concat Boxstarter files to a local file

  #Rename the computer
  Rename-Computer -NewName "Roberts-iMac"

  $BoxstarterFile = "C:\tools\Boxstarter.txt"


  # Create tools directory if Boxstarter didn't already
  if((Test-Path -Path $BoxstarterFile )){
    Remove-Item -path $BoxstarterFile
  }
  New-Item -path $BoxstarterFile -type file -force


  # List of sources for this machine
  $sources = @("https://raw.githubusercontent.com/iRobie/New-Computer/master/src/processes/initialize.txt",
  "https://raw.githubusercontent.com/iRobie/New-Computer/master/src/install-lists/Basic-Computer.txt",
  "https://raw.githubusercontent.com/iRobie/New-Computer/master/src/install-lists/Personal-Base.txt",
  "https://raw.githubusercontent.com/iRobie/New-Computer/master/src/install-lists/Personal-WHSFront.txt",
  "https://raw.githubusercontent.com/iRobie/New-Computer/master/src/install-lists/Personal-Bootcamp-iMac.txt"
  )

  # Generate boxstarter file
  foreach ($source in $sources)
  {
    add-content $BoxstarterFile -value ((new-object net.webclient).DownloadString($source))
  }

  $WindowsUpdatefile = "C:\tools\Boxstarter-Update.txt"
  $WindowsUpdatePS1 = Join-Path ([Environment]::GetFolderPath("Desktop")) "Run-WindowsUpdates.ps1"

  # Create tools directory if Boxstarter didn't already
  if((Test-Path -Path $WindowsUpdatefile )){
    Remove-Item -path $WindowsUpdatefile 
  }
  New-Item -path $WindowsUpdatefile -type file -force
  New-Item -path $WindowsUpdatePS1 -type file -force

  # List of sources for this machine
  $wusources = @("https://raw.githubusercontent.com/iRobie/New-Computer/master/src/processes/WindowsUpdate.txt",
  "https://raw.githubusercontent.com/iRobie/New-Computer/master/src/processes/finalize.txt"
  )

  # Generate boxstarter file
  foreach ($wusource in $wusources)
  {
    add-content $WindowsUpdatefile -value ((new-object net.webclient).DownloadString($wusource))
  }

## Create Windows Update powershell
$windowsupdatecmd = "START http://boxstarter.org/package/nr/url?$WindowsUpdatefile"

set-content -path $WindowsUpdatePS1 -value $windowsupdatecmd 

# Add instructions for manually running file
add-content $WindowsUpdatePS1 -value "# To run updates manually, open the following link in a Click-Once compatible browser (IE or Edge):"
add-content $WindowsUpdatePS1 -value "# http://boxstarter.org/package/nr/url?$WindowsUpdatefile"


## Run the boxstarter file
START http://boxstarter.org/package/nr/url?$BoxstarterFile

## List of manual installs
# Dism /online /enable-feature /featurename:NetFx3 /All /Source:E:\sources\sxs /LimitAccess
# Intel Management Engine Interface
# Intel INF installation
# Intel® Rapid Storage Technology
# Nvidia driver
