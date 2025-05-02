# can get through $profile (default %USERPROFILE%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1)
Set-PSReadLineKeyHandler -Chord Ctrl-a -Function BeginningOfLine
Set-PSReadLineKeyHandler -Chord Ctrl-e -Function EndOfLine
Set-PSReadLineKeyHandler -Chord Ctrl+u -Function BackwardDeleteLine
Set-PSReadLineKeyHandler -Chord Ctrl+k -Function ForwardDeleteLine                                                                        

function _disable_history { Set-PSReadlineOption -HistorySaveStyle SaveNothing }
New-Alias dh _disable_history
