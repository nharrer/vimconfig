" original _vimrc on windows 
if has('win32')
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle (based on https://gist.github.com/mikehaertl/1612035)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
  call vundle#begin('/etc/vim/bundle')  " Use a shared folder instead of ~/.vimrc/bundle
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'VundleVim/Vundle.vim'

Plugin 'sainnhe/gruvbox-material'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" End of Vundle plugins
call vundle#end()
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" settings by norbert
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
" across (heterogeneous) systems easier.
if has('win32')
  set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif
  
if !has('nvim')
  " the important parts from $VIMRUNTIME/vimrc_example.vim
  source $VIMRUNTIME/defaults.vim
  packadd! matchit
endif

if has("gui_running")
  " Remap a few keys for Windows behavior (this is also usefull on linux)
  source $VIMRUNTIME/mswin.vim

  " Mouse behavior (the Windows way)
  behave mswin

  if has('unix')
    set guifont=Adwaita\ Mono\ 10
    set guioptions-=T

    if argc() == 0
      set lines=60 columns=120
    endif
  endif

  if has('win32')
    set guifont=Consolas
  endif
else
  " don't use mouse mode in console
  set mouse=
  if !has('nvim')
    set ttymouse=
  endif
endif

" use gruvbox as colorscheme
if has('termguicolors')
  set termguicolors
endif
let g:gruvbox_material_background = 'soft'
"let g:gruvbox_material_disable_italic_comment = '1'
colorscheme gruvbox-material
set background=dark
if has('win32')
  " bright background on windows
  set background=
endif

set showcmd            " Show (partial) command in status line.
set showmatch          " Show matching brackets.
set ignorecase         " Do case insensitive matching
set smartcase          " Do smart case matching
set incsearch          " Incremental search
set hlsearch           " highlight while searching
set autowrite          " Automatically save before commands like :next and :make
set hidden             " Hide buffers when they are abandoned
set laststatus=2       " Always show status line
set lazyredraw         " do not redraw while running macros (much faster)
set whichwrap+=<,>,h,l " make cursor keys and h,l wrap over line endings
set encoding=utf-8     " UTF-8 per default
set rulerformat=%l,%c%V%=%n\ %p%%:
set undofile           " create undofiles
set backup             " create backupfiles
set selectmode=        " I prefer visual mode over select mode
set clipboard^=unnamedplus " copy yanked buffer to clipboard

" <leader> key, for example for <leader>f to format sql (see plugin
" sqlbeautify.vim)
let mapleader=" "

if has("autocmd")
  filetype plugin indent on
endif

set tabstop=4
set shiftwidth=4
set expandtab
" but vim config files should have a tabstop of 2
if has("autocmd")
  autocmd FileType vim setlocal shiftwidth=2 tabstop=2
endif

" tab / shift-tab moves selected block
inoremap <S-Tab> <Esc><<i
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" ctrl-b: shows buffers, shift-b,shift-n: prev, next buffer
:nnoremap <C-b> :buffers<CR>:buffer<Space>
:nnoremap <S-b> :bp<CR>
:nnoremap <S-n> :bn<CR>

" ctrl-f follows tags (instead of ctrl-], btw: ctrl-o goes back)
nnoremap <C-f> <C-]>

" remember last cursor position
augroup remember_cursor
  autocmd!
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \ exe "normal! g`\"" |
        \ endif
augroup END

" handle swap/backup/undo files
" based on https://vim.fandom.com/wiki/Automatically_create_tmp_or_backup_directories
if has('win32')
  let s:tempdir='C:\Temp\'
else 
  " linux
  let s:tempdir='/tmp/'
endif
let s:tempdir.='vim/'
let s:swapdir=s:tempdir
let s:backupdir=s:tempdir.'bak/'
let s:undodir=s:tempdir.'und/'
if has('nvim')
  " since neovim has a different format, use a different dir
  let s:undodir=s:tempdir.'und_neo/'
endif
if !isdirectory(s:swapdir)
  call mkdir(s:swapdir, "p")
  call setfperm(s:swapdir, "rwxrwxrwx")
endif
if !isdirectory(s:backupdir)
  call mkdir(s:backupdir, "p")
  call setfperm(s:backupdir, "rwxrwxrwx")
endif
if !isdirectory(s:undodir)
  call mkdir(s:undodir, "p")
  call setfperm(s:undodir, "rwxrwxrwx")
endif
execute 'set directory='.s:swapdir.'/'
execute 'set backupdir='.s:backupdir.'/'
execute 'set undodir='.s:undodir.'/'

