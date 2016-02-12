syntax on
set noswapfile
set number " always show line numbers
set nowrap " don't wrap lines
set backspace=indent,eol,start
set incsearch
set showmode " always show current mode
set nocompatible " Disable Vi-compatibility
filetype on
filetype plugin indent on
set wildmenu
set ruler
set lz
set hid
set softtabstop=4 " when hitting <BS>, pretend like a tab is removed, even if spaces
set tabstop=4 " a tab is four spaces
set shiftwidth=4 " number of spaces to use for autoindenting
set expandtab " expand tabs by default (overloadable per file type later)
set autoindent " always set autoidenting on
set smartindent
set cindent
set ai
set si
set cin
set mouse=a
set cursorline
set numberwidth=6
set encoding=utf-8 " necessary to show Unicode glyphs

set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2 " always show statusline

" colo sdac
colo ron
set cursorline
hi CursorLine term=bold cterm=bold guibg=Grey40
" colo bithack

if has("autocmd")
    augroup c
        autocmd BufReadPre,FileReadPre      *.c,*.h iabbrev /** /**<CR><BACKSPACE>*/<ESC>ka 
    augroup END
    augroup php
        autocmd BufReadPre,FileReadPre      *.php inoremap $this $this->
    augroup END
endif


" kod-relaterat
inoremap {<CR> {<CR>}<ESC>:call BC_AddChar("}")<CR>ko
inoremap { {}<ESC>:call BC_AddChar("}")<CR>i
inoremap ( ()<ESC>:call BC_AddChar(")")<CR>i
inoremap [ []<ESC>:call BC_AddChar("]")<CR>i
imap <C-k> <ESC>:call search(BC_GetChar(), "W")<CR>:noh<CR>A

" bajs-relaterat
iabbrev cant can't

" stulet godis
function! BC_AddChar(schar)
  if exists("b:robstack")
    let b:robstack = b:robstack . a:schar
  else
    let b:robstack = a:schar
  endif
endfunction

function! BC_GetChar()
  let l:char = b:robstack[strlen(b:robstack)-1]
  let b:robstack = strpart(b:robstack, 0, strlen(b:robstack)-1)
  return l:char
endfunction 

set undofile
set undodir=$HOME/.vimundo
set undolevels=1000
set undoreload=10000
"ska ja sparra +?????????
"ja Tack

fu! FixSwe()
    :%s/å/\&aring;/
    :%s/ä/\&auml;/
    :%s/ö/\&ouml;/
    :%s/Å/\&Aring;/
    :%s/Ä/\&Auml;/
    :%s/Ö/\&Ouml;/
endfunction

nnoremap ; :

execute pathogen#infect()

" Theme
"set background=dark
"colorscheme solarized

"let g:syntastic_mode_map = { 'mode': 'passive',     
"                          \ 'active_filetypes': [],     
"                          \ 'passive_filetypes': [] } 
"let g:syntastic_auto_loc_list=1     
nnoremap <silent> <F5> :lnext<CR>
nnoremap <silent> <F6> :lprev<CR>
nnoremap <silent> <C-Space> :ll<CR>

" jDaddy JSON pretty print
nmap <F9> gqaj

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

set rnu

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*)}
