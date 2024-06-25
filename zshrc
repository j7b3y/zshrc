# Env
export EDITOR=vim
export RSYNC_RSH=ssh
export HISTFILE=$HOME/.zsh-history
export HISTSIZE=100000
export SAVEHIST=1000000
export WORDCHARS='*?_.[]~-=&;!#$%^(){}<>'
export PATH="$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/snap/bin"

# Alias
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# General
autoload -Uz colors ; colors
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt no_flow_control
setopt extended_glob
setopt histignorealldups
setopt share_history
setopt hist_ignore_all_dups
setopt inc_append_history
setopt menu_complete
autoload -Uz compinit ; compinit
setopt correct
zstyle ':completion:*' menu select
setopt list_packed
zstyle ':completion::complete:*' use-cache true
autoload -U colors ; colors ; zstyle ':completion:*' list-colors "${LS_COLORS}"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:manuals' separate-sections true
setopt magic_equal_subst
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{magenta}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{yellow}+"
zstyle ':vcs_info:*' formats "%F{cyan}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
setopt prompt_subst
autoload -U add-zsh-hook
zle -N peco-history-selection
precmd () { vcs_info }
PROMPT='%F{magenta}%B%n%b%f@%F{blue}%U%m%u%f:%F{green}%1~%f%F{cyan}$vcs_info_msg_0_%f%F{white}$%f '

# zplug
source ~/.zplug/init.zsh

zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "mollifier/cd-gitroot"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "b4b4r07/enhancd", use:init.sh 

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load --verbose > /dev/null

# AOSP Build 
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/platform-tools" ] ; then
    PATH="$HOME/platform-tools:$PATH"
fi

export USE_CCACHE=1
export CCACHE_EXEC=/usr/bin/ccache
export CCACHE_DIR=/mnt/ccache
