" Vundle
set nocompatible  " be iMproved
filetype off

" Show line numbers
set number
set relativenumber

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" Nerdtree
Bundle 'scrooloose/nerdtree'
" File fuzzy search
Bundle 'ctrlpvim/ctrlp.vim'
" Airline/Powerline
Bundle 'vim-airline/vim-airline'
" Airline themes
Plugin 'vim-airline/vim-airline-themes'
" Vim theme solarized
Bundle 'altercation/vim-colors-solarized'
" Rails
Plugin 'tpope/vim-rails'
" Fugitive
Plugin 'tpope/vim-fugitive'

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

" Center when scrolling
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

set t_Co=256
noremap <silent> <c-s> :update<cr>
vnoremap <silent> <c-s> <c-c>:update<cr>
inoremap <silent> <c-s> <c-o>:update<cr>
" command Q q
" command W w
" command WQ wq
" command Wq wq
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!
" Ctrl+n for Nerdtree
map <C-b> :NERDTreeToggle<CR>
" Powerline fonts for airline
let g:airline_powerline_fonts = 1
let g:airline_theme='simple'
