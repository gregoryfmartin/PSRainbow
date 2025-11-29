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

    [String]ToAnsiForegroundString() {
        Return "`e[38;2;$($this.Red);$($this.Green);$($this.Blue)m"
    }

    [String]ToAnsiBackgroundString() {
        Return "`e[48;2;$($this.Red);$($this.Green);$($this.Blue)m"
    }
}

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
