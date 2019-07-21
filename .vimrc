syntax on

" Color scheme (terminal)
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
" old vim-powerline symbols
let g:airline_left_sep = '⮀'
let g:airline_left_alt_sep = '⮁'
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'
let g:airline_symbols.branch = '⭠'
let g:airline_symbols.readonly = '⭤'
let g:airline_symbols.linenr = '⭡'
let g:airline#extensions#tabline#left_sep = '⮀'
let g:airline#extensions#tabline#left_alt_sep = '⮁'
let g:airline#extensions#tabline#right_sep = '⮂'
let g:airline#extensions#tabline#right_alt_sep = '⮃'

"ignored directories which command-t will use too. Make sure _build is in here
set wildignore=*.o,*.obj,.git,node_modules/**,bower_components/**,**/node_modules/**,_build/**,deps/**
set guifont=Fira\ Code:h12

" bind c-x c-o to control space
imap <c-space> <c-x><c-o>

" quickly open buffers
nnoremap <leader>bb :buffers<cr>:b<space>
" quick toggle most recent buffers
nnoremap <leader><tab> :b#<cr>

" Syntax toggle
nnoremap <silent> <Leader>qq
             \ : if exists("syntax_on") <BAR>
             \    syntax off <BAR>
             \ else <BAR>
             \    syntax enable <BAR>
             \ endif<CR>

"change cursor shape when in insert or visual mode
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Trailing Whitespace
set listchars=tab:>\ ,trail:•,extends:>,precedes:<,nbsp:+
set list
nmap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Cursor
set cursorline

" Add binding.pry
nnoremap <silent> gb :let a='binding.pry'\|put=a<cr>

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

" live reload files if it changes on disk
set autoread
augroup vimrc_autocmd
  autocmd!
  "toggle quickfix window
  autocmd BufReadPost quickfix map <buffer> <leader>qq :cclose<cr>|map <buffer> <c-p> <up>|map <buffer> <c-n> <down>

  autocmd FileType unite call s:unite_settings()
  " obliterate unite buffers (marks especially).
  autocmd BufLeave \[unite\]* if "nofile" ==# &buftype | setlocal bufhidden=wipe | endif

  " Jump to the last position when reopening a file
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

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

" Add a line at col 80 for wrap
set colorcolumn=80

" set relative number
set relativenumber
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

" formatter set to config
let g:editorconfig_Beautifier = '~/.editorconfig'
".vimrc
map <Leader>f :call JsBeautify()<cr>
" or
autocmd FileType javascript noremap <buffer> <Leader>f :call JsBeautify()<cr>
" for json
autocmd FileType json noremap <buffer> <Leader>f :call JsonBeautify()<cr>
" for jsx
autocmd FileType jsx noremap <buffer> <Leader>f :call JsxBeautify()<cr>
" for html
autocmd FileType html noremap <buffer> <Leader>f :call HtmlBeautify()<cr>
" for css or scss
autocmd FileType css noremap <buffer> <Leader>f :call CSSBeautify()<cr>

" ag searching
let g:ackprg = 'ag --vimgrep --smart-case'
cnoreabbrev ag Ack
cnoreabbrev aG Ack
cnoreabbrev Ag Ack
cnoreabbrev AG Ack

" fzf file fuzzy search that respects .gitignore
" Use :GFiles with these flags which essentially take any file that, is
" tracked, staged, or appears as untracked in `git status`, resulting in
" annoying directories like "deps" or "_build" being included in <C-p> results
" It will also include results that wouldn't otherwise have been included such
" as .circleci/config.yml
nnoremap <C-p> :GFiles --exclude-standard --others --cached<CR>

" highlight the status bar when in insert mode
au InsertEnter * hi StatusLine ctermfg=235 ctermbg=2
au InsertLeave * hi StatusLine ctermbg=240 ctermfg=12

" Remove trailing whitespaces on save for only rb, ex, exs files
function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction
autocmd BufWritePre *.{rb,ex,exs} :call TrimWhiteSpace()

" Linter color
highlight ALEWarning cterm=underline ctermfg=DarkMagenta

" illuminate underline
let g:Illuminate_highlightUnderCursor = 0
hi illuminatedWord cterm=reverse gui=underline ctermbg=Black ctermfg=LightGreen

" NERDtree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <silent> <C-e> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
nmap <Leader>F :NERDTreeFind<CR>

"inoremap <tab> <c-r>=InsertTabWrapper()<cr>
let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
let g:SuperTabDefaultCompletionType = "context"

"OmniCompletion on all the time
filetype plugin on
set omnifunc=syntaxcomplete#Complete

" vim-rspec
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
let g:rspec_runner = "os_x_iterm2"

" emmet
" let g:user_emmet_leader_key=','

" Flutter
nnoremap <leader>fr :FlutterRun<cr>
nnoremap <leader>fq :FlutterQuit<cr>
nnoremap <leader>fh :FlutterHotReload<cr>
nnoremap <leader>fR :FlutterHotRestart<cr>
nnoremap <leader>fD :FlutterVisualDebug<cr>

call plug#begin('~/.vim/plugged')

" Fuzzy Search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'ervandew/supertab'

" Language
Plug 'tmhedberg/matchit'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'pangloss/vim-javascript'
Plug 'mattn/emmet-vim'
Plug 'dart-lang/dart-vim-plugin'
Plug 'thosakwe/vim-flutter'

" Visual
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'cocopon/iceberg.vim'
Plug 'scrooloose/nerdtree'
Plug 'wakatime/vim-wakatime'
Plug 'ap/vim-css-color'

" Movement
Plug 'christoomey/vim-tmux-navigator'
Plug 'Valloric/MatchTagAlways'
Plug 'maksimr/vim-jsbeautify'
Plug 'cohama/lexima.vim'

call plug#end()

set background=dark
set t_Co=256
colorscheme iceberg

"match it highlight color
let g:mta_use_matchparen_group = 0
let g:mta_set_default_matchtag_color = 0
highlight MatchTag ctermfg=black ctermbg=lightgreen guifg=black guibg=lightgreen
nnoremap <leader>% :MtaJumpToOtherTag<cr>

let mapleader = ","
map <leader>so :source $MYVIMRC<CR>
map <leader>r :!resize<CR><CR>
map <leader>c :!ctags -R --languages=ruby --exclude=.git --exclude=log --tag-relative=yes -f tags . $(bundle list --paths)<CR>
map <Leader>vi :tabe ~/.vimrc<CR>

"run tests right from vim - super helpful
nnoremap <Leader>mt :Mix test --trace %<CR>

"on save format elixir code
let g:mix_format_on_save = 1

" Ale off by default
let g:ale_enabled = 0

" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL
