[CmdletBinding()]
param 
(
	[Parameter(Mandatory=$true)]
	[string]$TargetDir,		# $(TargetDir) in VS

	[Parameter(Mandatory=$true)]
	[string]$TargetFileName # $(TargetFileName) in VS
)

$ScriptPath = split-path -parent $MyInvocation.MyCommand.Definition

Write-Debug "TargetDir=$($TargetDir)"
Write-Debug "TargetFileName=$($TargetFileName)"

Write-Debug "ScriptPath=$($ScriptPath)"

$TargetDir = [IO.Path]::GetFullPath($TargetDir)
$GameBin = [IO.Path]::GetFullPath([IO.Path]::Combine((Get-Item $ScriptPath).FullName, "..", "game", "bin"))


# See if we need to create game\bin first
if ( !(Test-Path -Path $GameBin) )
{
	New-Item -ItemType Directory -Path $GameBin
}

$BinName = [IO.Path]::GetFileNameWithoutExtension($TargetFileName)
Write-Debug "BinName=$($BinName)"

# Copy the binary
$BinTarget = [IO.Path]::Combine( $TargetDir, $TargetFileName )
$BinDest = [IO.Path]::Combine( $GameBin, $TargetFileName )
if ( !(Test-Path -Path $BinTarget) ) { Write-Error "$($BinTarget)) does not exist on disk!"; exit 1 }

Copy-Item -Path $BinTarget -Destination $BinDest
if(-not $?) 
{
	Write-Error "Failed copying binary $($TargetFileName) to $($GameBin)"
	exit 1
}

$PdbTarget = [IO.Path]::Combine($TargetDir, $BinName + ".pdb")
Write-Debug "PdbTarget=$($PdbTarget)"
# See if it's got a PDB with it
if ( Test-Path -Path $PdbTarget )
{
	Copy-Item -Path $PdbTarget -Destination ([IO.Path]::Combine( $GameBin, $BinName + ".pdb") )
	if(-not $?) 
	{
		Write-Error "Failed copying debug database $($PdbTarget) to $($GameBin)"
		exit 1
	}
}
else
{
	Write-Warning "Couldn't find debug database $($PdbTarget)"
}

exit 0