# Kiosk Mode In Windows - Chrome on Multiple Displays
Moves chrome windows in full screen to several displays, creating AKA Kiosk mode on Windows with Multiple displays. 

It allows you to:
- start all chrome instances in full screen mode automatically
- move them to certain Monitors

# Steps

## 1. Download and Extract
Download the latest release and extract contents to C:\Kiosk-Mode. 
  You may put into another folder – but ensure you renamed path in all places.
## 2. Modify Ciklum-Kiosk.ps1
  Put necessary URLs and Monitor Numbers (starting from 1)
## 3. Enable Scripts Execution
Run PowerShell as Administrator and execute the following, confirm when prompted:
```powershell
  Set-ExecutionPolicy RemoteSigned
```
## 4. Launch Shortcut
Double click on link (Start – Kios – modifypath.lnk) to ensure browsers are started and opened on necessary displays.
**Note**: you may need to modify your link if you put file not into C:\Kiosk-Mode. Right click on it -> properties and fill it accordingly.
## 5. Autostart.
Copy the link/shortcut to desktop for easy access and to your startup folder.

##Troubleshooting

If window is not moved to another desktop – try increasing the delay in script ($ChromeStartDelay) variable.

Script has been tested on Windows 8.1 machine.

# Full Article Link:
https://alextomin.wordpress.com/2015/04/10/kiosk-mode-in-windows-chrome-on-multiple-displays/


