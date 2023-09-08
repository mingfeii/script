set hlsearch
set guioptions+=m

set showmatch
set guifont=Consolas

colorscheme desert

call plug#begin('~/.vim/plugged')

" SystemVerilog 插件
Plug 'leafgarland/typescript-vim' " 该插件提供了对 SystemVerilog 的语法高亮和缩进支持
Plug 'vim-scripts/verilog_systemverilog.vim' " 该插件提供了 SystemVerilog 的语法文件

call plug#end()


" SystemVerilog 插件配置
let g:tsuquyomi_disable_quickfix = 1 " 禁用 quickfix 功能，避免与 Syntastic 冲突

set tabstop=4
set shiftwidth=4
set expandtab

call plug#begin('~/.vim/plugged')

" 插件列表
Plug 'Raimondi/delimitMate' " delimitMate 插件

call plug#end()


call plug#begin('~/.vim/plugged')

Plug 'Valloric/YouCompleteMe'

Plug 'preservim/nerdtree'


" 在这里添加其他插件

call plug#end()

" 在 ~/.vimrc 中添加以下配置
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py'
let g:ycm_key_invoke_completion = '<C-Space>'
set nomousehide
