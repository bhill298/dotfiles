# can get through $profile (default %USERPROFILE%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1)
Set-PSReadLineKeyHandler -Chord Ctrl-a -Function BeginningOfLine
Set-PSReadLineKeyHandler -Chord Ctrl-e -Function EndOfLine
Set-PSReadLineKeyHandler -Chord Ctrl+u -Function BackwardDeleteLine
Set-PSReadLineKeyHandler -Chord Ctrl+k -Function ForwardDeleteLine

# source: https://github.com/majkinetor/posh/blob/master/MM_Admin/Invoke-Environment.ps1
function Invoke-Environment {
    param
    (
        # Any cmd shell command, normally a configuration batch file.
        [Parameter(Mandatory=$true)]
        [string] $Command
    )

    $Command = "`"" + $Command + "`""
    cmd /c "$Command > nul 2>&1 && set" | . { process {
        if ($_ -match '^([^=]+)=(.*)') {
            [System.Environment]::SetEnvironmentVariable($matches[1], $matches[2])
        }
    }}

}

# vcvars32.bat vcvars64.bat needs to be on path
# e.g. C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\
function vcvars { Invoke-Environment  $((get-command vcvars64.bat).Path) }
function vcvars32 { Invoke-Environment  $((get-command vcvars32.bat).Path) }
function dh { Set-PSReadlineOption -HistorySaveStyle SaveNothing }
function StopSound { (New-Object Media.SoundPlayer).Stop() }
