let mapleader =","

if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))

" Searching
Plug 'junegunn/fzf', { 'dir': '~/.local/lib/fzf', 'do': './install --all' } " Python
Plug 'junegunn/fzf.vim'
Plug 'yegappan/mru'
" Speed
Plug 'unblevable/quick-scope'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'simeji/winresizer'
Plug 'Raimondi/delimitMate' "
Plug 'preservim/nerdtree'
Plug 'ludovicchabant/vim-gutentags'
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Npm
Plug 'nelstrom/vim-visual-star-search'
Plug 'rhysd/clever-f.vim'
" Plug 'metakirby5/codi.vim'
Plug 'godlygeek/tabular'

" Latex
Plug 'SirVer/ultisnips' " Python
Plug 'lervag/vimtex' " Latexmk, zathura and texlive-most(AUR)
Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}
Plug 'matze/vim-tex-fold'
Plug '907th/vim-auto-save'

" Appearance
Plug 'djoshea/vim-autoread'
Plug 'gioele/vim-autoswap'
Plug 'Yggdroot/indentLine'
Plug 'mhinz/vim-startify'
Plug 'bling/vim-airline'
Plug 'morhetz/gruvbox'
Plug 'junegunn/goyo.vim'
" Plug 'vimwiki/vimwiki'
Plug 'kovetskiy/sxhkd-vim'
Plug 'jpalardy/vim-slime'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'davidhalter/jedi'
Plug 'kassio/neoterm'
Plug 'fholgado/minibufexpl.vim'
call plug#end()

"""""""
" GRUVBOX
"""""""
colorscheme gruvbox
" coc debug information
" let g:gruvbox_guisp_fallback = 'bg'


"""""""
" IDENTATION
"""""""
set expandtab           " enter spaces when tab is pressed
set textwidth=120       " break lines when line length increases
set tabstop=4           " use 4 spaces to represent tab
set softtabstop=4
set shiftwidth=4        " number of spaces to use for auto indent
set autoindent          " copy indent from current line when starting a new line


"""""""
" BASICS
"""""""
set bg=dark
"set bg=light

set go=a
set mouse=a
set nohlsearch
set clipboard+=unnamedplus

" Some basics:
nnoremap c "_c
set nocompatible
filetype plugin on
syntax on
set encoding=utf-8
set number relativenumber

" Enable autocompletion:
set wildmode=longest,list,full

" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
set splitbelow splitright

" Shortcutting split navigation, saving a keypress:
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Replace ex mode with gq
map Q gq

" Check file in shellcheck:
map <leader>s :!clear && shellcheck %<CR>

" Quickly edit/reload this configuration file
nnoremap <leader>se :e $MYVIMRC<CR>
nnoremap <leader>so :so $MYVIMRC<CR>

" Fast saving and quitting
nmap <leader>w :w!<cr>
nmap <leader>q :qa!<CR>
nmap <leader>x :wqa!<CR>

" Save file as sudo on files that require root permission
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" buffer mappings
nnoremap <leader>b :buffers<CR>:buffer<space>


" Automatically deletes all trailing whitespace and newlines at end of file on save.
autocmd BufWritePre * %s/\s\+$//e


"""""
" VIM AUTOSWAP
"""""
set title titlestring


"""""
" TABULARIZE
"""""

if exists(":Tabularize")
      nmap <Leader>D= :Tabularize /=<CR>
      vmap <Leader>D= :Tabularize /=<CR>
      nmap <Leader>D: :Tabularize /:\zs<CR>
      vmap <Leader>D: :Tabularize /:\zs<CR>
endif

inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction


"""""""
" INDENTLINE:
"""""""
let g:indentLine_char       = '┆'
let g:indentLine_setConceal = 0

"""""""
" Clever f:
"""""""
map ; <Plug>(clever-f-repeat-forward)
map , <Plug>(clever-f-repeat-back)

"""""""
" GOYO:
"""""""
" Goyo plugin makes text more readable when writing prose:
	map <leader>y :Goyo \| set bg=light \| set linebreak<CR>


"""""""
" NERD TREE:
"""""""
map <leader>n :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
if has('nvim')
	let NERDTreeBookmarksFile = stdpath('data') . '/NERDTreeBookmarks'
else
	let NERDTreeBookmarksFile = '~/.vim' . '/NERDTreeBookmarks'
endif


"""""""
" VIMWIKI:
"""""""
" " Ensure files are read as what I want:
" let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
" map <leader>v :VimwikiIndex
" let g:vimwiki_list = [{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
" autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
" autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
" autocmd BufRead,BufNewFile *.tex set filetype=tex
" let g:vimwiki_table_mappings = 0



"""""""""""""""""
"  FZF- finder and MRU  "
"""""""""""""""""
map <leader>f <Esc><Esc>:MRU <cr>
map <leader>F <Esc><Esc>:Files!<CR>
" inoremap <leader>F <Esc><Esc>:Blines!<CR>
" map <leader>c <Esc><Esc>:BCommits!<CR>

map <leader>G :Rg

" fugitive git bindings
nnoremap <leader>Ga :Git add %:p<CR><CR>
nnoremap <leader>Gs :Gstatus<CR>
nnoremap <leader>Gc :Gcommit -v -q<CR>
nnoremap <leader>Gt :Gcommit -v -q %:p<CR>
nnoremap <leader>Gd :Gdiff<CR>
nnoremap <leader>Ge :Gedit<CR>
nnoremap <leader>Gr :Gread<CR>
nnoremap <leader>Gw :Gwrite<CR><CR>
nnoremap <leader>Gl :silent! Glog<CR>:bot copen<CR>
nnoremap <leader>Gp :Ggrep<Space>
nnoremap <leader>Gm :Gmove<Space>
nnoremap <leader>Gb :Git branch<Space>
nnoremap <leader>Go :Git checkout<Space>
nnoremap <leader>Gps :Dispatch! git push<CR>
nnoremap <leader>Gpl :Dispatch! git pull<CR>

""""""""""""""""""""""""""""""
" => vim-autosave plugin
""""""""""""""""""""""""""""""

function EnableAutoSave()
  let g:auto_save = 1
  let g:auto_save_events = ["InsertLeave", 'TextChanged',"CursorHold", 'CursorHoldI']
  "autocmd TextChanged,TextChangedI <buffer> silent write
endfunction

" Autosave for tex
au BufRead,BufNewFile *.tex :call EnableAutoSave()

""""""""""""""""""""""""""""""
" => Vimtex Plugin
" Check :h vimtex-requirements for more
""""""""""""""""""""""""""""""

let maplocalleader = "\\"
let g:Tex_DefaultTargetFormat='pdf'
let g:vimtex_view_enabled=1
let g:vimtex_view_automatic=1
"let g:vimtex_view_general_viewer = 'zathura'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0

"
" Clean directory of generated files
nnoremap <localleader>lc :VimtexStop<cr>:VimtexClean<cr>
nnoremap <localleader>lca :VimtexStop<cr>:VimtexClean!<cr>

" incscape-figures plug-in
"inoremap <localleader>f <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>
"nnoremap <localleader>f : silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>

let g:tex_flavor='latex'
let g:vimtex_quickfix_mode=0

" Start client server for backward search from pdf to vim
if empty(v:servername) && exists('*remote_startserver')
  call remote_startserver('VIM')
endif

""""""""""""""""""""""""""""""
" => Tex Conceal Plug-in
"
"""""""""""""""""""""""""""""""
set conceallevel=1
let g:tex_conceal='abdmg'
hi Conceal ctermbg=none
"let g:tex_conceal_frac=1

""""""""""""""""""""""""""""""
" => Ulti Snips Plugin
"""""""""""""""""""""""""""""""
let g:UltiSnipsExpandTrigger='<c-space>'
let g:UltiSnipsJumpForwardTrigger='<c-space>'
let g:UltiSnipsJumpBackwardTrigger='<c-S-space>'


"""""""
" COMMON:
""""""
" Spelling correction when pressing ctrl L
"setlocal spell
"hi SpellBad    ctermfg=none      ctermbg=none     cterm=none      guifg=none   guibg=none gui=none
"set spelllang=en_gb
"inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" Spell-check set to <leader>o, 'o' for 'orthography':
"map <leader>O :setlocal spell! spelllang=en_us<CR>




"autocmd BufWritepre * %s/\n\+\%$//e

" When shortcut files are updated, renew bash and ranger configs with new material:
autocmd BufWritePost files,directories !shortcuts
" Run xrdb whenever Xdefaults or Xresources are updated.
autocmd BufWritePost *Xresources,*Xdefaults !xrdb %
" Update binds when sxhkdrc is updated.
autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd


" Turns off highlighting on the bits of code that are changed, so the line that is changed is highlighted but the actual text that has changed stands out on the line and is readable.
if &diff
    highlight! link DiffText MatchParen
endif


"""""""
" CODI:
""""""

" " Change the color
" highlight CodiVirtualText guifg=cyan

" let g:codi#virtual_text_prefix = "❯ "
" let g:codi#aliases = {
"                    \ 'javascript.jsx': 'javascript',
"                    \ }
" map <leader>I :Codi<cr>

"map <leader>r :w!<CR>:silent !chmod +x %:p<CR>:silent !%:p 2>&1 | tee ~/.vim/output<CR>: split $HOME/.cache/nvim/output<CR>:redraw!<CR>


"""""""
" Autopair:
""""""
let g:AutoPairsFlyMode = 0
let g:AutoPairsShortcutBackInsert = '<M-b>'


"""""""
" Coc:
""""""
source ~/.config/nvim/cocrc.vim
hi CocInfoFloat guifg=#hex-color guibg=#hex-color
hi CocWarningFloat guifg=#hex-color guibg=#hex-color
hi CocHintFloat guifg=#hex-color guibg=#hex-color
nmap <silent> gd <Plug>(coc-definition)

call airline#parts#define_function('coc_status', 'coc#status')
let g:airline_section_y = airline#section#create_right(['coc_status','ffenc'])
