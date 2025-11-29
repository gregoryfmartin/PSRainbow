using namespace System

Set-StrictMode -Version Latest

Class ConsoleColor24 {
    [ValidateRange(0, 255)][Int]$Red
    [ValidateRange(0, 255)][Int]$Green
    [ValidateRange(0, 255)][Int]$Blue

    ConsoleColor24() {
        $this.Red   = 0
        $this.Green = 0
        $this.Blue  = 0
    }

    ConsoleColor24(
        [Int]$Red,
        [Int]$Green,
        [Int]$Blue
    ) {
        $this.Red   = $Red
        $this.Green = $Green
        $this.Blue  = $Blue
    }
    
    ConsoleColor24(
        [Int32]$Hex
    ) {
        $this.Red   = ($Hex -SHR 16) -BAND 0xFF
        $this.Green = ($Hex -SHR 8) -BAND 0xFF
        $this.Blue  = $Hex -BAND 0xFF
    }

    ConsoleColor24(
        [ConsoleColor24]$CopyFrom
    ) {
        $this.Red   = $CopyFrom.Red
        $this.Green = $CopyFrom.Green
        $this.Blue  = $CopyFrom.Blue
    }
}

<#
.SYNOPSIS
Creates a new ConsoleColor24 object for 24-bit true color console output.

.DESCRIPTION
The New-ConsoleColor24 function creates a ConsoleColor24 object that represents a color using 24-bit RGB values. This allows for true color output in modern console environments.

The function supports three different parameter sets:
- ChannelSpec: Specify RGB channels as separate values (0-255 each)
- ChannelHex: Specify color as a 32-bit hexadecimal value
- ColorCopy: Create a copy of an existing ConsoleColor24 object

.PARAMETER Red
The red channel value (0-255). Used with ChannelSpec parameter set.

.PARAMETER Green
The green channel value (0-255). Used with ChannelSpec parameter set.

.PARAMETER Blue
The blue channel value (0-255). Used with ChannelSpec parameter set.

.PARAMETER Hex
A 24-bit hexadecimal integer value representing the color (0xRRGGBB). Used with ChannelHex parameter set.

.PARAMETER CopyFrom
An existing ConsoleColor24 object to copy. Used with ColorCopy parameter set.

.EXAMPLE
# Create a red color using RGB channels
$red = New-ConsoleColor24 -Red 255 -Green 0 -Blue 0

.EXAMPLE
# Create a blue color using hexadecimal value
$blue = New-ConsoleColor24 -Hex 0x0000FF

.EXAMPLE
# Create a copy of an existing color
$colorCopy = New-ConsoleColor24 -CopyFrom $red

.OUTPUTS
ConsoleColor24
Returns a new ConsoleColor24 object representing the specified color.

.NOTES
The RGB values are internally validated to ensure they are within the 0-255 range.
#>
Function New-ConsoleColor24 {
    [CmdletBinding(DefaultParameterSetName = 'ChannelSpec')]
    Param(
        [Parameter(ParameterSetName = 'ChannelSpec', Position = 0)]
        [ValidateRange(0, 255)]
        [Int]$Red,

        [Parameter(ParameterSetName = 'ChannelSpec', Position = 1)]
        [ValidateRange(0, 255)]
        [Int]$Green,

        [Parameter(ParameterSetName = 'ChannelSpec', Position = 2)]
        [ValidateRange(0, 255)]
        [Int]$Blue,

        [Parameter(ParameterSetName = 'ChannelHex')]
        [Int]$Hex,

        [Parameter(ParameterSetName = 'ColorCopy')]
        [ConsoleColor24]$CopyFrom
    )

    Process {
        Switch($PSCmdlet.ParameterSetName) {
            'ChannelSpec' {
                Return [ConsoleColor24]::new($Red, $Green, $Blue)
            }

            'ChannelHex' {
                Return [ConsoleColor24]::new($Hex)
            }

            'ColorCopy' {
                Return [ConsoleColor24]::new($CopyFrom)
            }

            Default {
                Return [ConsoleColor24]::new(0, 0, 0)
            }
        }
    }
}


<#
.SYNOPSIS
Formats a ConsoleColor24 object into an ANSI escape sequence for console output.

.DESCRIPTION
The Format-ConsoleColor24 function converts a ConsoleColor24 object into an ANSI escape sequence string that can be used to set either foreground or background colors in compatible console environments.

The function automatically detects the PowerShell edition (Desktop or Core) and generates the appropriate escape sequence format. On Desktop editions, it constructs the escape character explicitly, while on Core editions it uses the backtick-escape syntax.

.PARAMETER Color
The ConsoleColor24 object to format. This parameter accepts the color object that will be converted to an ANSI escape sequence.

.PARAMETER Type
Specifies whether to format the color for background (Bg) or foreground (Fg) output.
- 'Bg': Generates a background color escape sequence (CSI 48;2)
- 'Fg': Generates a foreground color escape sequence (CSI 38;2)

This value is case-insensitive.

.EXAMPLE
# Create a red color and format it for foreground output
$red = New-ConsoleColor24 -Red 255 -Green 0 -Blue 0
$escapeSeq = Format-ConsoleColor24 -Color $red -Type 'Fg'
Write-Host "This is red text$($escapeSeq)and this is red"

.EXAMPLE
# Create a blue color and format it for background output
$blue = New-ConsoleColor24 -Hex 0x0000FF
$bgSeq = Format-ConsoleColor24 -Color $blue -Type 'Bg'
Write-Host "${bgSeq}This has a blue background"

.OUTPUTS
String
Returns an ANSI escape sequence string in the format:
- Foreground: `e[38;2;R;G;Bm (e.g., `e[38;2;255;0;0m for red)
- Background: `e[48;2;R;G;Bm (e.g., `e[48;2;0;0;255m for blue)

.NOTES
This function is typically used in conjunction with Write-Host or other output functions to apply true color to console text.

The output escape sequences are compatible with:
- PowerShell 7+ (Core edition)
- PowerShell 5.1+ (Desktop edition) on Windows 10/11 or with VT100 emulation enabled
- Compatible terminal applications (Windows Terminal, VS Code, etc.)

The ANSI escape sequences follow the SGR (Select Graphic Rendition) standard.
#>
Function Format-ConsoleColor24 {
    Param(
        [Parameter(Mandatory, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [ConsoleColor24]$Color,

        [Parameter(Mandatory, Position = 1)]
        [ValidateSet('Bg', 'Fg')]
        [String]$Type
    )

    Process {
        [String]$Final = ''

        Switch($Type) {
            'Bg' {
                Switch($PSVersionTable.PSEdition) {
                    'Desktop' {
                        [Char]$Esc = [Char]0x1B

                        $Final = "$($Esc)[48;2;$($Color.Red);$($Color.Green);$($Color.Blue)m"
                    }

                    'Core' {
                        $Final = "`e[48;2;$($Color.Red);$($Color.Green);$($Color.Blue)m"
                    }

                    Default {
                        $Final = "`e[48;2;$($Color.Red);$($Color.Green);$($Color.Blue)m"
                    }
                }
            }

            'Fg' {
                Switch($PSVersionTable.PSEdition) {
                    'Desktop' {
                        [Char]$Esc = [Char]0x1B

                        $Final = "$($Esc)[38;2;$($Color.Red);$($Color.Green);$($Color.Blue)m"
                    }

                    'Core' {
                        $Final = "`e[38;2;$($Color.Red);$($Color.Green);$($Color.Blue)m"
                    }

                    Default {
                        $Final = "`e[38;2;$($Color.Red);$($Color.Green);$($Color.Blue)m"
                    }
                }
            }

            Default {
                Switch($PSVersionTable.PSEdition) {
                    'Desktop' {
                        [Char]$Esc = [Char]0x1B

                        $Final = "$($Esc)[38;2;$($Color.Red);$($Color.Green);$($Color.Blue)m"
                    }

                    'Core' {
                        $Final = "`e[38;2;$($Color.Red);$($Color.Green);$($Color.Blue)m"
                    }

                    Default {
                        $Final = "`e[38;2;$($Color.Red);$($Color.Green);$($Color.Blue)m"
                    }
                }
            }
        }

        Return $Final
    }
}
