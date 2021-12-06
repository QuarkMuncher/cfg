"" Plugins outside .vim
set rtp+=~/.fzf

"Environment Variables
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

"" Normal shit
set nocp                        "Not vi-compatibility mode pls
set t_8f=[38;2;%lu;%lu;%lum   "set foreground color
set t_8b=[48;2;%lu;%lu;%lum   "set background color
set t_Co=256                    "Enable 256 colors
set termguicolors               "Make the colors shine
colorscheme tender              "Pick a card
set background=dark             "Background explicitly set to dark for themes if applicable
set wildmenu                    "Nicer tab completion+bar
set wildmode=longest,full       "Command autocompletion extend to longest match and auto
set showcmd                     "Show info about last command etc
set autoindent                  "Keep indentation
set expandtab                   "Tabs are spaces
filetype plugin indent on       "Try to get indentation right depending on filetype
set shiftround                  "Round indents to n*shiftwidth
set shiftwidth=2                "(Auto)indentation is 4 spaces
set smarttab                    "Work properly with spaces as tabs
set tabstop=2                   "Tabs become n*tabstop spaces
set incsearch                   "Show search results as you are typing
set ignorecase                  "Case insensitive search
set smartcase                   "Case sensitive search when using capitals
set scrolloff=5                 "Keep 5 lines above/below cursor
set sidescrolloff=5             "Keep 5 chars beside cursor
set nowrap                      "No line wrap
set ruler                       "Status line numbers
set relativenumber              "Line number shiz
set number                      "Line numbers; With relativenumber keep current linenumber
set noerrorbells                "SHUT UP
set title                       "Make console title useful
set hidden                      "Remember hidden buffers, just in case
set mouse=a                     "Mouse scroll and click to select
set autoread                    "Re-read changed files
set history=1000                "Undo history
set directory=~/.vim/swapdir    "Swapfile directory
set backupdir=~/.vim/backupdir  "Backup directory
set undodir=~/.vim/undodir      "Remember undos here
set undofile                    "Keep undofiles
set laststatus=2                "Keep filename visible
syntax enable                       "Syntax colouration
set clipboard=unnamedplus       " "+ for clipboard register
set cmdheight=2                 "More space for displaying messages
set updatetime=50               "Shorter delay, results in better experience
set shortmess+=c                "Don't pass messages to |ins-completion-menu|
set noshowmode                 "Hides the -- INSERT -- thing
highlight ColorColumn ctermbg=0 guibg=lightgrey

"Lightline config
let g:lightline = {
    \ 'colorscheme': 'OldHope',
    \ 'active': {
      \ 'left': [ [ 'mode', 'paste' ],
      \           [ 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ] ]
      \},
    \ 'component_function': {
      \ 'cocstatus': 'coc#status',
      \ 'currentfunction': 'CocCurrentFunction'
    \ }
\ }

"Remove background color gruvbox-fix
autocmd VimEnter * hi Normal ctermbg=NONE guibg=NONE
"Remove background from empty lines
"hi NonText guibg=NONE

""KeyMaps
nnoremap <SPACE> <Nop>
let mapleader=" "
map <Leader>e :Explore <CR>
nmap <Leader>o o<Esc>
nmap <Leader>O O<Esc>
nnoremap <C-N> :bnext<CR>
nnoremap <C-M> :bprev<CR>

"File shortcuts
map <Leader>p :Files<CR>
map <Leader>b :Buffers<CR>
map <Leader>f :Rg<CR>

"CoC
"GoTo code navigation.
nmap <Leader>gd <Plug>(coc-definition)
nmap <Leader>gy <Plug>(coc-type-definition)
nmap <Leader>gi <Plug>(coc-implementation)
nmap <Leader>gr <Plug>(coc-references)
nmap <Leader>rr <Plug>(coc-rename)
nmap <Leader>g[ <Plug>(coc-diagnostic-prev)
nmap <Leader>g] <Plug>(coc-diagnostic-next)
nmap <silent> <Leader>gp <Plug>(coc-diagnostic-prev-error)
nmap <silent> <Leader>gn <Plug>(coc-diagnostic-next-error)
nmap <Leader>gf <Plug>(coc-codeaction-selected)<CR>
nnoremap <Leader>cr :CocRestart

"CoC Navigate completion list
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Fix files on save
let g:ale_fixers = {}
let g:ale_javascript_eslint_use_global = 1
let g:ale_linters = {
  \'javascript': ['eslint'],
  \'typescript': ['tslint'],
  \'typescriptreact': ['eslint'],
  \'vue': ['eslint', 'stylelint', 'tsserver'],
\}
let g:ale_fixers = {
  \'javascript': ['eslint', 'prettier'],
  \'javascriptreact': ['eslint', 'prettier'],
  \'typescript': ['tslint', 'prettier'],
  \'typescriptreact': ['eslint', 'prettier'],
  \'vue': ['stylelint', 'eslint'],
\}

let g:ale_linters_explicit = 1
let g:ale_sign_column_always = 1
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_fix_on_save = 1

"Trim whitespace on save
fun! TrimWhitespace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfun

autocmd BufWritePre * :call TrimWhitespace()

"Rg Command
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)
