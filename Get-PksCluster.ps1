function Get-PksCluster {
    <#
.SYNOPSIS
        This function will get all the provisioned PKS clusters using the CLI tool and return them as PS Objects.
.DESCRIPTION
        This function will get the output of `pks clusters` and parse the output.
.LINK
        http://github.com/chipzoller/Get-PksCluster
.NOTES
        Chip Zoller
        @chipzoller
#>
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true)]
        [string]$Line
    )

    Process {
        if ($Line -match "error") {
            throw "error"
        }
        if ($Line.Length -ne 0 -and $Line -notmatch "Name\s+Plan") {
            $fields = $Line.Trim(' ') -split '\s+'
            $properties = @{
                Name   = $fields[0]
                Plan   = $fields[1]
                UUID   = $fields[2]
                Status = $fields[3]
                Action = $fields[4]
            }
            New-Object -TypeName PSObject -Property $properties
        }
    }
}
