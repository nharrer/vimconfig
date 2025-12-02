# Vimconfig

I store my prefered vim configs here. It's probably only useful to me.

## Install

Install Vundle first (clones into `/etc/vim/bundle`):

```
git clone https://github.com/VundleVim/Vundle.vim.git /etc/vim/bundle/Vundle.vim
```

Create symbolic links:

* system wide:
   ```
   ln -sf $(pwd)/vimrc /etc/vim/vimrc.local
   ln -s $(pwd)/vim ~/.vim
   ```

* vim per user:
   ```
   ln -s $(pwd)/vimrc ~/.vimrc
   ln -s $(pwd)/vim ~/.vim
   ```

* neovim per user:
   ```
   ln -s $(pwd)/vimrc ~/.config/nvim/init.vim
   ln -s $(pwd)/vim/* ~/.config/nvim/
   ```




Install plugins (ignore error on first run):

```
vim +PluginInstall +qall
```
