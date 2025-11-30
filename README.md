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
