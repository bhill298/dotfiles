# can get through $profile (default %USERPROFILE%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1)
Set-PSReadLineKeyHandler -Chord Ctrl-a -Function BeginningOfLine
Set-PSReadLineKeyHandler -Chord Ctrl-e -Function EndOfLine
Set-PSReadLineKeyHandler -Chord Ctrl+u -Function BackwardDeleteLine
Set-PSReadLineKeyHandler -Chord Ctrl+k -Function ForwardDeleteLine                                                                        

function dh { Set-PSReadlineOption -HistorySaveStyle SaveNothing }
function StopSound { (New-Object Media.SoundPlayer).Stop() }
