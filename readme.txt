Install Vundle after checkout:

git clone https://github.com/VundleVim/Vundle.vim.git /etc/vim/bundle/Vundle.vim

ln -sf $(pwd)/vimrc /etc/vim/vimrc.local
ln -s $(pwd)/vim ~/.vim

vim +PluginInstall +qall

