function Get-PksCluster {
    <#
.SYNOPSIS
        This function will get all the provisioned PKS clusters using the CLI tool and return them as PS Objects. Minimum supported version of PKS API server is v1.5.
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
        if ($Line.Length -ne 0 -and $Line -notmatch "PKS\s+Version") {
            $fields = $Line.Trim(' ') -split '\s+'
            $properties = @{
                PKSVersion = $fields[0]
                Name   = $fields[1]
                K8sVersion = $fields[2]
                Plan   = $fields[3]
                UUID   = $fields[4]
                Status = $fields[5]
                Action = $fields[6]
            }
            New-Object -TypeName PSObject -Property $properties
        }
    }
}
