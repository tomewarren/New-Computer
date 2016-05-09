:: Run this in an admin powershell Window

## Concat Boxstarter files to a local file


  $BoxstarterFile = "C:\tools\Boxstarter.txt"

  # Create tools directory if Boxstarter didn't already
  if((Test-Path -Path $BoxstarterFile )){
    Remove-Item -path $BoxstarterFile
  }
  New-Item -path $BoxstarterFile -type file -force

  # List of sources for this machine
  $sources = @("https://raw.githubusercontent.com/iRobie/New-Computer/master/src/initialize.txt",
  "https://raw.githubusercontent.com/iRobie/New-Computer/master/src/WindowsUpdate.txt",
  "https://raw.githubusercontent.com/iRobie/New-Computer/master/src/Basic-Computer.txt",
  "https://raw.githubusercontent.com/iRobie/New-Computer/master/src/Personal-Base.txt",
  "https://raw.githubusercontent.com/iRobie/New-Computer/master/src/Personal-Engineer.txt"
  )

  # Generate boxstarter file
  foreach ($source in $sources)
  {
    add-content $BoxstarterFile -value ((new-object net.webclient).DownloadString($source))
  }


## Run the boxstarter file
START http://boxstarter.org/package/nr/url?$BoxstarterFile

## List of manual installs
# Microsoft Office 365 Support and Recovery Assistant
# Dism /online /enable-feature /featurename:NetFx3 /All /Source:E:\sources\sxs /LimitAccess
