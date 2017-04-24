hisdo() {
    hisdo_cmd=`history | fzf --tac | awk '{$1="";print $0;}'`
    echo ${hisdo_cmd}
    eval ${hisdo_cmd}
}

hiscopy() {
    history | fzf --tac | awk '{$1="";printf "%s", $0;}' | pbcopy
}

gitb() {
    git branch | peco | awk '{printf "%s", $NF;}' | pbcopy
}
