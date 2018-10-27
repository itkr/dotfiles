bash_conf=~/.bash/conf

for f in $bash_conf/*.bash; do
    source $f
done

if [ -e ${HOME}/.bashrc.local ]; then
    source ${HOME}/.bash.local
fi

if [ -e ${HOME}/.bashrc.org ]; then
    source ${HOME}/.bash.org
fi
