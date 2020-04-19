Install Vundle after checkout:

git clone https://github.com/VundleVim/Vundle.vim.git .vim/bundle/Vundle.vim

ln -sf $(pwd)/vim/bundle /etc/vim/bundle
ln -sf $(pwd)/vimrc /etc/vim/vimrc.local
ln -s $(pwd)/vim ~/.vim

vim +PluginInstall +qall

