bash_conf=~/.bash/conf

if [ -e ${HOME}/.bashrc.org ]; then
    source ${HOME}/.bashrc.org
fi

for f in $bash_conf/*.bash; do
    source $f
done

if [ -e ${HOME}/.bashrc.local ]; then
    source ${HOME}/.bash.local
fi
