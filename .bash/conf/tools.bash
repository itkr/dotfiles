historyDo() {
    cmd=`history | fzf --tac | awk '{$1="";print $0;}'`
    echo ${cmd}
    eval ${cmd}
}
alias hisdo=historyDo
