# PSRainbow AI Agent Instructions

## Project Overview

PSRainbow is a PowerShell module providing 24-bit true color (16.7 million colors) ANSI escape sequence support for console output. It abstracts RGB color handling into a reusable `ConsoleColor24` class and provides cmdlets for color creation and ANSI formatting.

**Core purpose**: Enable vibrant, pixel-perfect console output across Windows, Linux, and macOS terminals.

## Architecture Overview

The module has a minimal, focused structure:

1. **Classes/ConsoleColor24.ps1** - Core class defining the 24-bit color object and two public functions
   - `ConsoleColor24` class: RGB property validation (0-255 each) with 4 constructors (default, RGB channels, hex int, copy)
   - `New-ConsoleColor24`: Factory function supporting 3 parameter sets (ChannelSpec, ChannelHex, ColorCopy)
   - `Format-ConsoleColor24`: Converts color to ANSI escape sequence, handling PowerShell Desktop vs Core escape syntax

2. **Public/NamedColorData.psd1** - 250+ pre-defined colors (web colors, system colors)
   - Stored as hex integers (0xRRGGBB format) in a PowerShell data file

3. **PSRainbow.psm1** - Module initialization
   - Loads ConsoleColor24 class definition
   - Imports NamedColorData and converts hex values to ConsoleColor24 objects
   - Exports `$PSRainbowColors` hashtable and the two public functions

## Key Architectural Decisions

- **Minimal Surface**: Only 2 public functions + 1 exported variable. Design emphasizes simplicity over feature richness.
- **Edition Compatibility**: `Format-ConsoleColor24` detects `$PSVersionTable.PSEdition` to emit correct escape syntax:
  - Desktop: Constructs escape char via `[Char]0x1B`
  - Core: Uses backtick escape `` `e ``
- **Data-Driven Colors**: Named colors are immutable, defined in a .psd1 file for easy expansion without code changes
- **Single Responsibility**: ConsoleColor24 represents data; cmdlets handle creation and formatting—no string manipulation in the class itself

## Development Patterns & Conventions

### PowerShell Specifics
- **Strict Mode**: `Set-StrictMode -Version Latest` enabled in .psm1
- **Parameter Validation**: Use `[ValidateRange(0, 255)]` for RGB channels, `[ValidateSet('Bg', 'Fg')]` for escape type
- **Parameter Sets**: Multi-use functions (like `New-ConsoleColor24`) use named parameter sets to clarify intent
- **Script Scope**: Use `$PSScriptRoot` for relative file paths (see PSRainbow.psm1 line 3)

### Class Design
- **Value Types**: ConsoleColor24 holds only immutable properties (Red, Green, Blue). No methods beyond constructors.
- **Constructors**: Overloading supports RGB triple, hex int, and copy—examine ConsoleColor24.ps1 lines 10-39 for pattern
- **Validation**: Property-level `[ValidateRange]` prevents invalid values at instantiation

### Cmdlet Structure
- Use `[CmdletBinding(DefaultParameterSetName = '...')]` to manage parameter set routing
- Process block handles all logic; rely on automatic parameter binding
- Return early with `Return [TypeName]::new(...)` rather than assigning to variables

### ANSI Escape Generation
Format strings follow SGR (Select Graphic Rendition) standard:
- **Foreground**: `[Char]0x1B[38;2;R;G;Bm` (Desktop) or `` `e[38;2;R;G;Bm `` (Core)
- **Background**: `[Char]0x1B[48;2;R;G;Bm` (Desktop) or `` `e[48;2;R;G;Bm `` (Core)

See Format-ConsoleColor24 lines 136-186 in Classes/ConsoleColor24.ps1 for the pattern.

## Common Development Tasks

### Adding a New Named Color
1. Add entry to Public/NamedColorData.psd1 in hex format (e.g., `"LimeGreen" = 0x32CD32`)
2. No code changes needed—the .psd1 import loop in PSRainbow.psm1 (lines 5-7) auto-converts

### Creating a Color in Code
```powershell
# RGB channels (most explicit)
$crimson = New-ConsoleColor24 -Red 220 -Green 20 -Blue 60

# Hex value (compact)
$lime = New-ConsoleColor24 -Hex 0x32CD32

# Predefined color
$red = $PSRainbowColors.Red
```

### Applying Color to Text
```powershell
$color = New-ConsoleColor24 -Hex 0xFF6347
$fgSeq = Format-ConsoleColor24 -Color $color -Type Fg
Write-Host "${fgSeq}This is tomato red"
```

## Testing & Validation

- **Manual testing**: Import module and test cmdlets in PowerShell console
- **Environment check**: Verify terminal supports ANSI escape sequences (Windows Terminal, VS Code, modern *nix terminals)
- **Edition testing**: Test on both PowerShell Desktop (5.1+) and Core (7.0+) to validate escape sequence generation
- **Color validation**: RGB values are validated at instantiation; invalid values (>255 or <0) throw terminating error

## Cross-Component Communication

The module is self-contained with no external dependencies:
- Class and functions are defined in a single file (Classes/ConsoleColor24.ps1)
- NamedColorData is import-only; no bidirectional references
- The exported `$PSRainbowColors` hashtable is the sole public interface for predefined colors

## Important File Locations

| File | Purpose |
|------|---------|
| Classes/ConsoleColor24.ps1 | Core class definition + 2 public functions |
| Public/NamedColorData.psd1 | 250+ color definitions (hex format) |
| PSRainbow.psm1 | Module entry point; loads class and colors |
| PSRainbow.psd1 | Module manifest; declares exports |
| README.md | User documentation and usage examples |
