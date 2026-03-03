[CmdletBinding()]
param 
(
	# Path to the executable to debug relative to the given target directory
	# e.g. bin\level_editor.exe
	[Parameter(Mandatory=$true)]
	[string]$TargetFileName,

	[Parameter(Mandatory=$false)]
	[string]$TargetArguments,


	# One of these two parameters must be set

	# The directory where the debug executable lives. If not set, uses $SteamAppId to look up the install directory
	# e.g. D:\dev\game
	[Parameter(Mandatory=$false)]
	[string]$TargetDir,
	
	# The Steam App Id to use for the Target Directory. If not set, uses $TargetDir
	# e.g. for Swarm, use 630
	[Parameter(Mandatory=$false)]
	[int]$SteamAppId
)

$ScriptPath = split-path -parent $MyInvocation.MyCommand.Definition

Write-Debug("TargetFileName=$($TargetFileName)")
Write-Debug("TargetDir=$($TargetDir)")
Write-Debug("SteamAppId=$($SteamAppId)")

#$SteamAppId = 630

# Did we get the App Id?
if ( $SteamAppId )
{
	$SteamAppInstallDir = $null

	# First, we need to find Steam's install path
	$SteamPath = Get-ItemProperty -Path "HKCU:\SOFTWARE\Valve\Steam" -Name "SteamPath"
	$SteamPath = [IO.Path]::GetFullPath($SteamPath.SteamPath)
	
	# Now let's go see where our library folders live. 
	# These are kept in "libraryfolders.vdf" in Steam's main SteamApps directory.
	$SteamLibraryFoldersPath = Join-Path -Path $SteamPath -ChildPath "SteamApps"
	$SteamLibraryFoldersPath = Join-Path -Path $SteamLibraryFoldersPath -ChildPath "libraryfolders.vdf"
	$SteamLibraryFoldersPath = [IO.Path]::GetFullPath($SteamLibraryFoldersPath)

	$SteamLibraryPaths = @()

	$key = "`"path`""
	foreach ( $line in Get-Content $SteamLibraryFoldersPath )
	{
		$line = $line.Trim()
		#Write-Output($line)
		if ( $line.StartsWith($key) )
		{
			$value = $line.Substring($line.IndexOf($key) + $key.Length, $line.Length-$key.Length).Trim()
			if ( ($value[0] -eq "`"") -and ($value[$value.Length-1] -eq "`"") )
			{
				$value = $value.Substring( 1, $value.Length-2 )
			}
			
			$SteamLibraryPaths += $value
		}
	}

	# Now look for the app manifest in each library path
	foreach ( $library in $SteamLibraryPaths )
	{
		$appManifestName = "appmanifest_$($SteamAppId).acf"
		$appManifestPath = Join-Path -Path $library -ChildPath "SteamApps"
		$appManifestPath = Join-Path -Path $appManifestPath -ChildPath $appManifestName

		$key = "`"installdir`""
		$value = $null

		# Does this library have it?
		if ( [IO.File]::Exists($appManifestPath) )
		{
			# Read the "installdir" key from the manifest
			foreach ( $line in Get-Content $appManifestPath )
			{
				$line = $line.Trim()
				if ( $line.StartsWith($key) )
				{
					$value = $line.Substring($line.IndexOf($key) + $key.Length, $line.Length-$key.Length).Trim()
					if ( ($value[0] -eq "`"") -and ($value[$value.Length-1] -eq "`"") )
					{
						$value = $value.Substring( 1, $value.Length-2 )
					}
				}
			}

			if ( $value )
			{
				# Now that we know the install dir we can go into that directory relative to the library we found it in.
				$SteamAppInstallDir = Join-Path -Path $library -ChildPath "SteamApps"
				$SteamAppInstallDir = Join-Path -Path $SteamAppInstallDir -ChildPath "common"
				$SteamAppInstallDir = Join-Path -Path $SteamAppInstallDir -ChildPath $value
				$SteamAppInstallDir = [IO.Path]::GetFullPath($SteamAppInstallDir)

				if ( [IO.Directory]::Exists($SteamAppInstallDir) )
				{
					Write-Output("SteamAppInstallDir=$($SteamAppInstallDir)")
					# Now combine this path with our TargetFileName
					$ExecutablePath = Join-Path -Path $SteamAppInstallDir -ChildPath $TargetFileName
					Write-Output("ExecutablePath=$($ExecutablePath)")
					$process = $null

					if ( $TargetArguments )
						{ $process = Start-Process -FilePath $ExecutablePath -PassThru -ArgumentList $TargetArguments }
					else
						{ $process = Start-Process -FilePath $ExecutablePath -PassThru }

					# We might already have a debugger, don't debug again if we do
					if ( -not [System.Diagnostics.Debugger].IsAttached ) { Debug-Process -Id $process.Id }
				}

				break
			}
		}
	}
}
elseif ( $TargetDir )
{
	$ExecutablePath = Join-Path -Path $TargetDir -ChildPath $TargetFileName
	Write-Output("ExecutablePath=$($ExecutablePath)")
	$process = $null

	if ( $TargetArguments )
		{ $process = Start-Process -FilePath $ExecutablePath -PassThru -ArgumentList $TargetArguments }
	else
		{ $process = Start-Process -FilePath $ExecutablePath -PassThru }
	# We might already have a debugger, don't debug again if we do
	if ( -not [System.Diagnostics.Debugger].IsAttached ) { Debug-Process -Id $process.Id }
}
else
{
	Write-Error("Must set either `$SteamAppId or `$TargetDir")
	exit 1
}

exit 0