# function fish_prompt
#     set_color $fish_color_cwd
#     echo -n (prompt_pwd)
#     set_color normal
#     echo -n ' > '
# end

function fish_prompt
    set_color 69C
    echo -n (pwd)
    set_color 36F
    echo -n ' $ '
end
