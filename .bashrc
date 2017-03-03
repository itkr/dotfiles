bash_conf=~/.bash/conf

for f in $bash_conf/*.bash; do
    source $f
done
