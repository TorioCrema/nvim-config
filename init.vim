call plug#begin('~/.local/share/nvim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'petRUShka/vim-sage'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'rafi/awesome-vim-colorschemes'
Plug 'machakann/vim-sandwich'
Plug 'itchyny/lightline.vim'
Plug 'vim-scripts/vim-webdevicons'
Plug 'tpope/vim-fugitive'
Plug 'cohama/lexima.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
    map <space>b :Buffers<CR>
    map <space>f :GFiles<CR>
    map <space>m :Marks<CR>
    map <space>l :Lines<CR>
    map <space>g :Rg<CR>
    map <space>t :BTags<CR>
    map <space>p :Tags<CR>
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }
    map <space>e :Clap filer<CR>
    map <space>j :Clap jumps<CR>
    map <space>w :Clap windows<CR>
    map <space>y :Clap yanks<CR>
Plug 'joshdick/onedark.vim',
call plug#end()

inoremap <silent><expr> <TAB>
\ pumvisible() ? "\<C-n>" :
\ <SID>check_back_space() ? "\<TAB>" :
\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! BufNr() abort
	let l:bufnr = bufnr('%')
	let l:bufnr = l:bufnr > 20 ? l:bufnr : nr2char(9311 + l:bufnr).' '
	return '  '.l:bufnr."  ".winnr().' '
endfunction

function! FileType() abort
	let l:f = WebDevIconsGetFileTypeSymbol()
	return ''.expand('%:p:t').' '.l:f.''
endfunction

function! GitBranch() abort
	let _ = FugitiveHead()
	return strlen(_) ? _.'  ' : ''
endfunction

" Lightline settings
let g:lightline = {
    \ 'colorscheme': 'onedark',
    \ 'active': {
    \   'left': [ [ 'bufnr' ],
    \           [ 'mode', 'paste' ],
    \           [ 'filetype', 'gitbranch', 'readonly', 'modified' ] ],
    \   'right': [ [ 'lineinfo' ],
    \            [ 'percent' ],
    \            [ 'fileencoding' ] ]
    \},
    \ 'inactive': {
    \   'left': [ [ 'bufnr' ],
    \             [ 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component_function': {
    \	  'bufnr': 'BufNr',
    \   'gitbranch': 'GitBranch',
    \   'filetype': 'FileType',
    \ },
    \ 'component': {
    \   'readonly': '%{&readonly?"":""}',
    \   'fileencoding' : '%{&fileencoding} %{WebDevIconsGetFileFormatSymbol()}'
    \ },
    \ 'separator': { 'left': '', 'right': '' },
    \ 'subseparator': { 'left': '', 'right': '' },
    \ 'mode_map': {
    \ 'n' : '<N>',
    \ 'i' : '<I>',
    \ 'R' : '<R>',
    \ 'v' : '<V>',
    \ 'V' : '<Vl>',
    \ "\<C-v>": '<Vb>',
    \ 'c' : '<C>',
    \ 's' : '<S>',
    \ 'S' : '<Sl>',
    \ "\<C-s>": '<Sb>',
    \ 't': '<T>',
    \ },
\ }

" Use <c-space> to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" Nvim behaviour
syntax on
filetype plugin on
set background=dark
set tabstop=4
set smartindent
set cindent
set softtabstop=4
set shiftwidth=4
set expandtab
set number
set splitbelow
set splitright
set noshowmode
set scrolloff=5
set nofoldenable
set number relativenumber
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes
set cursorline
colorscheme onedark

" Custom Shortcuts
nmap D d$
nmap Y y$
nmap H i<CR><Esc>
nmap gh ^
nmap gl $
nmap <space>v :vsplit term://$SHELL<CR>
nmap <space>x :split term://$SHELL<CR>
nmap <space>s $]}V[{
nmap <space>S ^V[{
nmap <space>ss :Startify<CR>
nmap <space>- :split<CR>
nmap <space>\ :vsplit<CR>
nmap <space>wl <C-W>l
nmap <space>wh <C-W>h
nmap <space>wj <C-W>j
nmap <space>wk <C-W>k
nmap <space>cc :CocCommand<CR>
nmap ]t :tabn<CR>
nmap [t :tabp<CR>

" Relative line numbers in normal mode, absolute line numbers in insert mode
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END

" Template for different files type
autocmd BufNewFile *.c 0r $HOME/.config/nvim/templates/t.c

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')


" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Automatic new line when enter is pressed after brackets
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


"Coc config
let g:coc_node_path = '/usr/bin/node'
let g:coc_global_extensions = [
            \ 'coc-json',
            \ 'coc-clangd',
            \ 'coc-java'
            \]
