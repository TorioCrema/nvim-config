call plug#begin('~/.local/share/nvim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'petRUShka/vim-sage'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'machakann/vim-sandwich'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'rafi/awesome-vim-colorschemes'
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
	return '  '.l:bufnr."  ".winnr().' '
endfunction

function! FileType() abort
	let l:f = WebDevIconsGetFileTypeSymbol()
	return ''.expand('%:p:t').' '.l:f.''
endfunction

function! GitBranch() abort
	let _ = FugitiveHead()
	return strlen(_) ? _.'  ' : ''
endfunction

let g:airline#extensions#tabline#enabled = 1
"let g:airline_theme='raven'
"let g:airline_theme='jet'
"let g:airline_theme='atomic'
"let g:airline_theme='desertink'
"let g:airline_theme='monochrome'
"let g:airline_theme='peaksea'
"let g:airline_theme='solarized'
"let g:airline_theme='term'
let g:airline_theme='violet'

function! AirlineInit()
    let g:airline_section_a = airline#section#create(['mode',' ','branch'])
    let g:airline_section_b = airline#section#create_left(['ffenc','hunks','%f'])
    let g:airline_section_c = airline#section#create(['filetype'])
    let g:airline_section_x = airline#section#create(['%P'])
    let g:airline_section_y = airline#section#create(['%B'])
    let g:airline_section_z = airline#section#create_right(['%l', '%c'])
endfunction
autocmd VimEnter * call AirlineInit()

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" Use <c-space> to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty='⚡'

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
colorscheme dogrun

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
let g:coc_global_extensions = [
            \ 'coc-json',
            \ 'coc-clangd'
            \]
