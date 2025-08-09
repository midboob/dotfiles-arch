# Aliases
alias ls="ls --color"

# settings for common commands
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -vI"
alias bc="bc -ql"
alias mkd="mkdir -pv"
alias ls="eza --icons --group-directories-first"
alias lf="lfcd"
alias locate="plocate"
alias tp="trash-put"
alias tpr="trash-restore"
alias cat="bat --theme=matugen-bat-colors"
alias grep="grep --color=always"

# application aliases
alias v=nvim
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
alias hyprconf="~/.config/hypr/conf/"

# notes config
alias notes="/mnt/Storage/Documents/notes/"

# spicetify alias
alias "spicetify update"="spicetify restore backup apply"

# dotfiles alias
alias dots="~/.dotfiles/"

# ani-cli alias
alias ani="ani-cli"

# Storage
alias storage="/mnt/Storage/"

# cybedropdl
alias cyberdl="/mnt/Storage/Documents/Cyberdrop\ DL/"
