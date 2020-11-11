set nocompatible

set hidden
set nobackup
set noswapfile

syntax on

nnoremap <silent> <Leader>0
             \ : if exists("syntax_on") <BAR>
             \    syntax off <BAR>
             \ else <BAR> \    syntax enable <BAR>
             \ endif<CR>

" Console log from insert mode; Puts focus inside parentheses
imap cll console.log()<Esc><S-f>(a
" Console log from visual mode on next line, puts visual selection inside parentheses
vmap cll yocll<Esc>p
" Console log from normal mode, inserted on next line with word your on inside parentheses
nmap cll yiwocll<Esc>p

filetype plugin on
set omnifunc=syntaxcomplete#Complete

filetype plugin indent on

set re=1
let ruby_no_expensive=1
set ttyfast
set lazyredraw

let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

" Cursor
set cursorline

" Trailing Whitespace
set listchars=tab:>\ ,trail:•,extends:>,precedes:<,nbsp:+
set list
nmap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Maximize/Minimize pane
nnoremap <C-W>M <C-W>\| <C-W>_
nnoremap <C-W>m <C-W>=

" stop using arrow keys, dammit
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

inoremap <Up> <nop>
inoremap <Down> <nop>
inoremap <Left> <nop>
inoremap <Right> <nop>

" convenient copy paste
vmap <C-x> :!pbcopy<CR>
vmap <C-c> :w !pbcopy<CR><CR>

" control + use homerow move panes
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-l> :wincmd l<CR>

" Vim Tmux
let tmux_navigator_no_mappings = 1
if has('vim_starting')
  if &rtp =~ '\<tmux-navigator\>'
    nnoremap <silent> <c-a><c-h> :TmuxNavigateLeft<cr>
    nnoremap <silent> <c-a><c-j> :TmuxNavigateDown<cr>
    nnoremap <silent> <c-a><c-k> :TmuxNavigateUp<cr>
    nnoremap <silent> <c-a><c-l> :TmuxNavigateRight<cr>
  else
    nnoremap <C-h> <c-w>h
    nnoremap <C-j> <c-w>j
    nnoremap <C-k> <c-w>k
    nnoremap <C-l> <c-w>l
  endif
endif

" tabs to 2 spaces
set expandtab
set shiftwidth=2
set softtabstop=2
set showmatch

" set relative number
set relativenumber
set number

" aliases
ca tt tabnew

" show . files
let NERDTreeShowHidden=1

" enter messages
set cmdheight=2

map <Leader>f :call Prettier()

" ag searching
let g:ackprg = 'ag --vimgrep --smart-case'
cnoreabbrev ag Ack
cnoreabbrev aG Ack
cnoreabbrev Ag Ack
cnoreabbrev AG Ack

" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

" Splits
set splitbelow
set splitright

" fzf file fuzzy search that respects .gitignore
" Use :GFiles with these flags which essentially take any file that, is
" tracked, staged, or appears as untracked in `git status`, resulting in
" annoying directories like "deps" or "_build" being included in <C-p> results
" It will also include results that wouldn't otherwise have been included such
" as .circleci/config.yml
nnoremap <C-p> :GFiles --exclude-standard --others --cached<CR>

" Remove trailing whitespaces on save for only rb, ex, exs files
function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction

" NERDtree
map <silent> <C-e> :NERDTreeToggle<CR>
nmap <Leader>F :NERDTreeFind<CR>

let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:ale_javascript_prettier_options = '--no-semi --single-quote --trailing-comma none'
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow

let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync

let g:jsx_ext_required = 1

let g:user_emmet_leader_key=','
"let g:user_emmet_settings = {
"  \  'javascript' : {
"    \      'extends' : 'jsx',
"    \  },
"    \ 'css': {
"    \      'extends': 'scss',
"    \  },
"  \}

call plug#begin('~/.vim/plugged')

" Fuzzy Search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'ajh17/VimCompletesMe'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

" Utility
Plug 'tpope/vim-dispatch'
Plug 'scrooloose/nerdtree'
Plug 'mattn/emmet-vim'
Plug 'wakatime/vim-wakatime'
Plug 'epilande/vim-react-snippets'
Plug 'SirVer/ultisnips'


" Language
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

" Visual
Plug 'ap/vim-css-color'

" Movement
Plug 'christoomey/vim-tmux-navigator'
Plug 'Valloric/MatchTagAlways'
Plug 'jiangmiao/auto-pairs'
Plug 'justinmk/vim-sneak'

call plug#end()

set background=dark
set t_Co=256
colorscheme iceberg

augroup vimrc_autocmd
  autocmd!

  autocmd BufWritePre *.{rb,ex,exs} :call TrimWhiteSpace()

  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
  autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync
augroup end

"match it highlight color
let g:mta_use_matchparen_group = 0
let g:mta_set_default_matchtag_color = 0
highlight MatchTag ctermfg=black ctermbg=lightgreen guifg=black guibg=lightgreen
nnoremap <leader>% :MtaJumpToOtherTag<cr>

let mapleader = ","
nnoremap <leader>b :ls<cr>:b<space>
map <leader>so :source $MYVIMRC<CR>
map <leader>nf :NERDTreeFind<CR>
map <leader>r :!resize<CR>
map <leader>c :!ctags -R --languages=ruby --exclude=.git --exclude=log --tag-relative=yes -f tags . $(bundle list --paths)<CR>
map <Leader>vi :tabe ~/.vimrc<CR>
map f <Plug>Sneak_s
map F <Plug>Sneak_S
let g:UltiSnipsExpandTrigger="<Leader>rc"
