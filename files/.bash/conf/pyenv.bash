export PYENV_ROOT=~/.pyenv
export PATH="${PYENV_ROOT}/bin:${PATH}"

if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"
