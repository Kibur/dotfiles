if has('autocmd')
    filetype plugin indent on " enable loading plugins by filetype
    augroup c
        autocmd BufReadPre,FileReadPre      *.c,*.h iabbrev /** /**<CR><BACKSPACE>*/<ESC>ka 
    augroup END
    augroup php
        autocmd BufReadPre,FileReadPre      *.php inoremap $this $this->
    augroup END
    augroup encrypted
        au!

        " First make sure nothing is written to ~/.viminfo while editing
        " an encrypted file.
        autocmd BufReadPre,FileReadPre      *.gpg set viminfo=
        
        " We don't want a various options which write unencrypted data to disk
        autocmd BufReadPre,FileReadPre      *.gpg set noswapfile noundofile nobackup

        " Switch to binary mode to read the encrypted file
        autocmd BufReadPre,FileReadPre      *.gpg set bin
        autocmd BufReadPre,FileReadPre      *.gpg let ch_save = &ch|set ch=2

        " (If you use tcsh, you may need to alter this line.)
        autocmd BufReadPost,FileReadPost    *.gpg '[,']!gpg --decrypt 2> /dev/null

        " Switch to normal mode for editing
        autocmd BufReadPost,FileReadPost    *.gpg set nobin
        autocmd BufReadPost,FileReadPost    *.gpg let &ch = ch_save|unlet ch_save
        autocmd BufReadPost,FileReadPost    *.gpg execute ":doautocmd BufReadPost " . expand("%:r")

        " Convert all text to encrypted text before writing
        " (If you use tcsh, you may need to alter this line.)
        autocmd BufWritePre,FileWritePre    *.gpg '[,']!gpg --default-recipient-self -ac 2>/dev/null

        " Undo the encryption so we are back in the normal text, directly
        " after the file has been written.
        autocmd BufWritePost,FileWritePost  *.gpg u
    augroup END
endif
if has('syntax') && !exists('g:syntax_on')
    syntax enable
endif

set complete-=i
set nrformats-=octal
set ttimeout
set ttimeoutlen=100
set noswapfile
set number " always show line numbers
set nowrap " don't wrap lines
set backspace=indent,eol,start " intuitive backspacing
set incsearch " highlight search matches as you type
set hlsearch " keep highlighting search matches
set showmode " always show current mode
set nocompatible " disable Vi-compatibility
set wildmenu " enhanced command line completion
set ruler " show the cursor wposition all the time
set lazyredraw
set lz
set hid
set softtabstop=4 " when hitting <BS>, pretend like a tab is removed, even if spaces
set tabstop=4 " a tab is four spaces
set shiftwidth=4 " number of spaces to use for autoindenting
set expandtab " expand tabs by default (overloadable per file type later)
set autoindent " always set autoidenting on
set smartindent " automatically indent after {
set cindent
set ai
set si
set cin
set mouse=a " enable use of the mouse for all modes
set numberwidth=6
set confirm " dialog asking for saving an edited file instead of failing
set encoding=utf-8 " necessary to show Unicode glyphs

if &listchars ==# 'eol:S'
    set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

set autoread " auto read when file is changed from outside
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2 " always show statusline

set cursorline " highlight line the cursor is on
hi CursorLine term=bold cterm=bold guibg=Grey40

" Code related
inoremap {<CR> {<CR>}<ESC>:call BC_AddChar("}")<CR>ko
inoremap { {}<ESC>:call BC_AddChar("}")<CR>i
"inoremap ( ()<ESC>:call BC_AddChar(")")<CR>i
inoremap [ []<ESC>:call BC_AddChar("]")<CR>i
imap <C-k> <ESC>:call search(BC_GetChar(), "W")<CR>:noh<CR>A

" Careless typing
iabbrev cant can't
iabbrev teh the
iabbrev hes he's
iabbrev shes she's
iabbrev thats that's
iabbrev dont don't
iabbrev havent haven't
iabbrev wasnt wasn't
iabbrev isnt isn't
iabbrev doesnt doesn't
iabbrev whats what's
iabbrev didnt didn't
iabbrev couldnt couldn't
iabbrev shouldnt shouldn't

" I admit it's not my vimrc
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

" French diacritics and ligatures
fu! FixLatin()
    :%s/Œ/\&OElig;/
    :%s/œ/\&oelig;/
    :%s/Ÿ/\&Yuml;/
    :%s/À/\&Agrave;/
    :%s/Â/\&Acirc;/
    :%s/Ä/\&Auml;/
    :%s/Æ/\&AElig;/
    :%s/Ç/\&Ccedil;/
    :%s/È/\&Egrave;/
    :%s/É/\&Eacute;/
    :%s/Ê/\&Ecirc;/
    :%s/Ë/\&Euml;/
    :%s/Î/\&Icirc;/
    :%s/Ï/\&Iuml;/
    :%s/Ô/\&Ocirc;/
    :%s/Ö/\&Ouml;/
    :%s/Ù/\&Ugrave;/
    :%s/Û/\&Ucirc;/
    :%s/Ü/\&Uuml;/
    :%s/à/\&agrave;/
    :%s/â/\&acirc;/
    :%s/ä/\&auml;/
    :%s/æ/\&aelig;/
    :%s/ç/\&ccedil;/
    :%s/è/\&egrave;/
    :%s/é/\&eacute;/
    :%s/ê/\&ecirc;/
    :%s/ë/\&euml;/
    :%s/î/\&icirc;/
    :%s/ï/\&iuml;/
    :%s/ô/\&ocirc;/
    :%s/ö/\&ouml;/
    :%s/ù/\&ugrave;/
    :%s/û/\&ucirc;/
    :%s/ü/\&uuml;/
    :%s/ÿ/\&yuml;/
endfunction

nnoremap ; :

execute pathogen#infect()

" Allow color schemes to do bright colors without forcing bold
if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
    set t_Co=16
endif

" Theme
if has('gui_running')
    colorscheme elflord
else
    "set background=dark
    "colorscheme solarized
endif

"let g:syntastic_mode_map = { 'mode': 'passive',     
"                          \ 'active_filetypes': [],     
"                          \ 'passive_filetypes': [] } 
"let g:syntastic_auto_loc_list=1     
nnoremap <silent> <F5> :lnext<CR>
nnoremap <silent> <F6> :lprev<CR>
nnoremap <silent> <C-Space> :ll<CR>

" alt -> and <- to cycle window panes
nnoremap <silent> <A-Right> :wincmd l<CR>
nnoremap <silent> <A-Left> :wincmd h<CR>
nnoremap <silent> <A-Up> :wincmd k<CR>
nnoremap <silent> <A-Down> :wincmd j<CR>
inoremap <silent> <A-Right> <ESC>:wincmd l<CR>
inoremap <silent> <A-Left> <ESC>:wincmd h<CR>
inoremap <silent> <A-Up> <ESC>:wincmd k<CR>
inoremap <silent> <A-Down> <ESC>:wincmd j<CR>

" ctrl + alt -> and <- move the window panes
nnoremap <silent> <C-A-Right> :wincmd L<CR>
nnoremap <silent> <C-A-Left> :wincmd H<CR>
nnoremap <silent> <C-A-Up> :wincmd K<CR>
nnoremap <silent> <C-A-Down> :wincmd J<CR>
inoremap <silent> <C-A-Right> <ESC>:wincmd L<CR>
inoremap <silent> <C-A-Left> <ESC>:wincmd H<CR>
inoremap <silent> <C-A-Up> <ESC>:wincmd K<CR>
inoremap <silent> <C-A-Down> <ESC>:wincmd J<CR>

" jDaddy JSON pretty print
nmap <F9> gqaj

" Propesr selection with shift + arrow
nmap <S-Up> v
nmap <S-Down> v

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" GCC compiler C++ version setup for syntax checker
let g:syntastic_cpp_compiler = 'gcc'
let g:syntastic_cpp_compiler_options = '-std=c++14 -stdlib=libc++'

set rnu

" Enable/Disable Hex Editor Mode
command Hex :%!xxd
command Norm :%!xxd -r

" Encrypt file with GPG
command Crypto execute ':!gpg -ao ' . expand("%:r") . '.gpg -c ' . expand("%:p")

" Extra C++ shit
syn keyword cppType local_persist internal_var internal_function global_var constant_var r32 r64 ubyte uint ulong i8 u8 i32 u32 i64 u64 i16 u16 b32

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*)}
