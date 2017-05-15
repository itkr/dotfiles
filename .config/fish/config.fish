# function fish_prompt
#     set_color $fish_color_cwd
#     echo -n (prompt_pwd)
#     set_color normal
#     echo -n ' > '
# end

# pyenv

set -U fish_user_paths ~/.pyenv/bin $fish_user_paths
status --is-interactive; and source (pyenv init -|psub)
status --is-interactive; and source (pyenv virtualenv-init -|psub)

# prompt

set -g fish_prompt_pwd_dir_length 0

function fish_prompt
    pyenv version | awk '{printf "(%s) ", $1;}'
    set_color 14968C
    echo -n (prompt_pwd)
    set_color 1E78C8
    echo -n ' $ '
end
