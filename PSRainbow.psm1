Set-StrictMode -Version Latest

. "$($PSScriptRoot)\Classes\ConsoleColor24.ps1"

[Hashtable]$RawColorData = Import-PowerShellDataFile -Path "$($PSScriptRoot)\Public\NamedColorData.psd1"
[Hashtable]$PSRainbowColors = @{}

Foreach($ColorDataKey in $RawColorData.Keys) {
    $PSRainbowColors[$ColorDataKey] = [ConsoleColor24]::new($RawColorData[$ColorDataKey])
}

Export-ModuleMember -Variable PSRainbowColors
Export-ModuleMember -Function New-ConsoleColor24