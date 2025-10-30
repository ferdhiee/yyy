<#
 Simple serve script for Windows PowerShell.
 Usage: open PowerShell in C:\Piee and run: .\serve.ps1
 It prints localhost and LAN URLs and starts a Python HTTP server on port 8000.
#>

param(
    [int]$Port = 8000
)

Write-Host "Serving folder: $(Get-Location)" -ForegroundColor Cyan

try {
    $hostName = [System.Net.Dns]::GetHostName()
    $addr = ([System.Net.Dns]::GetHostEntry($hostName).AddressList | Where-Object { $_.AddressFamily -eq 'InterNetwork' } | Select-Object -First 1)
    if ($addr) {
        $lan = $addr.IPAddressToString
    } else {
        $lan = $null
    }
} catch {
    $lan = $null
}

Write-Host "Local: http://localhost:$Port" -ForegroundColor Yellow
if ($lan) { Write-Host "LAN:   http://$lan:$Port" -ForegroundColor Green } else { Write-Host "LAN IP not found (no network?)." -ForegroundColor DarkYellow }
Write-Host "(Press Ctrl+C to stop server)" -ForegroundColor Gray
Write-Host "If you need public access, see README.md for GitHub Pages or ngrok options." -ForegroundColor Gray

# Start Python HTTP server
try {
    python -m http.server $Port
} catch {
    Write-Host "Failed to launch Python HTTP server. Make sure Python 3 is installed and on PATH." -ForegroundColor Red
}
