if which pyenv > /dev/null ; then
    pyenv deactivate
fi

venv_dir=$(pwd)/venv
echo $venv_dir
if [ -e ${venv_dir} ] ; then
    source ${venv_dir}/bin/activate
fi
