export NODENV_ROOT=~/.nodenv
export PATH="${NODENV_ROOT}/bin:${PATH}"

# if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
# if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

eval "$(nodenv init -)"
eval "$(nodenv virtualenv-init -)"
