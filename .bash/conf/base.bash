# export PATH=/usr/local/sbin:${PATH}

# ########################################
# Alias
# ########################################

alias git='git stash list; git'
alias fd='find ./ -type f -print | xargs grep'
alias fmt_python='~/.pyenv/versions/global/bin/python ~/Scripts/fmt_python.py'
alias tmux='tmux -2'

# Linux pbcopy
if (! which pbcopy > /dev/null); then
    if which xsel > /dev/null; then
        alias pbcopy='xsel -b'
    fi
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

export PS1='\[\033[01;36m\]\w\[\033[00m\] \[\033[01;34m\]\$ \[\033[00m\]'

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
    git branch | peco | awk '{printf "%s", $NF;}' | pbcopy
}

# ########################################
# Go
# ########################################

export GOPATH=${HOME}/.go
export PATH=${PATH}:${GOPATH}/bin

