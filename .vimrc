" vundle begin
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'bling/vim-airline'

Plugin 'terryma/vim-multiple-cursors'

Plugin 'Yggdroot/indentLine'

" Plugin 'nvie/vim-flake8'

Plugin 'airblade/vim-gitgutter'

Plugin 'scrooloose/nerdtree'

Plugin 'scrooloose/syntastic'

Plugin 'kshenoy/vim-signature'

Plugin 'scrooloose/nerdcommenter'

" Plugin 'jistr/vim-nerdtree-tabs'

" Plugin 'scrooloose/nerdtree'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" vundle end

" change the mapleader from \ to ,
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file 
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
" map <leader>bd :Bclose<cr>
map <leader>bd :bdelete<cr>

" Close all the buffers
map <leader>ba :1,1000 bd!<cr>

" Opens a new buffer with the current buffer's path
map <leader>bs :sp <c-r>=expand("%:p:h")<cr>/
map <leader>bv :vs <c-r>=expand("%:p:h")<cr>/
map <leader>be :e <c-r>=expand("%:p:h")<cr>/

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>t<leader> :tabnext<cr>

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()


" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry
" Remember info about open buffers on close
set viminfo^=%


" Colors
syntax enable
set background=dark
let g:solarized_termcolors=256
let g:solarized_termtrans = 1
colorscheme solarized

" Spaces & Tabs
set number              " line number
set tabstop=4           " number of visual spaces per TAB
set shiftwidth=4        " To change the number of space characters inserted for indentation
set softtabstop=4       " number of spaces in tab when editing
set expandtab           " tabs are spaces
set smartindent
set autoindent          " align the new line indent with the previous line
autocmd FileType python setlocal et sta sw=4 sts=4 
                        " convert tab to space

" UI Config
set showcmd             " show command in bottom bar
set cursorline          " highlight current line
filetype indent on      " load filetype-specific indent files
set wildmenu            " visual autocomplete for command menu
set showmatch           " highlight matching [{()}]

" Searching
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
nnoremap <leader><space> :nohlsearch<CR>    
                        " turn off search highlight   "<leader>space"
set ignorecase smartcase    " auto ignorecase when search

" Folding
set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
nnoremap <space> za
                        " space open/closes folds
set foldmethod=indent   " fold based on indent level

" Movement
nnoremap j gj
nnoremap k gk
                        "move vertically by visual line
nnoremap gV `[v`]
                        " highlight last inserted text

" allow backspacing over everything in insert mode 
" Configure backspace so it acts as it should act
set backspace=indent,eol,start
" set whichwrap+=<,>,h,l


" air line
set laststatus=2
" let g:airline#extensions#tabline#enabled = 1

set fileencodings=ucs-bom,utf-8,cp936,gb18030,gb2312,gbk,big5,euc-jp,euc-kr,latin1

" Uncomment the following to have Vim jump to the last position when
" " reopening a file
if has("autocmd")
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
endif

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  set backupdir=~/.vim_backup,.,/tmp
  set undofile		" keep an undo file (undo changes after closing)
  set undodir=~/.vim_undo,.,/tmp
endif

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" 关键字补全
"   即简单地补全到文档中已有的词，快捷键为 Ctrl-N 或 Ctrl-P。
" 智能补全
"   Vim 7中引入 Omni Complete，可根据语义补全，快捷键为 Ctrl-X Ctrl-O。
"让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
set completeopt+=longest
"离开插入模式后自动关闭预览窗口
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
"回车即选中当前项
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"

" To make vsplit put the new buffer on the right of the current buffer:
set splitright
" Similarly, to make split put the new buffer below the current buffer:
set splitbelow

" vim-flake8
"let g:flake8_show_quickfix=0  " don't show
"let g:flake8_show_in_gutter=1
"let g:flake8_show_in_file=1
"autocmd BufWritePost *.py call Flake8()

" vim-gitgutter
let g:gitgutter_map_keys = 0

" vim airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" the minimum number of screen lines that you would like above and below the cursor.
:set scrolloff=5

" make search results appear in the middle of the screen
:nnoremap n nzz
:nnoremap N Nzz
:nnoremap * *zz
:nnoremap # #zz
:nnoremap g* g*zz
:nnoremap g# g#zz

" 禁止折行
" set nowrap

" plugin:nerdcommenter config
let NERDSpaceDelims=1

" Quickly insert parenthesis/brackets/etc.:
inoremap $1 ()<esc>i
inoremap $2 []<esc>i
inoremap $3 {}<esc>i
inoremap $4 {<esc>o}<esc>O
inoremap $q ''<esc>i
inoremap $e ""<esc>i
inoremap $t <><esc>i
