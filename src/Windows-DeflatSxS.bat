:: JOB: Rebuild Windows Update base (deflates the SxS store; note that any Windows Updates installed prior to this point will no longer be uninstallable)
:: Windows 8/2012 and up only
:: Source: https://github.com/bmrf/tron/blob/master/resources/stage_5_patch/stage_5_patch.bat

Dism /online /Cleanup-Image /StartComponentCleanup /ResetBase >nul 2>&1
	
