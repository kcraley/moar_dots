" Load Pathogen plugin manager
execute pathogen#infect()

syntax on
set number
set list
set expandtab
set tabstop=4
set shiftwidth=4
retab

filetype plugin indent on

" NERDTree configuration
let NERDTreeShowHidden=1

" Terraform configuration
let g:terraform_align=1
let g:terraform_fmt_on_save=1
autocmd BufRead,BufNewFile *.hcl set filetype=terraform

" NERDTree configuration
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

