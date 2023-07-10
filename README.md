# Kiosk Mode In Windows - Chrome or Edge on Multiple Displays

Moves browser windows in full screen to several displays, creating a sort of Kiosk mode on Windows with Multiple displays.

It allows you to:

- start all browser instances in full screen mode automatically
- move them to certain Monitors
- Allow to open multiple tabs (e.g. to cycle through the tabs)

# Why Not Alternative Solutions?

## Alternative 1 - Native CLI

e.g. from [Stack Overflow Answer](https://stackoverflow.com/questions/29294045/how-to-open-two-instances-of-chrome-kiosk-mode-in-different-displays-windows)

```
start chrome.exe --app="http://www.domain1.com" --window-position=0,0 --kiosk --user-data-dir=c:/monitor1
```

#### Downsides

* Requires profile folders per monitor
* app mode does not allow tabs 😕

## Alternative 2 - Native CLI + Javascript

e.g. from [Another Stack Overflow Answer](https://stackoverflow.com/questions/13436855/launch-google-chrome-from-the-command-line-with-specific-window-coordinates)

```
"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" 
     --profile-directory="Default"
     --app="data:text/html,<html><body><script>window.moveTo(580,240);window.resizeTo(800,600);window.location='http://www.test.de';</script></body></html>"
```

#### Downsides

* Works only in app mode, which does not allow tabs 😕

# Steps

## 1. Download and Extract

Download the latest release and extract contents to C:\Kiosk-Mode.
You may put into another folder – but ensure you renamed path in all places.

## 2. Modify Start-Kiosk.ps1

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

If window is not moved to another desktop – try increasing the delay in script (add `StartDelay` parameter).

Script has been tested on Windows 10 machine.

# Old Article Link:

https://alextomin.wordpress.com/2015/04/10/kiosk-mode-in-windows-chrome-on-multiple-displays/
