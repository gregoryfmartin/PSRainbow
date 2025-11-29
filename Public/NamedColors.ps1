using namespace System

Set-StrictMode -Version Latest

. "$($PSScriptRoot)\..\Classes\ConsoleColor24.ps1"

[Hashtable]$RawColorData = Import-PowerShellDataFile -Path "$($PSScriptRoot)\NamedColorData.psd1"
[Hashtable]$Global:PSRainbowColors = @{}

Foreach($ColorDataKey in $RawColorData.Keys) {
    $Global:PSRainbowColors[$ColorDataKey] = [ConsoleColor24]::new($RawColorData[$ColorDataKey])
}
