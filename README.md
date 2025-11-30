# PSRainbow

A PowerShell module that provides 24-bit true color support for console output. Create vibrant, colorful console text and backgrounds using the full RGB color spectrum with ANSI escape sequences.

Yeah, I wrote the readme with AI. Sue me. It's 22:32 and I'm tired.

## Features

- **24-bit True Color Support**: Use any RGB color instead of the standard 16 console colors
- **Named Color Library**: 250+ pre-defined colors including system colors, web colors, and UI colors
- **Multi-Edition Support**: Works with PowerShell Desktop and PowerShell Core
- **Easy-to-Use API**: Simple cmdlets to create and format colors
- **ANSI Escape Sequence Generation**: Automatic ANSI sequence generation for foreground and background colors

## Installation

PSRainbow is available on the PowerShell Gallery:

```powershell
Install-Module PSRainbow
```

## Quick Start

### Create a Color

```powershell
# USING RGB VALUES
$Red = New-ConsoleColor24 -Red 255 -Green 0 -Blue 0

# RGB CAN BE SPECIFIED POSITIONALLY (IN ORDER RGB)
$White = New-ConsoleColor24 255 255 255

# USING HEXADECIMAL
$Blue = New-ConsoleColor24 -Hex 0x0000FF

# USING A PRE-DEFINED COLOR FROM PSRAINBOWCOLORS
$Purple = $PSRainbowColors.Purple

# YOU CAN ALSO USE THE CONSOLECOLOR24 CLASS DIRECTLY
[ConsoleColor24]$AColor       = [ConsoleColor24]::new(255, 255, 255)
[ConsoleColor24]$AnotherColor = [ConsoleColor24]::new(0xff6311)
[ConsoleColor24]$CopiedColor  = [ConsoleColor24]::new($AColor)
```

### Format and Display Colors

```powershell
# FORMAT A COLOR FOR FOREGROUND OUTPUT
$fgSeq = Format-ConsoleColor24 -Color $Red -Type Fg

# FORMAT A COLOR FOR BACKGROUND OUTPUT
$bgSeq = Format-ConsoleColor24 -Color $Blue -Type Bg

# USE WITH WRITE-HOST
Write-Host "${fgSeq}This text is red"
Write-Host "${bgSeq}This has a blue background"
```

## Available Cmdlets

### New-ConsoleColor24

Creates a new `ConsoleColor24` object representing a 24-bit color.

**Parameter Sets:**
- `-Red <Int>` `-Green <Int>` `-Blue <Int>` - Specify RGB channels (0-255)
- `-Hex <Int>` - Specify as hexadecimal value (0xRRGGBB)
- `-CopyFrom <ConsoleColor24>` - Copy an existing color object

**Example:**
```powershell
$crimson = New-ConsoleColor24 -Red 220 -Green 20 -Blue 60
$lime = New-ConsoleColor24 -Hex 0x00FF00
```

### Format-ConsoleColor24

Converts a `ConsoleColor24` object into an ANSI escape sequence for console output.

**Parameters:**
- `-Color <ConsoleColor24>` - The color to format
- `-Type <String>` - Either 'Fg' (foreground) or 'Bg' (background)

**Example:**
```powershell
$color = New-ConsoleColor24 -Hex 0xFF6347
$ansi = Format-ConsoleColor24 -Color $color -Type Fg
```

## Available Colors

The module exports a `$PSRainbowColors` hashtable containing 250+ pre-defined colors. Access them like:

```powershell
$PSRainbowColors.Red
$PSRainbowColors.DeepSkyBlue
$PSRainbowColors.DarkOliveGreen
```

### Color Categories

- **Basic Colors**: Red, Green, Blue, Yellow, Cyan, Magenta, White, Black
- **Web Colors**: Named colors from the CSS color specification (140+ colors)
- **System Colors**: Apple iOS system colors with light/dark variants (90+ colors)

Use `$PSRainbowColors.Keys | Sort-Object` to list all available colors.

### Complete Color Reference

The following table shows all 250+ available colors with their hex values and color blocks. PSRainbow places a variable named `PSRainbowColors` in the Global scope which is a `Hashtable` that contains pre-built `ConsoleColor24` instances of these colors:

| Color Name | Hex | Color Block |
|---|---|---|
| IndianRed | #CD5C5C | <span style="color:#cd5c5c">▓▓▓▓▓</span> |
| Crimson | #DC143C | <span style="color:#dc143c">▓▓▓▓▓</span> |
| LightCoral | #F08080 | <span style="color:#f08080">▓▓▓▓▓</span> |
| Red | #FF0000 | <span style="color:#ff0000">▓▓▓▓▓</span> |
| Salmon | #FA8072 | <span style="color:#fa8072">▓▓▓▓▓</span> |
| FireBrick | #B22222 | <span style="color:#b22222">▓▓▓▓▓</span> |
| DarkSalmon | #E9967A | <span style="color:#e9967a">▓▓▓▓▓</span> |
| DarkRed | #8B0000 | <span style="color:#8b0000">▓▓▓▓▓</span> |
| Pink | #FFC0CB | <span style="color:#ffc0cb">▓▓▓▓▓</span> |
| MediumVioletRed | #C71585 | <span style="color:#c71585">▓▓▓▓▓</span> |
| LightPink | #FFB6C1 | <span style="color:#ffb6c1">▓▓▓▓▓</span> |
| PaleVioletRed | #DB7093 | <span style="color:#db7093">▓▓▓▓▓</span> |
| HotPink | #FF69B4 | <span style="color:#ff69b4">▓▓▓▓▓</span> |
| DeepPink | #FF1493 | <span style="color:#ff1493">▓▓▓▓▓</span> |
| LightSalmon | #FFA07A | <span style="color:#ffa07a">▓▓▓▓▓</span> |
| DarkOrange | #FF8C00 | <span style="color:#ff8c00">▓▓▓▓▓</span> |
| Coral | #FF7F50 | <span style="color:#ff7f50">▓▓▓▓▓</span> |
| Orange | #FFA500 | <span style="color:#ffa500">▓▓▓▓▓</span> |
| Tomato | #FF6347 | <span style="color:#ff6347">▓▓▓▓▓</span> |
| Gold | #FFD700 | <span style="color:#ffd700">▓▓▓▓▓</span> |
| OrangeRed | #FF4500 | <span style="color:#ff4500">▓▓▓▓▓</span> |
| Yellow | #FFFF00 | <span style="color:#ffff00">▓▓▓▓▓</span> |
| LightYellow | #FFFFE0 | <span style="color:#ffffe0">▓▓▓▓▓</span> |
| PapayaWhip | #FFEFd5 | <span style="color:#ffefd5">▓▓▓▓▓</span> |
| LemonChiffon | #FFFACD | <span style="color:#fffacd">▓▓▓▓▓</span> |
| Moccasin | #FFE4B5 | <span style="color:#ffe4b5">▓▓▓▓▓</span> |
| LightGoldenrodYellow | #FAFAD2 | <span style="color:#fafad2">▓▓▓▓▓</span> |
| PeachPuff | #FFDAB9 | <span style="color:#ffdab9">▓▓▓▓▓</span> |
| PaleGoldenrod | #EEE8AA | <span style="color:#eee8aa">▓▓▓▓▓</span> |
| Khaki | #F0E68C | <span style="color:#f0e68c">▓▓▓▓▓</span> |
| DarkKhaki | #BDB76B | <span style="color:#bdb76b">▓▓▓▓▓</span> |
| Lavender | #E6E6FA | <span style="color:#e6e6fa">▓▓▓▓▓</span> |
| MediumOrchid | #BA55D3 | <span style="color:#ba55d3">▓▓▓▓▓</span> |
| Thistle | #D8BFD8 | <span style="color:#d8bfd8">▓▓▓▓▓</span> |
| DarkOrchid | #9932CC | <span style="color:#9932cc">▓▓▓▓▓</span> |
| Plum | #DDA0DD | <span style="color:#dda0dd">▓▓▓▓▓</span> |
| DarkViolet | #9400D3 | <span style="color:#9400d3">▓▓▓▓▓</span> |
| Violet | #EE82EE | <span style="color:#ee82ee">▓▓▓▓▓</span> |
| BlueViolet | #8A2BE2 | <span style="color:#8a2be2">▓▓▓▓▓</span> |
| Orchid | #DA70D6 | <span style="color:#da70d6">▓▓▓▓▓</span> |
| MediumPurple | #9370DB | <span style="color:#9370db">▓▓▓▓▓</span> |
| Magenta | #FF00FF | <span style="color:#ff00ff">▓▓▓▓▓</span> |
| Fuchsia | #FF00FF | <span style="color:#ff00ff">▓▓▓▓▓</span> |
| SlateBlue | #6A5ACD | <span style="color:#6a5acd">▓▓▓▓▓</span> |
| MediumSlateBlue | #7B68EE | <span style="color:#7b68ee">▓▓▓▓▓</span> |
| DarkSlateBlue | #483D8B | <span style="color:#483d8b">▓▓▓▓▓</span> |
| Purple | #800080 | <span style="color:#800080">▓▓▓▓▓</span> |
| Indigo | #4B0082 | <span style="color:#4b0082">▓▓▓▓▓</span> |
| GreenYellow | #ADFF2F | <span style="color:#adff2f">▓▓▓▓▓</span> |
| SeaGreen | #2E8B57 | <span style="color:#2e8b57">▓▓▓▓▓</span> |
| Chartreuse | #7FFF00 | <span style="color:#7fff00">▓▓▓▓▓</span> |
| ForestGreen | #228B22 | <span style="color:#228b22">▓▓▓▓▓</span> |
| LawnGreen | #7CFC00 | <span style="color:#7cfc00">▓▓▓▓▓</span> |
| Green | #008000 | <span style="color:#008000">▓▓▓▓▓</span> |
| Lime | #00FF00 | <span style="color:#00ff00">▓▓▓▓▓</span> |
| DarkGreen | #006400 | <span style="color:#006400">▓▓▓▓▓</span> |
| LimeGreen | #32CD32 | <span style="color:#32cd32">▓▓▓▓▓</span> |
| YellowGreen | #9ACD32 | <span style="color:#9acd32">▓▓▓▓▓</span> |
| PaleGreen | #98FB98 | <span style="color:#98fb98">▓▓▓▓▓</span> |
| OliveDrab | #6B8E23 | <span style="color:#6b8e23">▓▓▓▓▓</span> |
| LightGreen | #90EE90 | <span style="color:#90ee90">▓▓▓▓▓</span> |
| Olive | #808000 | <span style="color:#808000">▓▓▓▓▓</span> |
| MediumSpringGreen | #00FA9A | <span style="color:#00fa9a">▓▓▓▓▓</span> |
| DarkOliveGreen | #556B2F | <span style="color:#556b2f">▓▓▓▓▓</span> |
| SpringGreen | #00FF7F | <span style="color:#00ff7f">▓▓▓▓▓</span> |
| MediumAquamarine | #66CDAA | <span style="color:#66cdaa">▓▓▓▓▓</span> |
| MediumSeaGreen | #3CB371 | <span style="color:#3cb371">▓▓▓▓▓</span> |
| DarkSeaGreen | #8FBC8F | <span style="color:#8fbc8f">▓▓▓▓▓</span> |
| LightSeaGreen | #20B2AA | <span style="color:#20b2aa">▓▓▓▓▓</span> |
| DarkCyan | #008B8B | <span style="color:#008b8b">▓▓▓▓▓</span> |
| Teal | #008080 | <span style="color:#008080">▓▓▓▓▓</span> |
| Aqua | #00FFFF | <span style="color:#00ffff">▓▓▓▓▓</span> |
| Cyan | #00FFFF | <span style="color:#00ffff">▓▓▓▓▓</span> |
| SkyBlue | #87CEEB | <span style="color:#87ceeb">▓▓▓▓▓</span> |
| LightCyan | #E0FFFF | <span style="color:#e0ffff">▓▓▓▓▓</span> |
| LightSkyBlue | #87CEFA | <span style="color:#87cefa">▓▓▓▓▓</span> |
| PaleTurquoise | #AFEEEE | <span style="color:#afeeee">▓▓▓▓▓</span> |
| DeepSkyBlue | #00BFFF | <span style="color:#00bfff">▓▓▓▓▓</span> |
| Aquamarine | #7FFFD4 | <span style="color:#7fffd4">▓▓▓▓▓</span> |
| DodgerBlue | #1E90FF | <span style="color:#1e90ff">▓▓▓▓▓</span> |
| Turquoise | #40E0D0 | <span style="color:#40e0d0">▓▓▓▓▓</span> |
| CornflowerBlue | #6495ED | <span style="color:#6495ed">▓▓▓▓▓</span> |
| MediumTurquoise | #48D1CC | <span style="color:#48d1cc">▓▓▓▓▓</span> |
| RoyalBlue | #4169E1 | <span style="color:#4169e1">▓▓▓▓▓</span> |
| DarkTurquoise | #00CED1 | <span style="color:#00ced1">▓▓▓▓▓</span> |
| Blue | #0000FF | <span style="color:#0000ff">▓▓▓▓▓</span> |
| CadetBlue | #5F9EA0 | <span style="color:#5f9ea0">▓▓▓▓▓</span> |
| MediumBlue | #0000CD | <span style="color:#0000cd">▓▓▓▓▓</span> |
| SteelBlue | #4682B4 | <span style="color:#4682b4">▓▓▓▓▓</span> |
| DarkBlue | #00008B | <span style="color:#00008b">▓▓▓▓▓</span> |
| LightSteelBlue | #B0C4DE | <span style="color:#b0c4de">▓▓▓▓▓</span> |
| Navy | #000080 | <span style="color:#000080">▓▓▓▓▓</span> |
| PowderBlue | #B0E0E6 | <span style="color:#b0e0e6">▓▓▓▓▓</span> |
| MidnightBlue | #191970 | <span style="color:#191970">▓▓▓▓▓</span> |
| LightBlue | #ADD8E6 | <span style="color:#add8e6">▓▓▓▓▓</span> |
| Cornsilk | #FFF8DC | <span style="color:#fff8dc">▓▓▓▓▓</span> |
| RosyBrown | #BC8F8F | <span style="color:#bc8f8f">▓▓▓▓▓</span> |
| BlanchedAlmond | #FFEBCD | <span style="color:#ffebcd">▓▓▓▓▓</span> |
| SandyBrown | #F4A460 | <span style="color:#f4a460">▓▓▓▓▓</span> |
| Bisque | #FFE4C4 | <span style="color:#ffe4c4">▓▓▓▓▓</span> |
| Goldenrod | #DAA520 | <span style="color:#daa520">▓▓▓▓▓</span> |
| NavajoWhite | #FFDEAD | <span style="color:#ffdead">▓▓▓▓▓</span> |
| DarkGoldenrod | #B8860B | <span style="color:#b8860b">▓▓▓▓▓</span> |
| Wheat | #F5DEB3 | <span style="color:#f5deb3">▓▓▓▓▓</span> |
| Peru | #CD853F | <span style="color:#cd853f">▓▓▓▓▓</span> |
| BurlyWood | #DEB887 | <span style="color:#deb887">▓▓▓▓▓</span> |
| Chocolate | #D2691E | <span style="color:#d2691e">▓▓▓▓▓</span> |
| Tan | #D2B48C | <span style="color:#d2b48c">▓▓▓▓▓</span> |
| SaddleBrown | #8B4513 | <span style="color:#8b4513">▓▓▓▓▓</span> |
| Sienna | #A0522D | <span style="color:#a0522d">▓▓▓▓▓</span> |
| Maroon | #800000 | <span style="color:#800000">▓▓▓▓▓</span> |
| Brown | #A52A2A | <span style="color:#a52a2a">▓▓▓▓▓</span> |
| White | #FFFFFF | <span style="color:#ffffff">▓▓▓▓▓</span> |
| Gainsboro | #DCDCDC | <span style="color:#dcdcdc">▓▓▓▓▓</span> |
| Snow | #FFFAFA | <span style="color:#fffafa">▓▓▓▓▓</span> |
| LightGray | #D3D3D3 | <span style="color:#d3d3d3">▓▓▓▓▓</span> |
| Honeydew | #F0FFF0 | <span style="color:#f0fff0">▓▓▓▓▓</span> |
| Silver | #C0C0C0 | <span style="color:#c0c0c0">▓▓▓▓▓</span> |
| MintCream | #F5FFFA | <span style="color:#f5fffa">▓▓▓▓▓</span> |
| DarkGray | #A9A9A9 | <span style="color:#a9a9a9">▓▓▓▓▓</span> |
| Azure | #F0FFFF | <span style="color:#f0ffff">▓▓▓▓▓</span> |
| Gray | #808080 | <span style="color:#808080">▓▓▓▓▓</span> |
| AliceBlue | #F0F8FF | <span style="color:#f0f8ff">▓▓▓▓▓</span> |
| DimGray | #696969 | <span style="color:#696969">▓▓▓▓▓</span> |
| GhostWhite | #F8F8FF | <span style="color:#f8f8ff">▓▓▓▓▓</span> |
| LightSlateGray | #778899 | <span style="color:#778899">▓▓▓▓▓</span> |
| WhiteSmoke | #F5F5F5 | <span style="color:#f5f5f5">▓▓▓▓▓</span> |
| SlateGray | #708090 | <span style="color:#708090">▓▓▓▓▓</span> |
| Seashell | #FFF5EE | <span style="color:#fff5ee">▓▓▓▓▓</span> |
| DarkSlateGray | #2F4F4F | <span style="color:#2f4f4f">▓▓▓▓▓</span> |
| Beige | #F5F5DC | <span style="color:#f5f5dc">▓▓▓▓▓</span> |
| Black | #000000 | <span style="color:#000000">▓▓▓▓▓</span> |
| OldLace | #FDF5E6 | <span style="color:#fdf5e6">▓▓▓▓▓</span> |
| FloralWhite | #FFFAF0 | <span style="color:#fffaf0">▓▓▓▓▓</span> |
| Ivory | #FFFFF0 | <span style="color:#fffff0">▓▓▓▓▓</span> |
| AntiqueWhite | #FAEBD7 | <span style="color:#faebd7">▓▓▓▓▓</span> |
| Linen | #FAF0E6 | <span style="color:#faf0e6">▓▓▓▓▓</span> |
| LavenderBlush | #FFF0F5 | <span style="color:#fff0f5">▓▓▓▓▓</span> |
| MistyRose | #FFE4E1 | <span style="color:#ffe4e1">▓▓▓▓▓</span> |
| SystemGray_Light | #8E8E93 | <span style="color:#8e8e93">▓▓▓▓▓</span> |
| SystemGray_Dark | #8E8E93 | <span style="color:#8e8e93">▓▓▓▓▓</span> |
| SystemGray_LightHC | #6C6C70 | <span style="color:#6c6c70">▓▓▓▓▓</span> |
| SystemGray_DarkHC | #AEAEB2 | <span style="color:#aeaeb2">▓▓▓▓▓</span> |
| SystemGray2_Light | #AEAEB2 | <span style="color:#aeaeb2">▓▓▓▓▓</span> |
| SystemGray2_Dark | #636366 | <span style="color:#636366">▓▓▓▓▓</span> |
| SystemGray2_LightHC | #8E8E93 | <span style="color:#8e8e93">▓▓▓▓▓</span> |
| SystemGray2_DarkHC | #7C7C80 | <span style="color:#7c7c80">▓▓▓▓▓</span> |
| SystemGray3_Light | #C7C7CC | <span style="color:#c7c7cc">▓▓▓▓▓</span> |
| SystemGray3_Dark | #48484A | <span style="color:#48484a">▓▓▓▓▓</span> |
| SystemGray3_LightHC | #AEAEB2 | <span style="color:#aeaeb2">▓▓▓▓▓</span> |
| SystemGray3_DarkHC | #545456 | <span style="color:#545456">▓▓▓▓▓</span> |
| SystemGray4_Light | #D1D1D6 | <span style="color:#d1d1d6">▓▓▓▓▓</span> |
| SystemGray4_Dark | #3A3A3C | <span style="color:#3a3a3c">▓▓▓▓▓</span> |
| SystemGray4_LightHC | #BCBCC0 | <span style="color:#bcbcc0">▓▓▓▓▓</span> |
| SystemGray4_DarkHC | #444446 | <span style="color:#444446">▓▓▓▓▓</span> |
| SystemGray5_Light | #E5E5EA | <span style="color:#e5e5ea">▓▓▓▓▓</span> |
| SystemGray5_Dark | #2C2C2E | <span style="color:#2c2c2e">▓▓▓▓▓</span> |
| SystemGray5_LightHC | #D8D8DC | <span style="color:#d8d8dc">▓▓▓▓▓</span> |
| SystemGray5_DarkHC | #363638 | <span style="color:#363638">▓▓▓▓▓</span> |
| SystemGray6_Light | #F2F2F7 | <span style="color:#f2f2f7">▓▓▓▓▓</span> |
| SystemGray6_Dark | #1C1C1E | <span style="color:#1c1c1e">▓▓▓▓▓</span> |
| SystemGray6_LightHC | #EBEBF0 | <span style="color:#ebebf0">▓▓▓▓▓</span> |
| SystemGray6_DarkHC | #242426 | <span style="color:#242426">▓▓▓▓▓</span> |
| SystemRed_Light | #FF383C | <span style="color:#ff383c">▓▓▓▓▓</span> |
| SystemRed_Dark | #FF4245 | <span style="color:#ff4245">▓▓▓▓▓</span> |
| SystemRed_LightHC | #E9152D | <span style="color:#e9152d">▓▓▓▓▓</span> |
| SystemRed_DarkHC | #FF6165 | <span style="color:#ff6165">▓▓▓▓▓</span> |
| SystemOrange_Light | #FF8D28 | <span style="color:#ff8d28">▓▓▓▓▓</span> |
| SystemOrange_Dark | #FF9230 | <span style="color:#ff9230">▓▓▓▓▓</span> |
| SystemOrange_LightHC | #C55300 | <span style="color:#c55300">▓▓▓▓▓</span> |
| SystemOrange_DarkHC | #FFA056 | <span style="color:#ffa056">▓▓▓▓▓</span> |
| SystemYellow_Light | #FFCC00 | <span style="color:#ffcc00">▓▓▓▓▓</span> |
| SystemYellow_Dark | #FFD600 | <span style="color:#ffd600">▓▓▓▓▓</span> |
| SystemYellow_LightHC | #A16A00 | <span style="color:#a16a00">▓▓▓▓▓</span> |
| SystemYellow_DarkHC | #FEDF43 | <span style="color:#fedf43">▓▓▓▓▓</span> |
| SystemGreen_Light | #34C759 | <span style="color:#34c759">▓▓▓▓▓</span> |
| SystemGreen_Dark | #30D158 | <span style="color:#30d158">▓▓▓▓▓</span> |
| SystemGreen_LightHC | #008932 | <span style="color:#008932">▓▓▓▓▓</span> |
| SystemGreen_DarkHC | #4AD968 | <span style="color:#4ad968">▓▓▓▓▓</span> |
| SystemMint_Light | #00C8B3 | <span style="color:#00c8b3">▓▓▓▓▓</span> |
| SystemMint_Dark | #00DAC3 | <span style="color:#00dac3">▓▓▓▓▓</span> |
| SystemMint_LightHC | #008575 | <span style="color:#008575">▓▓▓▓▓</span> |
| SystemMint_DarkHC | #54DFCB | <span style="color:#54dfcb">▓▓▓▓▓</span> |
| SystemTeal_Light | #00C3D0 | <span style="color:#00c3d0">▓▓▓▓▓</span> |
| SystemTeal_Dark | #00D2E0 | <span style="color:#00d2e0">▓▓▓▓▓</span> |
| SystemTeal_LightHC | #008198 | <span style="color:#008198">▓▓▓▓▓</span> |
| SystemTeal_DarkHC | #3BDDEC | <span style="color:#3bddec">▓▓▓▓▓</span> |
| SystemCyan_Light | #00C0E8 | <span style="color:#00c0e8">▓▓▓▓▓</span> |
| SystemCyan_Dark | #3CD3FE | <span style="color:#3cd3fe">▓▓▓▓▓</span> |
| SystemCyan_LightHC | #007EAE | <span style="color:#007eae">▓▓▓▓▓</span> |
| SystemCyan_DarkHC | #6DD9FF | <span style="color:#6dd9ff">▓▓▓▓▓</span> |
| SystemBlue_Light | #0088FF | <span style="color:#0088ff">▓▓▓▓▓</span> |
| SystemBlue_Dark | #0091FF | <span style="color:#0091ff">▓▓▓▓▓</span> |
| SystemBlue_LightHC | #1E6EF4 | <span style="color:#1e6ef4">▓▓▓▓▓</span> |
| SystemBlue_DarkHC | #5CB8FF | <span style="color:#5cb8ff">▓▓▓▓▓</span> |
| SystemIndigo_Light | #6155F5 | <span style="color:#6155f5">▓▓▓▓▓</span> |
| SystemIndigo_Dark | #6D7CFF | <span style="color:#6d7cff">▓▓▓▓▓</span> |
| SystemIndigo_LightHC | #564ADE | <span style="color:#564ade">▓▓▓▓▓</span> |
| SystemIndigo_DarkHC | #A7AAFF | <span style="color:#a7aaff">▓▓▓▓▓</span> |
| SystemPurple_Light | #CB30E0 | <span style="color:#cb30e0">▓▓▓▓▓</span> |
| SystemPurple_Dark | #DB34F2 | <span style="color:#db34f2">▓▓▓▓▓</span> |
| SystemPurple_LightHC | #B02FC2 | <span style="color:#b02fc2">▓▓▓▓▓</span> |
| SystemPurple_DarkHC | #EA8DFF | <span style="color:#ea8dff">▓▓▓▓▓</span> |
| SystemPink_Light | #FF2D55 | <span style="color:#ff2d55">▓▓▓▓▓</span> |
| SystemPink_Dark | #FF375F | <span style="color:#ff375f">▓▓▓▓▓</span> |
| SystemPink_LightHC | #E7124D | <span style="color:#e7124d">▓▓▓▓▓</span> |
| SystemPink_DarkHC | #FF8AC4 | <span style="color:#ff8ac4">▓▓▓▓▓</span> |
| SystemBrown_Light | #AC7F5E | <span style="color:#ac7f5e">▓▓▓▓▓</span> |
| SystemBrown_Dark | #B78A66 | <span style="color:#b78a66">▓▓▓▓▓</span> |
| SystemBrown_LightHC | #956D51 | <span style="color:#956d51">▓▓▓▓▓</span> |
| SystemBrown_DarkHC | #DBA679 | <span style="color:#dba679">▓▓▓▓▓</span> |

## The ConsoleColor24 Class

The core of PSRainbow is the `ConsoleColor24` class, which represents a single 24-bit RGB color:

```powershell
class ConsoleColor24 {
    [ValidateRange(0, 255)][Int]$Red
    [ValidateRange(0, 255)][Int]$Green
    [ValidateRange(0, 255)][Int]$Blue
}
```

The class provides multiple constructors:
- `ConsoleColor24()` - Creates black (0, 0, 0)
- `ConsoleColor24(Int, Int, Int)` - RGB values
- `ConsoleColor24(Int)` - Hexadecimal value
- `ConsoleColor24(ConsoleColor24)` - Copy constructor

## Examples

### Rainbow Text

```powershell
$colors = @('Red', 'Orange', 'Yellow', 'Green', 'Cyan', 'Blue', 'Magenta')
$text = "Rainbow!"

$output = ""
for ($i = 0; $i -lt $text.Length; $i++) {
    $color = $PSRainbowColors[$colors[$i % $colors.Count]]
    $seq = Format-ConsoleColor24 -Color $color -Type Fg
    $output += "${seq}$($text[$i])"
}
Write-Host $output
```

### Colorful Progress Bar

```powershell
for ($i = 0; $i -le 100; $i += 10) {
    $hue = $i / 100 * 360
    # Create RGB from hue (simplified)
    $color = New-ConsoleColor24 -Red ($i * 2.55) -Green (100 - $i) -Blue 128
    $seq = Format-ConsoleColor24 -Color $color -Type Fg
    Write-Host "${seq}[$('█' * ($i / 5))]$($i)%"
}
```

### Styled Output

```powershell
$success = $PSRainbowColors.LimeGreen
$warning = $PSRainbowColors.Orange
$error = $PSRainbowColors.Red

$successSeq = Format-ConsoleColor24 -Color $success -Type Fg
$warningSeq = Format-ConsoleColor24 -Color $warning -Type Fg
$errorSeq = Format-ConsoleColor24 -Color $error -Type Fg

Write-Host "${successSeq}✓ Operation completed successfully"
Write-Host "${warningSeq}⚠ This is a warning"
Write-Host "${errorSeq}✗ An error occurred"
```

## Compatibility

- **PowerShell Versions**: 5.1+ (Desktop) and 7.0+ (Core)
- **Operating Systems**: Windows, Linux, macOS
- **Terminal Support**: Works with any terminal that supports ANSI escape sequences:
  - Windows Terminal (recommended)
  - VS Code integrated terminal
  - ConEmu
  - And many others

## How It Works

PSRainbow generates ANSI escape sequences following the SGR (Select Graphic Rendition) standard:

- **Foreground Color**: `ESC[38;2;R;G;Bm`
- **Background Color**: `ESC[48;2;R;G;Bm`

Where R, G, and B are decimal values from 0-255.

The module automatically handles the differences between PowerShell Desktop (which requires constructing the escape character) and PowerShell Core (which supports the `` `e `` escape sequence).

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

Created by Gregory F Martin (Not Gary)

## Contributing

Contributions are welcome! Feel free to submit pull requests or open issues for bugs and feature requests.
