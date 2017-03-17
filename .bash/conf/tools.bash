hisdo() {
    hisdo_cmd=`history | fzf --tac | awk '{$1="";print $0;}'`
    echo ${hisdo_cmd}
    eval ${hisdo_cmd}
}

hiscopy() {
    echo `history | fzf --tac | awk '{$1="";print $0;}'` | pbcopy
}

gitco() {
    git checkout `git branch | peco | awk '{print $NF}'`
}
