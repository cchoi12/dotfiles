syntax on

" Color scheme (terminal)
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
let g:airline_symbols = {}
endif
" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

set guifont=Inconsolata:h14.00 "best font ever
"ignored directories which command-t will use too. Make sure _build is in here
set wildignore=*.o,*.obj,.git,node_modules/**,bower_components/**,**/node_modules/**,_build/**,deps/**

"color scheme
colorscheme space-vim-dark
hi Comment guifg=#5C6370 ctermfg=59
set background=dark
set t_Co=256

set guifont=Fira\ Code:h12

"change cursor shape when in insert or visual mode
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" stop using arrow keys, dammit
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

inoremap <Up> <nop>
inoremap <Down> <nop>
inoremap <Left> <nop>
inoremap <Right> <nop>

" word wrap more excellently
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" convenient copy paste
vmap <C-x> :!pbcopy<CR>
vmap <C-c> :w !pbcopy<CR><CR>

" control + use homerow move panes
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" tabs to 2 spaces
set expandtab
set shiftwidth=2
set softtabstop=2
set showmatch

" set relative number
set number

" avoid e!
set autoread

" aliases
ca tt tabnew

" get rid of annoying banner for netrw
let g:netrw_banner = 0

" show . files
let NERDTreeShowHidden=1

" enter messages
set cmdheight=2

" ag searching
let g:ackprg = 'ag --vimgrep --smart-case'
cnoreabbrev ag Ack
cnoreabbrev aG Ack
cnoreabbrev Ag Ack
cnoreabbrev AG Ack

" fzf file fuzzy search
nnoremap <C-p> :FZF<CR>

" highlight the status bar when in insert mode
au InsertEnter * hi StatusLine ctermfg=235 ctermbg=2
au InsertLeave * hi StatusLine ctermbg=240 ctermfg=12

" Remove trailing whitespaces on save for only .rb files
function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction
autocmd BufWritePre *.{rb,ex,exs} :call TrimWhiteSpace()

" set spell check for only markdown files
autocmd BufRead,BufNewFile *.md setlocal spell

" Linter color
highlight ALEWarning cterm=underline ctermfg=DarkMagenta

" illuminate underline
let g:Illuminate_highlightUnderCursor = 0
hi illuminatedWord cterm=reverse gui=underline ctermbg=Black ctermfg=LightGreen

" NERDtree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-e> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


" Remap control+n to tab when word
" allows tab indention on empty/newlines.
" allows tab to cycle through word suggestions
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>

call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tmhedberg/matchit'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'liuchengxu/space-vim-dark'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-dispatch'
Plug 'RRethy/vim-illuminate'
Plug 'scrooloose/nerdtree'
Plug 'wakatime/vim-wakatime'
Plug 'mhinz/vim-mix-format'
Plug 'slashmili/alchemist.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'yuttie/comfortable-motion.vim'

call plug#end()

let mapleader = ","
map <leader>so :source $MYVIMRC<CR>
map <leader>r :!resize<CR><CR>

"run tests right from vim - super helpful
nnoremap <Leader>mt :Mix test --trace %<CR>

"on save format elixir code
let g:mix_format_on_save = 1

" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL
