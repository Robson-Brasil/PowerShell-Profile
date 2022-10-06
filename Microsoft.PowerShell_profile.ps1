$MaximumHistoryCount = 20000

# Configurações do PowerShell
Import-Module posh-git
#Import-Module oh-my-posh
Import-Module PSReadline
Import-Module Get-ChildItemColor
Import-Module Terminal-Icons
Import-Module DockerCompletion

# Autocomplete, keybinds e histórico de comandos
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadlineOption -HistorySearchCursorMovesToEnd

# Autosugestões do PSReadline
Set-PSReadlineOption -ShowToolTips
Set-PSReadlineOption -PredictionSource History

# Configuração e Temas do OH-MY-POSH
oh-my-posh --init --shell pwsh --config ~\AppData\Local\Programs\oh-my-posh\themes\quick-term.omp.json | Invoke-Expression

# Aliases
Set-Alias limpeza C:\Script\limpeza.bat

Set-Alias ls la
Set-Alias l lb

Set-Alias which Get-Command
Set-Alias open Invoke-Item

Set-Alias limpar clear

# History definitions
$HistoryFilePath = Join-Path ([Environment]::GetFolderPath('UserProfile')) .ps_history
Register-EngineEvent PowerShell.Exiting -Action { Get-History | Export-Clixml $HistoryFilePath } | out-null
if (Test-path $HistoryFilePath) { Import-Clixml $HistoryFilePath | Add-History }

#Set-Alias winfetch pwshfetch-test-1

#(Invoke-WebRequest "https://raw.githubusercontent.com/kiedtl/winfetch/master/winfetch.ps1" -UseBasicParsing).Content.Remove(0,1) | Invoke-Expression

# Functions
function procurar()      {winget search $args}
function update()        {winget upgrade $args}
function upgrade()       {winget upgrade $args}
function atualizar()     {winget upgrade --all $args}
function desinstalar()   {winget uninstall $args}
#Edição dos Profiles do WindowsTerminal e PowerShell
function profile()       {code $PROFILE}
function settings.json() {code "$HOME\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"}
#Arquivo de Historico do powerShell
function history()       {code "$HOME\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt"}

function ..()            {Set-Location ".."}
function ....()          {Set-Location "..\.."}
function ......()        {Set-Location "..\..\.."}

function ll()            {Get-ChildItem | Format-Table}
function la()            {Get-ChildItem | Format-Wide}
function lb()            {Get-ChildItem | Format-List}

#GitHub Comandos
function init()          {git init $args}
function status()        {git status $args}
function add()           {git add . $args}
function commit()        {git commit -m  $args}
function branch()        {git branch -M master  $args}
function remote()        {git remote add origin  $args}
function push()          {git push -u origin master  $args}
function github()        {Set-Location "D:\GitRepositorio"}

# Compute file hashes - useful for checking successful downloads
function md5             {Get-FileHash -Algorithm MD5 $args}
function sha1            {Get-FileHash -Algorithm SHA1 $args}
function sha256          {Get-FileHash -Algorithm SHA256 $args}

function tail            {Get-Content $args -Tail 30 -Wait}
function take            {
  New-Item -ItemType directory $args
  Set-Location "$args"
}

#Criar Link Simbólico
function linksimbolico($name, $sourcePath) {New-Item -ItemType SymbolicLink -Path $name -Target $sourcePath}