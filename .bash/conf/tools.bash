hiscopy() {
    history | awk '{$1="";print $0;}' | sort | uniq | fzf --tac | awk '{printf "%s", $0;}' | pbcopy
}

gitb() {
    git branch | peco | awk '{printf "%s", $NF;}' | pbcopy
}
