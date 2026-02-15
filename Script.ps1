param (
    [Parameter(Mandatory = $true)]
    [string]$GitHubURL,

    [Parameter(Mandatory = $true)]
    [string]$TestDatabaseName
)

$ErrorActionPreference = "Stop"

# Get last part of URL
$stripURL = ($GitHubURL.Split("/") | Select-Object -Last 1)

# ZIP package scenario
if ($stripURL -like "*.zip*") {

    # Remove query string and .zip
    $cleanName = $stripURL
    if ($cleanName.Contains("?")) {
        $cleanName = $cleanName.Substring(0, $cleanName.IndexOf("?"))
    }

    $baseName = [System.IO.Path]::GetFileNameWithoutExtension($cleanName)
    $path = "D:\SQLScriptZipFiles\$TestDatabaseName\$baseName"

    if (Test-Path $path) {
        Write-Host "Package '$baseName' is staged for Production Release" -ForegroundColor Green
    }
    else {
        throw "Database Package: $baseName does not exist!"
    }
}
else {
    # Script scenario
    $baseName = $stripURL
    if ($baseName.Contains("?")) {
        $baseName = $baseName.Substring(0, $baseName.IndexOf("?"))
    }

    $path = "D:\SQLScripts\$TestDatabaseName\$baseName"

    if (Test-Path $path) {
        Write-Host "Script '$baseName' is staged for Production Release" -ForegroundColor Green
    }
    else {
        throw "Database Script: $baseName does not exist!"
    }
}
