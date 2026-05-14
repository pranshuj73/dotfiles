#!/usr/bin/env bash
# Arch install script — mirrors the package set from ~/nixos
# Usage: ./install.sh

set -euo pipefail

DOTFILES="$HOME/gh/dotfiles"

log() { printf '\n\033[1;34m==>\033[0m %s\n' "$*"; }

if ! command -v pacman >/dev/null 2>&1; then
    echo "pacman not found — this script targets Arch Linux." >&2
    exit 1
fi

# -------------------------------------------------------------------
# 0. Enable [multilib] (required for steam)
# -------------------------------------------------------------------
if ! grep -q '^\[multilib\]' /etc/pacman.conf; then
    log "Enabling [multilib] repo in /etc/pacman.conf…"
    sudo sed -i '/^#\[multilib\]/,/^#Include/ s/^#//' /etc/pacman.conf
fi

# -------------------------------------------------------------------
# 1. Official repo packages
# -------------------------------------------------------------------
PACMAN_PKGS=(
    # de / wm / comp
    bspwm sxhkd polybar picom rofi rofimoji copyq xclip gparted

    # editors
    neovim vim

    # cli utilities
    wget unzip zoxide
    github-cli git lazygit
    ripgrep mpv brightnessctl playerctl feh psmisc tree-sitter fd

    # terminal / shell
    zsh wezterm
    zsh-autosuggestions

    # language toolchains
    python python-uv ruff
    zig
    go
    nodejs pnpm
    gcc
    rust
    lua lua-language-server

    # docker
    docker docker-compose

    # gui apps
    discord qbittorrent

    # gaming
    steam gamemode

    # fonts
    ttf-firacode-nerd

    # android dev
    android-tools scrcpy jdk17-openjdk

    # screenshot
    maim
)

log "Installing official repo packages…"
sudo pacman -Syu --needed --noconfirm "${PACMAN_PKGS[@]}"

# -------------------------------------------------------------------
# 2. AUR helper (yay)
# -------------------------------------------------------------------
if ! command -v yay >/dev/null 2>&1; then
    log "Installing yay (AUR helper)…"
    sudo pacman -S --needed --noconfirm base-devel
    tmpdir=$(mktemp -d)
    git clone https://aur.archlinux.org/yay-bin.git "$tmpdir/yay-bin"
    (cd "$tmpdir/yay-bin" && makepkg -si --noconfirm)
    rm -rf "$tmpdir"
fi

# -------------------------------------------------------------------
# 3. AUR packages
# -------------------------------------------------------------------
AUR_PKGS=(
    zen-browser-bin
    helium-browser-bin
    spicetify-cli
    spicetify-marketplace-bin
    lazydocker-bin
    bun-bin
    readest-bin
    handy-bin
    zotero-bin
    claude-code
    openai-codex-bin
)

log "Installing AUR packages…"
yay -S --needed --noconfirm "${AUR_PKGS[@]}"

# -------------------------------------------------------------------
# 4. npm-based CLI tools (claude-code, codex)
# -------------------------------------------------------------------
log "Installing npm-based CLIs (claude-code, codex)…"
sudo npm install -g @anthropic-ai/claude-code @openai/codex

# -------------------------------------------------------------------
# 5. oh-my-zsh + plugins
# -------------------------------------------------------------------
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    log "Installing oh-my-zsh…"
    RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions \
        "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

# -------------------------------------------------------------------
# 6. Symlink dotfiles
# -------------------------------------------------------------------
log "Linking dotfiles…"
mkdir -p "$HOME/.config"

link() {
    local src="$1" dest="$2"
    if [[ ! -e "$src" ]]; then
        echo "  ERROR: source missing: $src — skipping $dest" >&2
        return 1
    fi
    if [[ -L "$dest" && ! -e "$dest" ]]; then
        echo "  removing broken symlink at $dest"
        rm "$dest"
    elif [[ -e "$dest" || -L "$dest" ]]; then
        echo "  skipping $dest (already exists)"
        return
    fi
    ln -s "$src" "$dest"
    echo "  linked $dest -> $src"
}

link "$DOTFILES/bspwm"          "$HOME/.config/bspwm"
link "$DOTFILES/polybar"        "$HOME/.config/polybar"
link "$DOTFILES/sxhkd"          "$HOME/.config/sxhkd"
link "$DOTFILES/wezterm"        "$HOME/.config/wezterm"
link "$DOTFILES/nvim"           "$HOME/.config/nvim"
link "$DOTFILES/picom"          "$HOME/.config/picom"
link "$DOTFILES/cursors"        "$HOME/.icons"
link "$DOTFILES/zsh/.zshrc"     "$HOME/.zshrc"
link "$DOTFILES/xprofile/.xprofile" "$HOME/.xprofile"

# libinput input configs (system-wide, needs sudo)
log "Linking xorg input configs to /etc/X11/xorg.conf.d/…"
sudo ln -sfn "$DOTFILES/xorg/30-touchpad.conf" /etc/X11/xorg.conf.d/30-touchpad.conf
sudo ln -sfn "$DOTFILES/xorg/30-mouse.conf"    /etc/X11/xorg.conf.d/30-mouse.conf

# -------------------------------------------------------------------
# 7. Spicetify (adblock extension + new-releases custom app)
# -------------------------------------------------------------------
if command -v spicetify >/dev/null 2>&1 && [[ -d "$HOME/.config/spotify" || -d /opt/spotify ]]; then
    log "Configuring spicetify…"
    # spicetify needs write access to the Spotify install directory
    if [[ -d /opt/spotify && ! -w /opt/spotify ]]; then
        sudo chmod a+wr /opt/spotify
        sudo chmod a+wr /opt/spotify/Apps -R
    fi
    spicetify config extensions adblock.js
    spicetify config custom_apps new-releases
    spicetify backup apply || true
else
    echo "  skipping spicetify — install Spotify first, then re-run this block manually"
fi

# -------------------------------------------------------------------
# 8. Services + groups
# -------------------------------------------------------------------
log "Enabling docker service + adding user to docker group…"
sudo systemctl enable --now docker.service
sudo usermod -aG docker "$USER"

# -------------------------------------------------------------------
# 9. Default shell
# -------------------------------------------------------------------
if [[ "$SHELL" != *zsh ]]; then
    log "Setting zsh as default shell (will prompt for password)…"
    chsh -s "$(command -v zsh)"
fi

log "Done. Reboot or re-login to pick up shell + docker group changes."
