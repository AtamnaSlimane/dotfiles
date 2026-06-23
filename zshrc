# ============================
#        Oh My Zsh Setup
# ============================
export ZSH="$HOME/.oh-my-zsh"
# Enable Powerlevel10k Instant Prompt.
# Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# Disable Oh My Zsh auto-update check (Speeds up startup significantly)
DISABLE_AUTO_UPDATE="true"

# Lazy-load Powerlevel10k only for interactive shells
if [[ -n $PS1 ]]; then
    ZSH_THEME="powerlevel10k/powerlevel10k"
    # To enable instant prompt, ensure this line is near the top (before OMZ load)
    # if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    #   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
    # fi
    [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
fi

# ============================
#         PATHs (Consolidated)
# ============================
# Using a single export reduces string manipulation overhead
export PATH="$HOME/.local/bin:$HOME/.config/herd-lite/bin:$HOME/.config/composer/vendor/bin:$HOME/flutter/bin:$PATH"

# Android SDK
export ANDROID_HOME=/opt/android-sdk
export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$PATH"

# Java
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk
export PATH="$JAVA_HOME/bin:$PATH"

# Herd Lite PHP INI
export PHP_INI_SCAN_DIR="/home/slimane/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"

# ============================
#          NVM Lazy Load
# ============================
export NVM_DIR="$HOME/.nvm"

lazy_nvm() {
  unset -f node npm npx nvm
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
}

node() { lazy_nvm; node "$@"; }
npm()  { lazy_nvm; npm "$@"; }
npx()  { lazy_nvm; npx "$@"; }
nvm()  { lazy_nvm; nvm "$@"; }

# ============================
#        Plugins & OMZ
# ============================
# Load OMZ Core
plugins=(git archlinux) # Removed heavy plugins from OMZ loader

source $ZSH/oh-my-zsh.sh

# Load external plugins AFTER OMZ (Crucial for speed and correctness)
# zsh-autosuggestions
if [[ -f ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# ============================
#      Zsh Config Tweaks
# ============================
# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# Keybindings
bindkey -v                       # Vim keybindings
bindkey -M viins 'jj' vi-cmd-mode
bindkey '^[j' autosuggest-accept

# ============================
#          Aliases
# ============================
alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'
alias konachan="python ~/scripts/konachan.py"
alias yandere="python ~/scripts/yandere.py"
alias danbooru="python ~/scripts/danbooru.py"
alias wallhaven="python3 ~/scripts/wallhaven.py"

# ============================
#   Heavy Plugins (Load Last)
# ============================
# zsh-syntax-highlighting MUST be loaded at the very end
if [[ -f ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# FZF
if [[ -f ~/.fzf.zsh ]]; then
    source ~/.fzf.zsh
fi

#
# friday 830 10 2 phy/ 10 11:30 maths 2/2:00 maths 1/ 
# saturday 830 10 1 maths /10 11:30 2 maths / 2:00 1 physics /

