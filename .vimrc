if has('win32')
  " On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
  " across (heterogeneous) systems easier.
  set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after

  set directory=C:\Temp\bak_files
  set backupdir=C:\Temp\bak_files
  set undodir=C:\Temp\bak_files

  " Von hier weg bis zum Endif steht der Inhalt vom originalen Windows _vimrc:

  " Vim with all enhancements
  source $VIMRUNTIME/vimrc_example.vim

  " Remap a few keys for Windows behavior
  source $VIMRUNTIME/mswin.vim

  " Mouse behavior (the Windows way)
  behave mswin

  " Use the internal diff if available.
  " Otherwise use the special 'diffexpr' for Windows.
  if &diffopt !~# 'internal'
    set diffexpr=MyDiff()
  endif
  function MyDiff()
    let opt = '-a --binary '
    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
    let arg1 = v:fname_in
    if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
    let arg1 = substitute(arg1, '!', '\!', 'g')
    let arg2 = v:fname_new
    if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
    let arg2 = substitute(arg2, '!', '\!', 'g')
    let arg3 = v:fname_out
    if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
    let arg3 = substitute(arg3, '!', '\!', 'g')
    if $VIMRUNTIME =~ ' '
      if &sh =~ '\<cmd'
        if empty(&shellxquote)
          let l:shxq_sav = ''
          set shellxquote&
        endif
        let cmd = '"' . $VIMRUNTIME . '\diff"'
      else
        let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
      endif
    else
      let cmd = $VIMRUNTIME . '\diff'
    endif
    let cmd = substitute(cmd, '!', '\!', 'g')
    silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
    if exists('l:shxq_sav')
      let &shellxquote=l:shxq_sav
    endif
  endfunction
endif

" Added by Norbert

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" /etc/vim/vimrc.local V1.1.12 2019-07-30 https://gist.github.com/mikehaertl/1612035
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" A Vundle based Vim configuration with globally shared plugins on Ubuntu.
"
" This is a Vundle based Vim setup that keeps all plugins in a global
" directory, namely /etc/vim/bundle. It's trimmed towards PHP development
" with Yii.
"
" Before you install, make sure you have a ruby enabled vim. On fresh Ubuntu you can do:
"
"   sudo apt-get install vim-gtk
"
" Installation:
"
"   mkdir /etc/vim/bundle
"   git clone http://github.com/VundleVim/Vundle.vim.git /etc/vim/bundle/Vundle.vim
"   echo | echo | vim +PluginInstall +qall &>/dev/null
"
" Brief help
"  :PluginList          - list configured bundles
"  :PluginInstall(!)    - install(update) bundles
"  :PluginSearch(!) foo - search(or refresh cache first) for foo
"  :PluginClean(!)      - confirm(or auto-approve) removal of unused bundles
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Shared plugin setup for Vundle
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype off                            " required by Vundle (re-enabled below)
if has('win32')
  set rtp+=$HOME/.vim/bundle/Vundle.vim/
  call vundle#begin('$HOME/.vim/bundle/')
else
  set rtp+=/etc/vim/bundle/Vundle.vim
  call vundle#begin('/etc/vim/bundle')    " Use a shared folder instead of ~/.vimrc/bundle
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'VundleVim/Vundle.vim'

Plugin 'morhetz/gruvbox'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" End of Vundle plugins
call vundle#end()           " required
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" settings by norbert:

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set showcmd            " Show (partial) command in status line.
set showmatch          " Show matching brackets.
set ignorecase         " Do case insensitive matching
set smartcase          " Do smart case matching
set incsearch          " Incremental search
set autowrite          " Automatically save before commands like :next and :make
set hidden             " Hide buffers when they are abandoned
set laststatus=2       " Always show status line
set lazyredraw         " do not redraw while running macros (much faster)
set whichwrap+=<,>,h,l " make cursor keys and h,l wrap over line endings
set rulerformat=%l,%c%V%=%n\ %p%%:

syntax on

let g:gruvbox_italic = '0'
:colorscheme gruvbox
:set background=dark

if has("autocmd")
  filetype plugin indent on
endif

set tabstop=4
set shiftwidth=4
set expandtab

imap <S-Tab> <Esc><<i
:vnoremap <Tab> >gv
:vnoremap <S-Tab> <gv

if !has('win32')
  " don't use mouse mode
  set mouse=
  set ttymouse=
else 
  :set background=
endif

