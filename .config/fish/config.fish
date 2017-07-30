# ########################################
# Alias
# ########################################

# ########################################
# History
# ########################################

set HISTSIZE 10000
set HISTFILESIZE $HISTSIZE

function share_history
    history -a
    history -c
    history -r
end

set PROMPT_COMMAND 'share_history'
# shopt -u histappend

# ########################################
# Prompt
# ########################################

set -g fish_prompt_pwd_dir_length 0

function fish_prompt
    # set_color normal
    set_color $fish_color_cwd
    pyenv version | awk '{printf "(%s) ", $1;}'
    set_color 14968C
    echo -n (prompt_pwd)
    set_color 1E78C8
    echo -n ' $ '
end

# ########################################
# Tool
# ########################################

function hiscopy
    history | awk '{$1="";print $0;}' | sort | uniq | fzf --tac | awk '{printf "%s", $0;}' | pbcopy
end

function gitb
    git branch | peco | awk '{printf "%s", $NF;}' | pbcopy
end

# ########################################
# Go
# ########################################

set -x GOPATH ~/.go
set -x fish_user_paths $GOPATH/bin $fish_user_paths

# ########################################
# Pyenv
# ########################################

set -U fish_user_paths ~/.pyenv/bin $fish_user_paths
status --is-interactive; and source (pyenv init -|psub)
status --is-interactive; and source (pyenv virtualenv-init -|psub)
