export GOPATH=${HOME}/.go
export PATH=${PATH}:${GOPATH}/bin

# ghq
# (brew install ghq)
# (git config --global qhq.root=${GOPATH}/src)
alias ghq-cd='cd $(ghq root)/$(ghq list | peco)'
# (go get golang.org/x/tools/cmd/godoc)
alias ghq-godoc='godoc $(ghq list | peco)'
