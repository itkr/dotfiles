export HISTSIZE=10000
export HISTFILESIZE=$HISTSIZE

function share_history {
    history -a
    history -c
    history -r
}
PROMPT_COMMAND='share_history'
shopt -u histappend

