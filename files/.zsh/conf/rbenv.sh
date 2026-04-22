export RBENV_ROOT=~/.rbenv
export PATH="${RBENV_ROOT}/bin:${PATH}"

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
