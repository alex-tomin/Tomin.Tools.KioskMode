#------------------------------------
#     Functions Definition 
#   Do NOT TOUCH this section!  
#------------------------------------
param
( 
  [Parameter(Mandatory)]
  [string]
  $Arguments,

  [Parameter(Mandatory)]
  [Int]
  $MonitorNum,

  [string]
  $Program = 'C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe',

  [Int]
  $StartDelay = 1
)

Add-Type -assembly System.Windows.Forms
Add-Type -Name WinAPIHelpers -Namespace WinApi -MemberDefinition '
    [DllImport("user32.dll")]
    public static extern bool MoveWindow(IntPtr hWnd, int X, int Y, int W, int H); 
    
    [DllImport("user32.dll")]
	public static extern bool SetForegroundWindow(IntPtr hWnd);
    
    [DllImport("user32.dll")]
	[return: MarshalAs(UnmanagedType.Bool)]
	public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);'

$WinAPI = [WinApi.WinAPIHelpers]
$Screen = [System.Windows.Forms.Screen]
$SendKeys = [System.Windows.Forms.SendKeys]



Write-Output "starting $Program with $Arguments , monitor: $MonitorNum"
Start-Process -FilePath $Program $Arguments   # note chrome main window will be destroyed, so cannot use handle returned from start-process command.

Start-Sleep -Seconds $StartDelay
$window = (Get-Process -Name msedge | where {$_.MainWindowHandle -ne ([IntPtr]::Zero)} | select -First 1).MainWindowHandle

$monitor =  $MonitorNum-1;
$left = $Screen::AllScreens[$monitor].WorkingArea.Left
$top = $Screen::AllScreens[$monitor].WorkingArea.Top

$WinAPI::ShowWindow($window, 9) # 9 == Restore
$WinAPI::MoveWindow($window, $left, $top, 1000, 800)

$WinAPI::SetForegroundWindow($window);
$SendKeys::SendWait("{F11}");
$SendKeys::Flush();

Start-Sleep -Seconds $StartDelay