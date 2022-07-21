# Vimconfig

I store my prefered vim configs here. It's probably only useful to me.

## Install

Install Vundle first:

```
git clone https://github.com/VundleVim/Vundle.vim.git /etc/vim/bundle/Vundle.vim
```

Create symbolic links:

```
ln -sf $(pwd)/vimrc /etc/vim/vimrc.local
ln -s $(pwd)/vim ~/.vim
```

Install plugins (ignore error on first run):

```
vim +PluginInstall +qall
```
