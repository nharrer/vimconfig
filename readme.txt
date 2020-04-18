Install Vundle after checkout:

git clone https://github.com/VundleVim/Vundle.vim.git .vim/bundle/Vundle.vim

ln -s $(pwd)/.vim/bundle /etc/vim/bundle
ln -s $(pwd)/.vimrc /etc/vim/vimrc.local

vim +PluginInstall +qall

