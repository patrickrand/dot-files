set nocompatible             
filetype off 
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'fatih/vim-go'
call vundle#end()    

set shell=/bin/zsh
filetype plugin indent on 
set wildmode=longest,list
syntax enable  
set number  
set tabstop=4 shiftwidth=4 expandtab

"nnoremap <leader>r :w<CR>:GoBuild<CR>
:map <leader>[ :w<CR>:GoBuild<CR>
