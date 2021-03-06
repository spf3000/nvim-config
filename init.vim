" - VIM PLUG
call plug#begin()

" Map the leader key to SPACE
let mapleader = " "

" ctags stuff
set tags=.tags
let g:autotagTagsFile=".tags"

map <C-i> :TagbarToggle<CR>

" Regenerate tags file
map <leader>r :!ctags -R -f ./.tags .<CR>

"manual folding
setlocal foldmethod=manual

" autotag plugin to automatically generate ctags file
Plug 'craigemery/vim-autotag'

" FZF / Ctrlp for file navigation
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Ripgrep for file indexing, sort of faster, but not really, but also why not use ripgrep for everything
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --no-messages "" .'
  set grepprg=rg\ --vimgrep
endif

let g:python_host_prog  = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

"" SBT server
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

augroup filetype_scala
    autocmd!
    autocmd BufReadPost *.scala setlocal filetype=scala
augroup END

Plug 'tpope/vim-abolish'



" A dependency of 'ncm2'.
Plug 'roxma/nvim-yarp'

" v2 of the nvim-completion-manager.
Plug 'ncm2/ncm2'

autocmd BufEnter  *  call ncm2#enable_for_buffer()

" This will show the popup menu even if there's only one match (menuone),
" prevent automatic selection (noselect) and prevent automatic text injection
" into the current line (noinsert).
set completeopt=noinsert,menuone,noselect

" NOTE: you need to install completion sources to get completions. Check
" our wiki page for a list of sources: https://github.com/ncm2/ncm2/wiki
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-tmux'
Plug 'ncm2/ncm2-path'



"togglelist - toggle quickfix list with leader-q
let g:toggle_list_no_mappings = 1
nmap <script> <silent> <leader>q :call ToggleQuickfixList()<CR>

" Use FZF for files and tags if available, otherwise fall back onto CtrlP
" <leader>\ will search for tag using word under cursor
let g:fzf_command_prefix = 'Fzf'
if executable('fzf')
  nnoremap <leader>f :FzfFiles<cr>
  nnoremap <leader>t :FzfTags<cr>
  nnoremap <leader>u :call fzf#vim#tags("'".expand('<cword>'))<cr>
else
  nnoremap <leader>f :CtrlP<Space><cr>
  nnoremap <leader>t :CtrlPTag<Space><cr>

endif

let g:tagbar_type_scala = {
    \ 'ctagstype' : 'scala',
    \ 'sro'        : '.',
    \ 'kinds'     : [
      \ 'p:packages',
      \ 'T:types:1',
      \ 't:traits',
      \ 'o:objects',
      \ 'O:case objects',
      \ 'c:classes',
      \ 'C:case classes',
      \ 'm:methods',
      \ 'V:values:1',
      \ 'v:variables:1'
    \ ]
\ }


" Remap <tab> to allow cycling through the deoplete list, but only when the
" completion list window is open. Leave <tab> alone the rest of the time.
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"


" Here's the complete list of my neovim plugins, in case you're interested
" General
Plug 'scrooloose/nerdcommenter'
Plug 'bronson/vim-trailing-whitespace'
Plug 'tpope/vim-unimpaired'
Plug 'godlygeek/tabular'
Plug 'sbdchd/neoformat'
Plug 'luochen1990/rainbow'
Plug 'justinmk/vim-sneak'
Plug 'embear/vim-localvimrc'
Plug 'cloudhead/neovim-fuzzy'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'milkypostman/vim-togglelist'
Plug 'Chiel92/vim-autoformat'

let g:rainbow_active = 0 "0 if you want to enable it later via :RainbowToggle 1 to enable by default

" Tags
Plug 'majutsushi/tagbar'
Plug 'craigemery/vim-autotag'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'


" Language plugins
" Scala plugins
"if executable('scalac')
Plug 'derekwyatt/vim-scala'
"endif

"colorscheme
Plug 'flazz/vim-colorschemes'
Plug 'Badacadabra/vim-archery', { 'as': 'archery' }
call plug#end()

" Always draw sign column. Prevent buffer moving when adding/deleting sign.
set signcolumn=yes

let g:LanguageClient_serverCommands = {
    \ 'scala': ['node', expand('/usr/local/bin/sbt-server-stdio.js')],
    \ }


"Language Client
 nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" LOOK AND SYNTAX HILIGHTING {{{
"fix for mac terminal colors going weird
    if $TERM =~ '^\(xterm\|interix\|putty\)\(-.*\)\?$'
        set notermguicolors
    else
        set termguicolors
        endif

syntax enable
set background=dark
set t_Co=256

inoremap <A-j> <Esc>:m .+1<CR>==gi
colorscheme base16-railscasts

" clear search highlighting with escape
nnoremap <silent> <Esc> :let @/=""<CR>

" format json with =j
nmap =j :%!python -m json.tool<CR>

"shortcut to move physical lines Alt-j and Alt-k
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" change vim scroll keys
nnoremap <C-J> <C-D>
nnoremap <C-K> <C-U>

" change jump to definition
nnoremap <leader>. <C-]>
nnoremap <leader>, <C-T>

" easier split navigations
nnoremap <leader>j <C-W><C-J>
nnoremap <leader>k <C-W><C-K>
nnoremap <leader>l <C-W><C-L>
nnoremap <leader>h <C-W><C-H>


" airline
set laststatus=2
let g:airline_left_sep=""
let g:airline_left_alt_sep="|"
let g:airline_right_sep=""
let g:airline_right_alt_sep="|"
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " show tab number not number of split panes
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#hunks#enabled = 0
