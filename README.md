# PSRainbow

A PowerShell module that _accelerates_ the use of 24-bit true color for console output.

## Features

- **24-bit True Color Support**: Use any color in RGB space. Supports a wealth of named colors, client-defined channel values, or client-defined hexadecimal literals (formatted `0xFFFFFF`; does not support string formatted hexadecimal common in HTML (`#FFFFFF`)).
- **Named Color Library**: 250+ pre-defined colors including system colors, web colors, and UI colors.
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
$FgSeq = Format-ConsoleColor24 -Color $Red -Type Fg

# FORMAT A COLOR FOR BACKGROUND OUTPUT
$BgSeq = Format-ConsoleColor24 -Color $Blue -Type Bg

# USE WITH WRITE-HOST
Write-Host "$(FgSeq)This text is red"
Write-Host "$(BgSeq)This has a blue background"
```

## Available Cmdlets

### `New-ConsoleColor24`

Creates a new `ConsoleColor24` object representing a 24-bit color.

**Parameter Sets:**
- `-Red <Int>` `-Green <Int>` `-Blue <Int>` - Specify RGB channels (0-255)
- `-Hex <Int>` - Specify as hexadecimal value (0xRRGGBB)
- `-CopyFrom <ConsoleColor24>` - Copy an existing color object

**Example:**
```powershell
$Crimson = New-ConsoleColor24 -Red 220 -Green 20 -Blue 60
$Lime    = New-ConsoleColor24 -Hex 0x00FF00
```

### `Format-ConsoleColor24`

Converts a `ConsoleColor24` object into an ANSI escape sequence for console output.

**Parameters:**
- `-Color <ConsoleColor24>` - The color to format
- `-Type <String>` - Either 'Fg' (foreground) or 'Bg' (background); this is case-insensitive

**Example:**
```powershell
$Color = New-ConsoleColor24 -Hex 0xFF6347
$Ansi  = Format-ConsoleColor24 -Color $Color -Type Fg
```

### `fColor` and `bColor`

As was mentioned a few times now, PSRainbow offers over 200 named colors. These colors are defined, first, as hexadecimal literals, then translated into `ConsoleColor24` instances when the module is loaded, which are then exposed to your PowerShell session via a global variable (discussed later). While this is quite a convenience itself, PSRainbow offers another olive branch through what I call _interpolation accelerators_. Each named color has a corresponding `f` and `b` function which will produce as a result either an ANSI foreground or background color SGR sequence that you can interpolate into strings. This saves the user from having to interpolate via subexpression a function call to `Format-ConsoleColor24`.

For example, an earlier snippet showed how you could use the `Format-ConsoleColor24` function to create a red and blue foreground and background color respectively:

```powershell
# FORMAT A COLOR FOR FOREGROUND OUTPUT
$FgSeq = Format-ConsoleColor24 -Color $Red -Type Fg

# FORMAT A COLOR FOR BACKGROUND OUTPUT
$BgSeq = Format-ConsoleColor24 -Color $Blue -Type Bg

# USE WITH WRITE-HOST
Write-Host "$(FgSeq)This text is red"
Write-Host "$(BgSeq)This has a blue background"
```

Using `fColor` and `bColor` accelerators, this can be simplifed:

```powershell
Write-Host "$(fRed)This text is red"
Write-Host "$(bBlue)This has a blue background
```

Consequently, you can combine multiple accelerators in a single interpolation:

```powershell
Write-Host "$(fRed)This $(fGreen)is $(fYellow)some $(fOrange)wacky $(fCrimson)text."
```

### The `AR` Interpolation Accelerator

While not strictly a color-specific function, the `AR` accelerator (_**A**ll **R**eset_) provides a means of interpolating an ANSI SGR Reset sequence. This allows for stopping modifiers in discrete ways. So you can use the previous example and just color the background of the text you want rather than it running until another background accelerator occurs:

```powershell
Write-Host "$(bRed)This $(ar)$(bGreen)is $(ar)$(bYellow)some $(ar)$(fOrange)wacky $(fCrimson)text."
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
Class ConsoleColor24 {
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

## Compatibility

- **PowerShell Versions**: 5.1+ (Desktop) and 7.0+ (Core)
- **Operating Systems**: Windows, Linux, macOS
- **Terminal Support**: Works with any terminal that supports ANSI escape sequences:
  - Windows Terminal (recommended)
  - VS Code Integrated Terminal

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
