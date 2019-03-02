" prevent loading of default config
let skip_defaults_vim=1

" set leader key to spacebar
let mapleader="\<Space>"

" use tab to escape
inoremap <TAB> <ESC>
vnoremap <TAB> <ESC>

" move current line up & down
nnoremap <C-j> :m+<CR>
nnoremap <C-k> :m-2<CR>

" expand selection by paragraph
vnoremap <S-j> }
vnoremap <S-k> {

" togglable whitespace visibility
nnoremap <Leader><CR> :set list!<CR>
set listchars=eol:┫,tab:┃\ ,trail:━,space:·
highlight SpecialKey ctermfg=red
highlight NonText ctermfg=red

" prevent backspacing over start of insertion and start of line
set backspace=indent

" set line length for wrapping
set textwidth=80

" prevent automatic wrapping
set fo-=t

" show line numbers
set number

" show visual selection size
set showcmd

" highlight current line
set cursorline
highlight CursorLine cterm=NONE ctermbg=237

" show cursor position
set ruler

" highlight trailing whitespace
highlight TrailingWhitespace ctermbg=red
match TrailingWhitespace /\s\+$/
autocmd InsertEnter * highlight TrailingWhitespace ctermbg=None
autocmd InsertLeave * highlight TrailingWhitespace ctermbg=red

" use 4-width tabs
set tabstop=4 shiftwidth=4
set noexpandtab

" enable syntax highlighting
syntax on

" set character encoding
set encoding=utf-8
