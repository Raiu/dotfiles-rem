# helpers
_exist() { command -v $1 >/dev/null 2>&1 }

# Create state and cache dir
[[ ! -d "${XDG_STATE_HOME}/zsh" ]]  && mkdir -p "${XDG_STATE_HOME}/zsh"
[[ ! -d "${XDG_CACHE_HOME}/zsh" ]]  && mkdir -p "${XDG_CACHE_HOME}/zsh"

# Source some files
[[ -e "${ZDOTDIR}/export.zsh" ]]    && source "${ZDOTDIR}/export.zsh"
[[ -e "${ZDOTDIR}/config.zsh" ]]    && source "${ZDOTDIR}/config.zsh"

# antidote
[[ -e "${ZDOTDIR}/antidote" ]] ||
    git clone "https://github.com/mattmc3/antidote.git" "${ZDOTDIR}/antidote"
source "${ZDOTDIR}/antidote/antidote.zsh"
antidote load "${ZDOTDIR}/plugins.list"

# Prompt
[[ -e "${ZDOTDIR}/prompt.zsh" ]]    && source "${ZDOTDIR}/prompt.zsh"

# Zoxide
if _exist "zoxide"; then
    eval "$(zoxide init zsh)"
fi

# Vim
if _exist "vim"; then
    if [ ! -d "$VIMDIR/bundle/Vundle.vim" ]; then
        git clone --quiet "https://github.com/VundleVim/Vundle.vim.git" \
          "$VIMDIR/bundle/Vundle.vim" > /dev/null
        
        vim -c "execute \"PluginInstall\" | qa"
    fi
fi

# List on cd
if _exist "exa"; then
    chpwd() {
        exa --icons --group-directories-first
    }
else
    chpwd() {
        LC_COLLATE=C ls -h --group-directories-first --color=auto
    }
fi

[[ -e "${ZDOTDIR}/alias.zsh" ]] && source "${ZDOTDIR}/alias.zsh"
