$fileshares = Import-Csv -Path .\fileshares.csv
Write-Host "Mapping network shares." -ForegroundColor Cyan

foreach ($fileshare in $fileshares) {
    $originalString = "Mapping $($fileshare.letter) to \\$($fileshare.server)\$($fileshare.shareFolder)."
	$paddedString = $originalString.PadRight(45," ")
	Write-Host $paddedString -NoNewline

    $networkPath = "$($fileshare.letter):\$($fileshare.testFolder)" 
    $pathExists = Test-Path -Path $networkpath

    If ($pathExists)  {
        Write-Host "Path already existed." -ForegroundColor DarkGreen
    }
    else {
        try {
            (new-object -com WScript.Network).MapNetworkDrive("$($fileshare.letter):","\\$($fileshare.server)\$($fileshare.shareFolder)")
            Write-Host "Path created successfully." -ForegroundColor DarkGreen
        }
        catch {
            Write-Host "Still didn't work!" -ForegroundColor Red
        }
	}
}
Pause