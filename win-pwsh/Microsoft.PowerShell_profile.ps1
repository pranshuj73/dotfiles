### DUPLICATE TAB WITH SAME CWD
function prompt {
  $loc = $executionContext.SessionState.Path.CurrentLocation;

$out = ""
  if ($loc.Provider.Name -eq "FileSystem") {
    $out += "$([char]27)]9;9;`"$($loc.ProviderPath)`"$([char]27)\"
  }
  $out += "PS $loc$('>' * ($nestedPromptLevel + 1)) ";
  return $out
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

### OH MY POSH SETUP ###
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/pararussel.omp.json" | Invoke-Expression