#------------------------------------
#     Functions Definition 
#   Do NOT TOUCH this section!  
#------------------------------------
param
( 
  [Parameter(Mandatory)]
  [string]
  $ProcessName,

  [Parameter(Mandatory)]
  [Int]
  $MonitorNum,

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
    public static extern IntPtr GetWindowText(IntPtr hWnd, System.Text.StringBuilder text, int count);

    [DllImport("user32.dll")]
	  [return: MarshalAs(UnmanagedType.Bool)]
	  public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);

    [DllImport("user32.dll")]
    public static extern IntPtr SendMessage(IntPtr hWnd, UInt32 Msg, IntPtr wParam, IntPtr lParam);'

$WinAPI = [WinApi.WinAPIHelpers]
$Screen = [System.Windows.Forms.Screen]
$SendKeys = [System.Windows.Forms.SendKeys]

Start-Sleep -Seconds $StartDelay
$window = (Get-Process -Name $ProcessName | where {$_.MainWindowHandle -ne ([IntPtr]::Zero)} | select -First 1).MainWindowHandle
Write-Output "Moving $ProcessName to monitor: $MonitorNum"

$monitor =  $MonitorNum-1;
$left = $Screen::AllScreens[$monitor].WorkingArea.Left
$top = $Screen::AllScreens[$monitor].WorkingArea.Top

$WinAPI::ShowWindow($window, 9) # 9 == Restore
$WinAPI::MoveWindow($window, $left, $top, 1000, 800)

$WinAPI::SetForegroundWindow($window);
$SendKeys::SendWait("{F11}");
$SendKeys::Flush();

Start-Sleep -Seconds $StartDelay
## kill full screen browser message - it's w/o title.
$window = (Get-Process -Name $ProcessName | where {$_.MainWindowHandle -ne ([IntPtr]::Zero)} | select -First 1).MainWindowHandle
$stringbuilder = New-Object System.Text.StringBuilder 256
$WinAPI::GetWindowText($window, $stringbuilder, 256) | Out-Null

if(-Not $stringbuilder.ToString()) {
  $WinAPI::SendMessage($window, 0x0010, [IntPtr]::Zero, [IntPtr]::Zero)
  Write-Output "Closing F11 window if found"
}