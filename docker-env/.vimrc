function! SourceIfExists(file)
    if filereadable(expand(a:file))
        exe 'source' a:file
    endif
endfunction

call SourceIfExists("$VIMRUNTIME/../_vimrc")

set nowb
set nobackup
set noswapfile
set noundofile

set nocompatible
set encoding=utf-8
set fileformat=unix
set fileformats=unix,dos

set list
set listchars=tab:->,trail:.
set backspace=indent,start,eol

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent

set hlsearch
set nowrapscan
set number

map <F2> :%s/\s\+$//<CR>

cnoremap ww :set buftype=nofile<CR>:silent write !sudo tee % > /dev/null
hi Search cterm=NONE ctermfg=DarkRed ctermbg=DarkGrey

let $LANGUAGE='en_US:en'
set colorcolumn=77,117
