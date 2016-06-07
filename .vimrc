" #### General Config ####

set number                      "Show line numbers
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim
set ruler                       "Show colum and line in the bottom right corner
syntax on                       "turn on syntax highlighting

" ################ Indentation ######################

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

filetype plugin on
filetype indent on

" set list listchars=tab:\ \ ,trail:· " Display tabs and trailing spaces visually

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

