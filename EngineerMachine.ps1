# Run this in an admin powershell Window
# Step 1 - Manual step - set shared rive server to 127.0.0.1 in hosts file
# Step 2 - Admin powershell: . { iwr -UseBasicParsing https://raw.githubusercontent.com/adamedx/winbox/0.1.79/files/default/install.ps1 } | iex;install-workstation  ## From https://github.com/adamedx/winbox
# Step 3 - Copy the winbox-ps-shell from above location to user profile
# Step 4 - Now run the below

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
  "https://raw.githubusercontent.com/iRobie/New-Computer/master/src/Personal-Engineer.txt",
  "https://raw.githubusercontent.com/iRobie/New-Computer/master/src/Finalize.txt"
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
