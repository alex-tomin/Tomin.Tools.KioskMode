######################################################
##########            Kiosk Mode          ############
######################################################
#
# Runs edge in full-screen mode on predefined screens
# ----------------------------------------------------

Set-Location $PSScriptRoot

# Kill all running instances
# &taskkill /im msedge* /F

start msedge "--new-window https://eng.ms/" -WindowStyle maximized
. .\Move-Window.ps1 -ProcessName msedge -MonitorNum 3

start msedge "--new-window https://contoso.com"
. .\Move-Window.ps1 -ProcessName msedge -MonitorNum 2
# move first before opening another tab, as the windows needs to be active,
start msedge "https://stackoverflow.com"

start msedge "--new-window https://contoso.com"
. .\Move-Window.ps1 -ProcessName -MonitorNum 1
