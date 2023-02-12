# ########################################
# Alias
# ########################################

alias fd='find ./ -type f -print | xargs grep'
alias git='git stash list; git'
alias gitbr='git branch -r --merged origin/develop | grep -v -E "develop|master"'
alias gitl="git log --pretty='format:%C(yellow)%h %C(green)%cd %C(cyan)[%ae] %C(reset)%s %C(red)%d' --date=iso"
alias save_cmd='history -1 >> ~/Desktop/command_log.sh'
alias tmux='tmux -2'
alias vi='vi -u NONE -N'

alias act='source ~/Scripts/activate.sh'
alias fmt_python='~/.pyenv/versions/global/bin/python ~/Scripts/fmt_python.py'
alias radio='~/Projects/github.com/itkr/my-radio/play.py'

# ls (Linux)
if [ "$(uname)" = 'Linux' ]; then
    eval `dircolors -b ~/.colorrc`
    alias ls='ls --color=auto -F'
fi

# ls (Mac OSX)
if [ "$(uname)" = 'Darwin' ]; then
    alias ls='ls -FG'
fi

# Linux pbcopy
if (! which pbcopy > /dev/null); then
    if which xsel > /dev/null; then
        alias pbcopy='xsel -b'
    fi
    if which clip.exe > /dev/null; then
        alias pbcopy='clip.exe'
    fi
fi


# ########################################
# Base Config
# ########################################

export LANG=ja_JP.UTF-8
if [ "$(uname)" = 'Linux' ]; then
    export LANG=C.UTF-8
fi

# ########################################
# History
# ########################################

export HISTSIZE=10000
export HISTFILESIZE=$HISTSIZE

function share_history {
    history -a
    history -c
    history -r
}
PROMPT_COMMAND='share_history'
shopt -u histappend

function hisrank {
    history | awk '{print $2;}' | sort | uniq -c | sort -r | head -n 15
}

# ########################################
# Prompt
# ########################################

export PS1='[$(date +%Y/%m/%d\ %H:%M:%S)] \[\033[01;36m\]\w\[\033[00m\] \[\033[01;34m\]\$ \[\033[00m\]'

#formattedGitBranch() {
#    _branch=`git branch 2>/dev/null | grep '*' | tr -d ' *()'`
#    test -n "$_branch" && echo -e "($_branch)"
#}
#PS1='\[\033[01;34m\]$(formattedGitBranch)\[\033[00m\]\w\$ '

# ########################################
# Tool
# ########################################

hiscopy() {
    history | awk '{$1="";print $0;}' | sort | uniq | fzf --tac | awk '{printf "%s", $0;}' | pbcopy
}

gitb() {
    git branch | fzf | awk '{printf "%s", $NF;}' | pbcopy
}

# ########################################
# Go
# ########################################

export GOPATH=${HOME}/.go
export PATH=${PATH}:${GOPATH}/bin

# ########################################
# bat
# ########################################

export BAT_THEME="TwoDark"

# ########################################
# radigo
# ########################################

# in secret.bash
# export RADIKO_MAIL="" && export RADIKO_PASSWORD=""

# ########################################
# fzf
# ########################################

export FZF_DEFAULT_OPTS='--reverse'

# ########################################
# direnv
# ########################################

if (which direnv > /dev/null); then
    eval "$(direnv hook bash)"
fi

# ########################################
# homebrew
# ########################################

export HOMEBREW_EDITOR=vi
