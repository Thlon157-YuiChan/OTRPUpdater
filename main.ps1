Param(
    [String]$SimuInPath = "C:\Program Files (x86)\Simutrans\",
    [String]$ExeFileName = "simutrans-OTRP.exe"
)

$API_DATA = curl https://api.github.com/repos/teamhimeh/simutrans/releases/latest
$JSON = $API_DATA | ConvertFrom-Json
$VERSION = $JSON.name
$DOWNLOAD_URL = $JSON.assets.browser_download_url[2]
Write-Host $VERSION
Write-Host $DOWNLOAD_URL
(New-Object System.Net.WebClient).DownloadFile($DOWNLOAD_URL,"OTRP.zip")
Expand-Archive -Path .\OTRP.zip -DestinationPath .\OTRP\
$EXE = Get-ChildItem -Filter *.exe -Path .\OTRP\
Rename-Item -Path $EXE -NewName $ExeFileName
Copy-Item -Filter *.exe -Path .\OTRP\* -Destination $SimuInPath
Remove-Item -Path 