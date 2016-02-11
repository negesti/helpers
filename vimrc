" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible
set nocompatible
filetype off

" Vim5 and later versions support syntax highlighting. Uncommenting the
" following enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		   " Show (partial) command in status line.
set showmatch		 " Show matching brackets.
set ignorecase	 " Do case insensitive matching
set smartcase		 " Do smart case matching
"set incsearch	  " Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden       " Hide buffers when they are abandoned
" set mouse=a		  " Enable mouse usage (all modes)
set background=dark

set enc=utf-8
set tenc=utf-8
set wildmenu
set shiftwidth=2
set softtabstop=2
set smarttab
set tabstop=2
set incsearch
set scrolloff=2
set expandtab
set autoindent
set hlsearch
set number
set virtualedit=block

colorscheme distinguished

if has('gui_running')
  " select color scheme
  colorscheme distinguished
  " Resize the window
  set lines=62 columns=150
endif

" Source a global configuration file if available
if filereadable("/etc/vimrc")
  source /etc/vimrc
endif

" Current git branch - looks nice but mouse wheel wont work...
"set statusline=%1*%{GitBranch()}%*     " name of the gitbranch
function! GitBranch()
  let branch = system("git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* //'")
  if branch != ''
    return '[' . substitute(branch, '\n', '', 'g') . ']' 
  en
  return ''
endfunction

" - %F: absolute file path
" - %m: show [+] if the file has changes
" - %y: the filetype
set statusline=
set statusline+=\ %f%m%h
set statusline+=%=                 " everthing after this is on the right side
set statusline+=\ [%l\/%L]         " line number x/y
set statusline+=\ %c                " column in line

" Always show the status line:
set laststatus=2 

"hi User1 term=bold cterm=bold ctermbg=green

" vundle
set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'vim-scripts/L9'
Bundle 'airblade/vim-gitgutter'
Bundle 'jeffkreeftmeijer/vim-numbertoggle'
Bundle 'SuperTab'

filetype plugin indent on
