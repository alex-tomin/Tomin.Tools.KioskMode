######################################################
##########            Kiosk Mode          ############
######################################################
#
# Runs chrome and other apps in full-screen mode 
# on predefined screens
# ----------------------------------------------------

$chromePath = 'C:\Program Files (x86)\Google\Chrome\Application\chrome.exe'
$chromeArguments = '--new-window --incognito'
$cockpitPath =  'C:\Kiosk-Mode\Cockpit.CommunicationSpace.appref-ms'

Set-Location $PSScriptRoot
. .\HelperFunctions.ps1

#Kill all running
&taskkill /im chrome* /F
&taskkill /im Ciklum.Cockpit.CommunicationSpace* /F


Cockpit-Start -MonitorNum 2 #middle top

Chrome-Kiosk 'http://dashboard.hubclone.pp.ciklum.com/dashboard/externalRequests' -MonitorNum 4 #left
Chrome-Kiosk 'http://dashboard.hubclone.pp.ciklum.com/dashboard/externalProjects' -MonitorNum 1 #middle bottom
Chrome-Kiosk 'http://dashboard.hubclone.pp.ciklum.com/dashboard/metrixDashboards' -MonitorNum 3 #right


Pause