export NODENV_ROOT=~/.nodenv
export PATH="${NODENV_ROOT}/bin:${PATH}"

if which nodenv > /dev/null; then eval "$(nodenv init -)"; fi
# eval "$(nodenv init -)"
