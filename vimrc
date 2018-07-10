syntax on


" Color scheme (terminal)
let g:airline_theme='badwolf'

colorscheme space-vim-dark
hi Comment guifg=#5C6370 ctermfg=59
set background=dark
set t_Co=256

set guifont=Fira\ Code:h12

if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" indentation lines
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

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
nmap k gk
nmap j gj

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
Plug 'janko-m/vim-test'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'liuchengxu/space-vim-dark'
Plug 'mileszs/ack.vim'
Plug 'nathanaelkane/vim-indent-guides'  

call plug#end()

let mapleader = ","
map <leader>so :source $MYVIMRC<CR>
map <leader>r :!resize<CR><CR>

