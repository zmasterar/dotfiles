" Vundle
set nocompatible  " be iMproved
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" Nerdtree
Bundle 'scrooloose/nerdtree'
" File fuzzy search
Bundle 'ctrlpvim/ctrlp.vim'
" Powerline
Bundle 'Lokaltog/vim-powerline'
" Vim theme solarized
Bundle 'altercation/vim-colors-solarized'
" Rails
Plugin 'tpope/vim-rails'

call vundle#end()
filetype plugin indent on

"For powerline
let g:Powerline_symbols = 'fancy'
set laststatus=2 

"Tab and spaces
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

set t_Co=256
noremap <silent> <c-s> :update<cr>
vnoremap <silent> <c-s> <c-c>:update<cr>
inoremap <silent> <c-s> <c-o>:update<cr>
command Q q
command W w
command WQ wq
command Wq wq
" Ctrl+n for Nerdtree
map <C-n> :NERDTreeToggle<CR>
