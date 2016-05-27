# Command line settings
ps_normal='\[\033[01;36m\]\w\[\033[00m\] \[\033[01;34m\]\$ \[\033[00m\]'
export PS1=$ps_normal

#formattedGitBranch() {
#    _branch=`git branch 2>/dev/null | grep '*' | tr -d ' *()'`
#    test -n "$_branch" && echo -e "($_branch)"
#}
#PS1='\[\033[01;34m\]$(formattedGitBranch)\[\033[00m\]\w\$ '

