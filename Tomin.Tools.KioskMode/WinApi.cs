using System;
using System.Runtime.InteropServices;
using System.Windows.Forms;
using Tomin.Tools.KioskMode.Enums;

namespace Tomin.Tools.KioskMode
{

	public static class WinApi
	{
		[DllImport("user32.dll", SetLastError = true)]
		public static extern bool SetWindowPos(IntPtr hWnd, IntPtr hWndInsertAfter, int X, int Y, int cx, int cy,
			SetWindowPosFlags uFlags);

		[DllImport("user32.dll")]
		[return: MarshalAs(UnmanagedType.Bool)]
		public static extern bool ShowWindow(IntPtr hWnd, ShowWindowCommands nCmdShow);

		[DllImport("user32.dll")]
		public static extern bool SetForegroundWindow(IntPtr hWnd);

	}

	public static class Helper
	{
		/// <summary>
		/// Moves non-fullscreen window to specified monitor. (number starts from 1)
		/// </summary>
		/// <param name="windowHandle"></param>
		/// <param name="monitor">Monitor number, statrs from 1</param>
		public static bool MoveToMonitor(IntPtr windowHandle, int monitor)
		{
			monitor = monitor - 1;
			return WinApi.SetWindowPos(windowHandle, IntPtr.Zero, Screen.AllScreens[monitor].WorkingArea.Left,
			 Screen.AllScreens[monitor].WorkingArea.Top, 1000, 800, SetWindowPosFlags.SWP_NOZORDER | SetWindowPosFlags.SWP_NOREDRAW);
		}

		public static void SendKey(IntPtr windowHandle, string keys)
		{
			WinApi.SetForegroundWindow(windowHandle);
			SendKeys.SendWait(keys);
			SendKeys.Flush();
		}

	}

}
