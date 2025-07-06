# Fastfetch autoload
fastfetch --config $HOME/.config/fastfetch/config.jsonc


# Download and Install zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Add zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# Initialize OMP
eval "$(oh-my-posh init zsh --config "~/.config/ohmyposh/config.toml")"

# Vim mode stuff
bindkey -v
export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Basic binds deleting char both in normal or vi mode
bindkey '^[[3~' delete-char
bindkey -v '^?' backward-delete-char

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Vicmd specific binds
bindkey -M vicmd '^e' edit-command-line
bindkey -M vicmd '^?' vi-delete-char
bindkey -M visual '^?' vi-delete-char


# Keybindings
bindkey '^y' autosuggest-accept # Ctrl + y for accepting autosuggestion
bindkey '^[[Z' autosuggest-accept # Shift + tab for accepting autosuggestion
bindkey '^k' history-search-backward
bindkey '^j' history-search-forward
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Adding texlv to PATH
export PATH="$PATH:/usr/local/texlive/2025/bin/x86_64-linux"

# Alias
alias ls="ls --color"

# settings for common commands
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -vI"
alias bc="bc -ql"
alias mkd="mkdir -pv"
alias ls="exa --icons --group-directories-first"
alias lf="lfcd"
alias locate="plocate"
alias tp="trash-put"
alias tpr="trash-restore"
alias cat="bat --theme=matugen-bat-colors"
alias grep="grep --color=always"

# application aliases
alias v="$EDITOR"
alias vim="$EDITOR"
alias za="zathura"
alias code="vscodium"
alias ytdl="yt-dlp --no-mtime"

# aliases to clean up home directory
alias wget='wget --hsts-file="$XDG_DATA_HOME/wget-hsts"'

# git aliases
alias g="git"
alias gs="git status"
alias gc="git commit"
alias ga="git add"
alias gpl="git pull"
alias gpom="git pull origin master"
alias gpu="git push"
alias gpuom="git push origin master"
alias gd="git diff --output-indicator-new=' ' --output-indicator-old=' '"
alias gch="git checkout"
alias gnb="git checkout -b"
alias gac="git add . && git commit"
alias grs="git restore --staged ."
alias gre="git restore"
alias gr="git remote"
alias gcl="git clone"
alias gl="git log --graph --abbrev-commit --decorate --format=format:'%C(bold green)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold yellow)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all"
alias gt="git ls-tree -r master --name-only"
alias grm="git remote"
alias gb="git branch"
alias gf="git fetch"

# hyprland config
alias hyprconf="~/dotfiles/hypr/.config/hypr/conf/"

# notes config
alias notes="/mnt/Storage/Documents/notes/"

# spicetify alias
alias "spicetify update"="spicetify restore backup apply"

# Custom sudo prompt
export SUDO_PROMPT="$fg[white]need $fg[blue]password $fg[red]for root:󰌾 $fg[white]"

# Custom no command found prompt
command_not_found_handler() {
	printf "%s%s? WTF!!  are u typing\n" "$acc" "$0" >&2
    return 127
  }

# Other options
setopt interactive_comments # Interactive comments
stty stop undef             # Disable ctrl-s for frezzing terminal
setopt AUTOCD               # Change directory just by typing its name
setopt PROMPT_SUBST         # enable command substitution in prompt
setopt MENU_COMPLETE        # Automatically highlight first element of completion menu
setopt LIST_PACKED	    # The completion menu takes less space.
setopt AUTO_LIST            # Automatically list choices on ambiguous completion.
setopt COMPLETE_IN_WORD     # Complete from both ends of a word.
