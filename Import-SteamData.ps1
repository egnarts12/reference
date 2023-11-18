# Returns object or JSON from Steam acf/vdf file
function Import-SteamData {
    param(
        [Parameter(Mandatory = $true)][string]$Path,
        [switch]$ReturnJSON
    )
    $Data = Get-Content $Path

    # Rather than write a full parser, this attempts to make parsable JSON from the existing file
    # Add missing opening and closing brackets
    if ($Data[0] -notlike "{*") {
        $Data[0] = "{$($Data[0])"
        $Data[-1] = "$($Data[-1])}"
    }
    [int]$LineNumber = 0
    foreach ($Line in $Data) {
        if ($LineNumber -eq $Data.Length - 1) {
            break
        }
        # Add colon if the next line is an opening bracket
        if (($Data[$LineNumber + 1].Trim())[0] -eq '{') {
            $Data[$LineNumber] = "$($Data[$LineNumber]):"
        }
        # Add colons to key/value pairs
        $DoubleQuoteCount = ($Line.ToCharArray() | Where-Object { $_ -eq '"' } | Measure-Object).Count
        if ($DoubleQuoteCount -ge 4) {
            [int]$EndOfKey = $Data[$LineNumber].Trim().IndexOf("`t")
            $Data[$LineNumber] = $Data[$LineNumber].Trim().Insert($EndOfKey, ':')
        }
        # Add commas
        if ($Data[$LineNumber + 1].Trim()[0] -eq '"' -and $Data[$LineNumber].Trim() -ne '{') {
            $Data[$LineNumber] = "$($Data[$LineNumber]),"
        }
        $LineNumber++
    }

    $Object = $Data | ConvertFrom-Json
    if ($ReturnJSON){
        # If returning JSON, convert object back to JSON because original formatting was destroyed
        return $Object | ConvertTo-Json
    } else {
        return $Object
    }
}
