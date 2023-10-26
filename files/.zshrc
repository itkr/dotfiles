conf_dir=~/.zsh/conf

if [ -e ${HOME}/.zshrc.org ]; then
    source ${HOME}/.zshrc.org
fi

for f in $conf_dir/*.sh; do
    source $f
done

if [ -e ${HOME}/.zshrc.local ]; then
    source ${HOME}/.zshrc.local
fi

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
