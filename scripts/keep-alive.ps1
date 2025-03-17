$url = "https://nextjs-aef0ewfhg6f4g0gs.eastus-01.azurewebsites.net/"
$interval = 60  # Time in seconds between requests

while ($true) {
    try {
        $response = Invoke-WebRequest -Uri $url -UseBasicParsing
        Write-Host "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] Request successful: $($response.StatusCode)"
    } catch {
        Write-Host "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] Request failed: $_"
    }
    Start-Sleep -Seconds $interval
}
