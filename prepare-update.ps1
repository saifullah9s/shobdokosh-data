param(
    [Parameter(Mandatory=$true)]
    [string]$SourceJson,

    [Parameter(Mandatory=$true)]
    [int]$Version,

    [int]$SchemaVersion = 1,
    [int]$MinimumAppVersion = 1,
    [string]$ReleaseNotes = "Dictionary corrections and updates."
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path $SourceJson)) {
    throw "Source JSON was not found: $SourceJson"
}

# Validate JSON syntax.
$null = Get-Content -Raw -Encoding UTF8 $SourceJson | ConvertFrom-Json

$ProjectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$DocsFolder = Join-Path $ProjectRoot "docs"
New-Item -ItemType Directory -Force -Path $DocsFolder | Out-Null

$FileName = "dictionary-v$Version.json"
$Destination = Join-Path $DocsFolder $FileName
Copy-Item -Force $SourceJson $Destination

$Hash = (Get-FileHash -Algorithm SHA256 $Destination).Hash.ToLower()
$Size = (Get-Item $Destination).Length
$Today = Get-Date -Format "yyyy-MM-dd"

$Manifest = [ordered]@{
    dictionaryVersion = $Version
    schemaVersion = $SchemaVersion
    fileName = $FileName
    updatedAt = $Today
    sizeBytes = $Size
    sha256 = $Hash
    minimumAppVersion = $MinimumAppVersion
    releaseNotes = $ReleaseNotes
}

$Manifest |
    ConvertTo-Json -Depth 10 |
    Set-Content -Encoding UTF8 (Join-Path $DocsFolder "manifest.json")

Write-Host ""
Write-Host "Prepared successfully:"
Write-Host "  File: $Destination"
Write-Host "  Size: $Size bytes"
Write-Host "  SHA-256: $Hash"
Write-Host ""
Write-Host "Upload the dictionary file first, then manifest.json last."
