" Load Pathogen plugin manager
execute pathogen#infect()

syntax on
set number

filetype plugin indent on

" Terraform configuration
let g:terraform_align=1
let g:terraform_fmt_on_save=1
autocmd BufRead,BufNewFile *.hcl set filetype=terraform

