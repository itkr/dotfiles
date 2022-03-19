# ssh-keygen -t ed25519 -C "1531860+itkr@users.noreply.github.com"
# cat ~/.ssh/id_ed25519.pub

mkdir -p ~/.bash/conf
mkdir -p ~/.vim/tmp
mkdir -p ~/Projects/github.com/itkr
cd ~/Projects/github.com/itkr/
git clone git@github.com:itkr/dotfiles.git

mv .bashrc .bashrc.org
ln -s ~/Projects/github.com/itkr/dotfiles/files/.bash/conf/base.bash ~/.bash/conf/base.bash
ln -s ~/Projects/github.com/itkr/dotfiles/files/.bash/conf/google-cloud-sdk.bash ~/.bash/conf/google-cloud-sdk.bash
ln -s ~/Projects/github.com/itkr/dotfiles/files/.bash/conf/pyenv.bash ~/.bash/conf/pyenv.bash
ln -s ~/Projects/github.com/itkr/dotfiles/files/.bashrc ~/.bashrc
ln -s ~/Projects/github.com/itkr/dotfiles/files/.gitconfig ~/.gitconfig
ln -s ~/Projects/github.com/itkr/dotfiles/files/.gitignore ~/.gitignore
ln -s ~/Projects/github.com/itkr/dotfiles/files/.vim/plugin.vim ~/.vim/plugin.vim
ln -s ~/Projects/github.com/itkr/dotfiles/files/.vimrc ~/.vimrc
