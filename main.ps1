$configFilePath = "config.json"
$config = Get-Content -Path $configFilePath -Raw | ConvertFrom-Json

$SimuInPath = $config.Config.INSTALL_PATH
$ExeFileName = $config.Config.EXEFILE_NAME

$API_DATA = curl https://api.github.com/repos/teamhimeh/simutrans/releases/latest
$JSON = $API_DATA | ConvertFrom-Json
$VERSION = $JSON.name
$DOWNLOAD_URL = $JSON.assets.browser_download_url[2]
Write-Host $VERSION
Write-Host $DOWNLOAD_URL
(New-Object System.Net.WebClient).DownloadFile($DOWNLOAD_URL,"OTRP.zip")
Expand-Archive -Path OTRP.zip -DestinationPath .\temp\ -Force
$EXE = Get-ChildItem -Filter *.exe -Path temp
$ALLFILEPATH = $SimuInPath + $ExeFileName
$TEMPEXEPATH = ".\temp\" + $EXE
Write-Host $EXE
Write-Host $SimuInPath
Write-Host $ExeFileName
Write-Host $ALLFILEPATH
Rename-Item -Path $TEMPEXEPATH -NewName $ExeFileName
Copy-Item -Filter *.exe -Path .\temp\* -Destination $SimuInPath -Force
Remove-Item -Path .\OTRP.zip
Remove-Item -Recurse -Path .\temp\