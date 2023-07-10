######################################################
##########            Kiosk Mode          ############
######################################################
#
# Runs edge in full-screen mode on predefined screens
# ----------------------------------------------------

Set-Location $PSScriptRoot

# Kill all running instances
# &taskkill /im msedge* /F

. .\Kiosk.ps1 -Arguments '--new-window https://google.com\' -MonitorNum 2
# TODO: open a tab
. .\Kiosk.ps1 -Arguments '--new-window https://google.com\' -MonitorNum 3
