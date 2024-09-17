
# Find and set branch name var if in git repository.
function git_branch_name()
{
  branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
  if [[ $branch == "" ]];
  then
    :
  else
    echo '- ('$branch')'
  fi
}

# Optional: Add conda environment name to prompt
precmd_conda_info() {
    if [[ -n $CONDA_DEFAULT_ENV ]]; then
        CONDA_ENV="($CONDA_DEFAULT_ENV) "
    else
        CONDA_ENV=""
    fi
}
# PROMPT='%F{cyan}$CONDA_ENV%f%F{white}%n%f %B%F{yellow}%1~%f%b $ '
PROMPT='%F{white}%n%f %B%F{yellow}%1~%f%b $ '

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/socms/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/socms/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/Users/socms/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/socms/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/Users/socms/miniforge3/etc/profile.d/mamba.sh" ]; then
    . "/Users/socms/miniforge3/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

export PATH=~/.local/bin:$PATH

alias start-jl-server="cd ~/Developer;jupyter lab --ip=MacBookPro.hsd1.al.comcast.net --no-browser --custom-css"

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

# eval "$(/opt/homebrew/bin/brew shellenv)"

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit


# add zsh plugins
# zinit light zsh-users/zsh-syntac-highlishting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

#load completions
autoload -U compinit && compinit
autoload -U promptinit;promptinit
prompt pure

zinit cdreplay -q

#prompt
#eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"  

# history
HISTSIZE=1000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTUP=erase
setopt appendhistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups

# completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no # disable default completion menu
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color -$realpath'


#aliases
alias ls='ls --color'
alias c='clear'

# shell integration
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# .zshrc
fpath+=($HOME/.zsh/pure)



