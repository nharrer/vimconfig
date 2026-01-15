if !has("gui_running")
  " don't use mouse mode in console
  " this can't be done in vimrc, because it's overruled from a script which
  " runs later.
  set mouse=
  if !has('nvim')
    set ttymouse=
  endif
endif

