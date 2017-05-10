# Alias
alias git='git stash list; git'
alias fd='find ./ -type f -print | xargs grep'

if (! which pbcopy > /dev/null); then
    if which xsel > /dev/null; then
        alias pbcopy='xsel -b'
    fi
fi

