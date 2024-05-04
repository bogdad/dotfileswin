Remove-Variable -Force HOME
Set-Variable HOME "C:\Users\Vladimir"

Set-PSReadlineKeyHandler -Key Tab -Function Complete

function Get-GitStatus { & git status $args }
New-Alias -Name gs -Value Get-GitStatus
function Set-GitCommit { & git commit $args }
New-Alias -Name gc -Value Set-GitCommit -Force  -Option AllScope

function Set-GitAdd { & git add $args }
New-Alias -Name ga -Value Set-GitAdd

function Set-GitPush { & git push $args }
New-Alias -Name gp -Value Set-GitPush -Force -Option AllScope

function Set-GitRemote { & git remote --verbose $args }
New-Alias -Name grv -Value Set-GitRemote -Force -Option AllScope

function Set-GitBranch { & git branch $args }
New-Alias -Name gb -Value Set-GitBranch -Force -Option AllScope



#region conda initialize
# !! Contents within this block are managed by 'conda init' !!
(& "C:\tools\miniconda3\Scripts\conda.exe" "shell.powershell" "hook") | Out-String | Invoke-Expression
#endregion
