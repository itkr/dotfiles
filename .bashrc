# Import virtualenvwrapper
#source `which virtualenvwrapper.sh`
if [ -f ~/.virtualenvwrapperrc ]; then
    source ~/.virtualenvwrapperrc
fi

# Import pythonbrew
if [ -f ~/.pythonbrew/etc/bashrc ]; then
    source ~/.pythonbrew/etc/bashrc
fi

# Alias
alias git='git stash list; git'
alias fd='find ./ -type f -print | xargs grep'

# Command line settings
ps_normal='\[\033[01;36m\]\w\[\033[00m\] \[\033[01;34m\]\$ \[\033[00m\]'
export PS1=$ps_normal

# Use mysql
export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:/usr/local/mysql-5.5.30-osx10.6-x86_64/lib/

# Use python
#pythonbrew switch 2.7.3
#workon itkr
