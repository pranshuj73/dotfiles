### DUPLICATE TAB WITH SAME CWD
function prompt {
    $loc = $executionContext.SessionState.Path.CurrentLocation
    $out = ""
    $osc7 = ""

    if ($loc.Provider.Name -eq "FileSystem") {
        # Define ANSI escape character
        $ansi_escape = [char]27

        # Normalize the path with forward slashes
        $provider_path = $loc.ProviderPath -Replace "\\", "/"

        # OSC 7 sequence (sets terminal's working directory)
        $osc7 = "$ansi_escape]7;file://${env:COMPUTERNAME}/${provider_path}$ansi_escape\"

        # OSC 9;9 sequence (provides information about the provider path)
        $out += "$ansi_escape]9;9;`"$($loc.ProviderPath)`"$ansi_escape\"
    }

    # Append OSC 7 and construct the prompt
    $out += $osc7
    $out += "PS $loc$('>' * ($nestedPromptLevel + 1)) "

    return $out
}

function rpth {
  cd ~/Desktop
}

### CUSTOM GIT SHORTCUTS
function gac {
    param (
        [Parameter(Position=0, Mandatory=$true)]
        [string]$message
    )
    git add .
    git commit -m $message
}

function gacz {
    git add .
    cz c
}

function gpm {
    param (
        [switch]$f  # Optional parameter for --force
    )

    if ($force) {
        git push origin main --force
    } else {
        git push origin main
    }
}

function gpl {
    param (
        [switch]$f  # Optional parameter for --force
    )

    if ($force) {
        git pull origin main --force
    } else {
        git pull origin main
    }
}


### AUTO SUGGESTIONS ###
Set-PSReadLineKeyHandler -Chord Tab -Function AcceptSuggestion
Set-PSReadLineKeyHandler -Chord RightArrow -Function AcceptNextSuggestionWord

### INSHELLISENSE ###
#if ( Test-Path '~/.inshellisense/powershell/init.ps1' -PathType Leaf ) { . ~/.inshellisense/powershell/init.ps1 } 

### OH MY POSH SETUP ###
pokeget random --hide-name
oh-my-posh --init --shell pwsh --config "~/desktop/github/dotfiles/win-pwsh/gray.json" | Invoke-Expression

