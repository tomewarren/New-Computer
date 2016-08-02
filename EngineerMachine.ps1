## Concat Boxstarter files to a local file


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
  "https://raw.githubusercontent.com/iRobie/New-Computer/master/src/install-lists/Personal-Engineer.txt"
  )

  # Generate boxstarter file
  foreach ($source in $sources)
  {
    add-content $BoxstarterFile -value ((new-object net.webclient).DownloadString($source))
  }

  $WindowsUpdatefile = "C:\tools\Boxstarter-Update.txt"
  $WindowsUpdatePS1 = "C:\tools\Run-WindowsUpdates.ps1

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
$runwindowsupdatefile = "https://raw.githubusercontent.com/iRobie/New-Computer/master/src/processes/Run-WindowsUpdates.ps1"
add-content $WindowsUpdatePS1 -value ((new-object net.webclient).DownloadString($runwindowsupdatefile))


## Run the boxstarter file
START http://boxstarter.org/package/nr/url?$BoxstarterFile

## List of manual installs
# Microsoft Office 365 Support and Recovery Assistant
# Dism /online /enable-feature /featurename:NetFx3 /All /Source:E:\sources\sxs /LimitAccess

