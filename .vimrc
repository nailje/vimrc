
" Bundle Init

" Turn off filetype plugins before bundles init
filetype off
" Auto installing NeoNeoBundle
let isNpmInstalled = executable("npm")
let iCanHazNeoBundle=1
let neobundle_readme=expand($HOME.'/.vim/bundle/neobundle.vim/README.md')
if !filereadable(neobundle_readme)
    if !isNpmInstalled
        echo "==============================================="
        echo "Your need to install npm to enable all features"
        echo "==============================================="
    endif
    echo "Installing NeoBundle.."
    silent !mkdir -p $HOME/.vim/bundle
    silent !git clone https://github.com/Shougo/neobundle.vim $HOME/.vim/bundle/neobundle.vim
    let iCanHazNeoBundle=0
endif

" Call NeoBundle
if has('vim_starting')
    set runtimepath+=$HOME/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand($HOME.'/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

" Determine make or gmake will be used for making additional deps for Bundles
let g:make = 'gmake'
if system('uname -o') =~ '^GNU/'
    let g:make = 'make'
endif

"--------------------------------------------------
" Bundles

" Let NeoNeoBundle manage NeoNeoBundle
NeoBundle 'Shougo/neobundle.vim'

" Instlall vimrpoc. is uses by unite and neocomplcache
" for async searches and calls
NeoBundle 'Shougo/vimproc', {
\ 'build' : {
\     'mac' : 'make -f make_mac.mak',
\     'unix': g:make
\    },
\ }

NeoBundle 'Shougo/unite.vim'

" Most recent files source for unite
NeoBundle 'Shougo/neomru.vim'

" Statusline/ruler for vim
NeoBundle 'bling/vim-airline'

" Colorscheme
NeoBundle 'vim-scripts/wombat256.vim'
NeoBundle 'reedes/vim-colors-pencil'

" System explorer
NeoBundle 'scrooloose/nerdtree'

" Toggle cursor (terminal)
" NeoBundle 'jszakmeister/vim-togglecursor'

" Commands for comments like:
" gcc - Toggle comment for the current line
" gc -  Toggle comments for selected region or number of string
NeoBundle 'tomtom/tcomment_vim'

" clojure
NeoBundle 'guns/vim-clojure-static'
NeoBundle 'guns/vim-clojure-highlight'
NeoBundle 'tpope/vim-leiningen'
NeoBundle 'tpope/vim-projectionist'
NeoBundle 'tpope/vim-dispatch'
NeoBundle 'tpope/vim-fireplace'
NeoBundle 'guns/vim-sexp'
NeoBundle 'tpope/vim-sexp-mappings-for-regular-people'
NeoBundle 'tpope/vim-repeat'

" Command for remove/replace/add
"  dst - remove tag (<div>hello * world</div> -> hello * world) 
"  ds( - remove bracket,
"  cs)] - replace 
"  csw' (fo|o! -> 'foo'!)
"  csW' (fo|o! -> 'foo!')

NeoBundle 'tpope/vim-surround'

" Niji (Rainbow) is yet another rainbow parentheses plugin for Vim
NeoBundle 'amdt/vim-niji'

" Chord mappings
NeoBundle 'kana/vim-arpeggio'

" Nice start screen
NeoBundle 'mhinz/vim-startify'

call neobundle#end()


" Check NeoBundle 
NeoBundleCheck


"--------------------------------------------------
" Bundles settings


"--------------------------------------------------
" NERDte
"

" NERDTree to display hidden file on startup
let NERDTreeShowHidden=1

" Disable bookmarks label, and hint about '?'
let NERDTreeMinimalUI=1

" Display current file in the NERDTree on the left
nmap <silent> <leader>f :NERDTreeFind<CR>


"--------------------------------------------------
" Unite
"

" Set unite window height
let g:unite_winheight = 10

" Start unite in insert mode by default
let g:unite_enable_start_insert = 1

" Display unite on the bottom (or bottom right) part of the screen
let g:unite_split_rule = 'botright'

" Set short limit for max most recent files count.Tree
" It less unrelative recent files this way
let g:unite_source_file_mru_limit = 100

" Enable history for yanks
let g:unite_source_history_yank_enable = 1

" Make small limit for yank history,
let g:unite_source_history_yank_limit = 40

" Grep options Default for unite + supress error messages
let g:unite_source_grep_default_opts = '-iRHns'

let g:unite_source_rec_max_cache_files = 99999


" Hotkey for open window with most recent files
nnoremap <silent><leader>m :<C-u>Unite file_mru <CR>

" Hotkey for open history window
nnoremap <silent><leader>h :Unite -quick-match -max-multi-lines=2 -start-insert -auto-quit history/yank<CR>

" Quick tab navigation
nnoremap <silent><leader>' :Unite -quick-match -auto-quit tab<CR>

" Fuzzy find files
nnoremap <silent><leader>; :Unite file_rec/async:! -buffer-name=files -start-insert<CR>

" Unite-grep
nnoremap <silent><leader>/ :Unite grep:. -no-start-insert -no-quit -keep-focus -wrap<CR>



"--------------------------------------------------
" vim-airline

" Colorscheme for airline
let g:airline_theme='understated'

" Set custom left separator
let g:airline_left_sep = '▶'

" Set custom right separator
let g:airline_right_sep = '◀'

" Enable airline for tab-bar
let g:airline#extensions#tabline#enabled = 1

" Don't display buffers in tab-bar with single tab
let g:airline#extensions#tabline#show_buffers = 0

" Display only filename in tab
let g:airline#extensions#tabline#fnamemod = ':t'

" Don't display encoding
"let g:airline_section_y = ''

" Don't display filetype
"let g:airline_section_x = ''


"--------------------------------------------------
" Appeggio

" map jk to escape
call arpeggio#map('i', '', 0, 'jk', '<ESC>')


"--------------------------------------------------
" vim-startify
let g:startify_bookmarks=['~/.vimrc']
" let g:startify_custom_header = map(split(system('fortune | cowsay'), '\n'), '"   ". v:val') + ['','']

let g:startify_custom_header = 
    \ map(split(system('fortune ~/.vim/fortunes | cowsay -W 60'), '\n'), '"   ". v:val') + ['','']

"--------------------------------------------------
" Generic options

colorscheme wombat256mod
set nu

" Highlight line with cursor
set cursorline

" Highlight search results
set hlsearch

" Ignore case in search patterns
set ignorecase

" Override the 'ignorecase' option if the search patter ncontains upper case characters
set smartcase

" Live search. While typing a search command, show where the pattern
set incsearch

" Disable higlighting search result on Enter key
nnoremap <silent> <cr> :nohlsearch<cr><cr>

" Show matching brackets
set showmatch

" Disable swp files
set noswapfile

" Number of spaces that a Tab in the file counts for
set tabstop=4

" Indicate that last window have a statusline too
set laststatus=2

" Disable wrap long string
set nowrap

syntax on
filetype plugin indent on

if has('gui_running')
		set lines=999
		set columns=120
		" Disable gui elements
		set guioptions=c
		NeoBundle 'chrisbra/Colorizer'
else
		set t_Co=256

endif
