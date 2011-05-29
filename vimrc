" ================
" Ruby stuff
" ================
colorscheme vividchalk
"setlocal spell spelllang=de,en
augroup myfiletypes
  " Clear old autocmds in group
  autocmd!
  " autoindent with two spaces, always expand tabs
  autocmd FileType ruby,eruby,yaml set ai sw=2 sts=2 et
augroup END
" ================
fun SetupVAM()
  set runtimepath+=~/.dotfiles/vim-addons/vim-addon-manager
  " commenting try .. endtry because trace is lost if you use it.
  " There should be no exception anyway
  " try
  let plugins = ['rails',
        \'project.tar.gz',
        \'vim-coffee-script',
        \'vim-ruby-debugger',
        \'cucumber.zip',
        \'fugitive',
        \'snipMate',
        \'vim-ruby',
        \'vividchalk']
  " Fehlt: vim-rooter
  " Supertag
  " fuzzyfinder_textmate
  " makegreen
  " ack
  call vam#ActivateAddons(plugins, {'auto_install' : 0})
  " pluginA could be github:YourName see vam#install#RewriteName()
  " catch /.*/
  "  echoe v:exception
  " endtry
endf
call SetupVAM()
" experimental: run after gui has been started (gvim) [3]
" option1:  au VimEnter * call SetupVAM()
" option2:  au GUIEnter * call SetupVAM()
" See BUGS sections below [*]
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

let mapleader = ","

" Git
map <Leader>gac :Gcommit -a -m ""<LEFT>
map <Leader>gc :Gcommit -m ""<LEFT>
map <Leader>gs :Gstatus<CR>

vmap <Leader>b :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>
map <Leader>cc :!cucumber %<CR> " Cucumber Task for this file
map <Leader>co :TComment<CR>
map <Leader>d odebugger<cr>puts 'debugger'<esc>:w<cr>
map <Leader>f :sp spec/factories.rb<CR>
map <Leader>m :Rmodel
map <Leader>sc :sp db/schema.rb<cr>
map <Leader>vi :tabe ~/.vimrc<CR>
map <Leader>w <C-w>w " Next Buffer
map <Leader>u :Runittest
map <Leader>vc :RVcontroller
map <Leader>vf :RVfunctional
map <Leader>vu :RVunittest
map <Leader>vm :RVmodel
map <Leader>vv :RVview
map <Leader>sm :RSmodel
map <Leader>su :RSunittest
map <Leader>sv :RSview
map <Leader>nt :NERDTree
map <C-t> <esc>:tabnew<CR>
imap <C-l> <Space>=><Space>
map <C-s> <esc>:w<CR>
imap <C-s> <esc>:w<CR>
map W :w
map :Q :q
map <Leader>h :FuzzyFinderTextMate<CR>
map <Leader>l :!ruby <C-r>% \| less<CR>
map <Leader>n ,w,t
map <Leader>o ?def <CR>:nohl<CR>w"zy$:!ruby -I"test" <C-r>% -n <C-r>z<CR>
map <Leader>rb :Rake!<CR>
map <Leader>rf :FuzzyFinderTextMateRefreshFiles<CR>
map <Leader>rw :%s/\s\+$//

" Tab mappings.
map <leader>tt1 :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>to :tabonly<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprevious<cr>
map <leader>tf :tabfirst<cr>
map <leader>tl :tablast<cr>
map <leader>tm :tabmove

"map <C-h> :nohl<CR>
map <C-x> <C-w>c
map <C-n> :cn<CR>
map <C-p> :cp<CR>
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l


set nocompatible
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set history=500		" keep 500 lines of command line history
set ruler		" show the cursor position all the time
"set hidden
set visualbell
set wildmenu
set wildmode=list:longest
set nobackup
set nowritebackup
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set showcmd		" display incomplete commands
set autoindent
set showmatch
set nowrap
set backupdir=~/.tmp
set directory=~/.tmp " Don't clutter my dirs up with swp and tmp files
set autoread " reads file if changed outside of vim
set wmh=0 " minimal number of lines used for any window
set viminfo+=! " save global vars
set guioptions-=T
set guifont=Triskweline_10:h10
set sw=2 " spaces for autointent
set smarttab
set incsearch " show search result
set ignorecase smartcase
set laststatus=2  " Always show status line.

set number  " Linenumbers
set gdefault " assume the /g flag on :s substitutions to replace all matches in a line
set autoindent " always set autoindenting on

" Edit another file in the same directory as the current file
" uses expression to extract path from current file's path
map <Leader>e :e <C-R>=expand("%:p:h") . '/'<CR>
map <Leader>s :split <C-R>=expand("%:p:h") . '/'<CR>
map <Leader>v :vnew <C-R>=expand("%:p:h") . '/'<CR>
" Set the tag file search order
set tags=./tags;

" Use _ as a word-separator
set iskeyword-=_

" Use Ack instead of grep
set grepprg=ack

" Make the omnicomplete text readable
:highlight PmenuSel ctermfg=black

" Fuzzy finder: ignore stuff that can't be opened, and generated files
let g:fuzzy_ignore = "*.png;*.PNG;*.JPG;*.jpg;*.GIF;*.gif;vendor/**;coverage/**;tmp/**;rdoc/**"

" Highlight the status line
highlight StatusLine ctermfg=blue ctermbg=yellow

" Format xml files
au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"

set shiftround " When at 3 spaces and I hit >>, go to 4, not 5.

set nofoldenable " Fuck code folding...

command Q q " Bind :Q to :q
command Qall qall

set statusline+=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
autocmd BufWritePre * :%s/\s\+$//e
function RemoveTrailingWhitespace()
  if &ft != "diff"
    let b:curcol = col(".")
    let b:curline = line(".")
    silent! %s/\s\+$//
    silent! %s/\(\s*\n\)\+\%$//
    call cursor(b:curline, b:curcol)
  endif
endfunction
autocmd BufWritePre * call RemoveTrailingWhitespace()

" ========================================================================
" End of things set by me.
" ========================================================================

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif
call pathogen#runtime_append_all_bundles()
" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
    au!

    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost *
          \ if line("'\"") > 0 && line("'\"") <= line("$") |
          \   exe "normal g`\"" |
          \ endif

  augroup END
  autocmd VimEnter * wincmd p

endif " has("autocmd")
