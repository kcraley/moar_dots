" Load Pathogen plugin manager
execute pathogen#infect()

syntax on
set number
set list

filetype plugin indent on

" NERDTree configuration
let NERDTreeShowHidden=1

" Terraform configuration
let g:terraform_align=1
let g:terraform_fmt_on_save=1
autocmd BufRead,BufNewFile *.hcl set filetype=terraform

