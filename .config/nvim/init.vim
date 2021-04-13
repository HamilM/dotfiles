set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.fzf
" Plugin 'davidhalter/jedi-vim'


call plug#begin()
" Use release branch (recommend)
Plug 'lervag/vimtex'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'letorbi/vim-colors-modern-borland'
Plug 'preservim/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/goyo.vim'
Plug 'morhetz/gruvbox'
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'arcticicestudio/nord-vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'Rigellute/shades-of-purple.vim'
Plug 'voldikss/coc-cmake'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'
Plug 'Shougo/unite.vim'
Plug 'christianchiarulli/nvcode-color-schemes.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'liuchengxu/vista.vim'
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }
Plug 'camspiers/animate.vim'
Plug 'camspiers/lens.vim'
call plug#end()

"""" enable 24bit true color
" If you have vim >=8.0 or Neovim >= 0.1.5
if has('nvim') || has('termguicolors')
	set termguicolors
endif

filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:

" To make Meta key work correctly in MAC
" set macmeta

" Visual
" set guioptions=
set nu
set rnu
set encoding=utf-8
syntax enable
let python_highlight_all=1
colorscheme aurora
let g:airline_theme='base16_nord'
set completeopt=longest,menuone
set splitbelow
set splitright

" Highlight trailing space
:highlight ExtraWhitespace ctermbg=white guibg=white
:match ExtraWhitespace /\s\+$/

" Cursor line highlight
set cursorline

" Ranger config
" Open ranger instead of netrw
let g:ranger_replace_netrw = 1
nmap <leader>f :RangerCurrentDirectory<cr>

if has("gui_running")
	set guifont=Roboto\ Mono\ Medium\ for\ Powerline:h18
	" set guifont=Modern\ DOS\ 9x16:h20
	set noantialias
	" colorscheme borland
	" let g:BorlandStyle = "classic"
	" set guicursor=n-v-c:block-Cursor
	" set guicursor+=i:ver100-iCursor
	" set guicursor+=n-v-c:blinkon0
	" set guicursor+=i:blinkwait10
endif

" Leader
let mapleader = " "
let maplocalleader = "_"

" Disable escape
inoremap <esc> <NOP>
inoremap jk <esc>
" In insert mode - <esc> doesn't go back
" Save file shortcus
inoremap <C-s> <esc>:w<cr>a
nnoremap <C-s> :w<cr>

" Config management
let MYVIMRC = "~/.config/nvim/init.vim"
nnoremap <leader>Cr :source $MYVIMRC<cr>
nnoremap <leader>Ce :vsplit $MYVIMRC<cr>

" File management
" Open a file with fzf
nnoremap <leader>gf :Files .<cr>
" nnoremap <leader>t :Tags<cr>
" nnoremap <leader>tw viw"ay:Tags <c-r>a<CR>
nnoremap <silent> <leader>t :Clap proj_tags<cr>
nnoremap <silent> <leader>tw viw"ay:Clap proj_tags<cr><c-r>a
nnoremap <leader>gb :Buffers<cr>
nnoremap <leader>gl :Lines<cr>
" nnoremap <leader>gr :call FzfRgCurrWord()<CR>
" nnoremap <leader>gw viw"ay:Rg <c-r>a<CR>
nnoremap <silent> <leader>g viw"ay:Clap grep<cr>
nnoremap <silent> <leader>gw viw"ay:Clap grep<cr><c-r>a
nnoremap <silent><nowait> <leader>o :<C-u>CocList --top --ignore-case --auto-preview outline<cr>
nnoremap <silent><nowait> <leader>s :<C-u>CocList --top --interactive --ignore-case --auto-preview symbols<cr>
nnoremap <silent><nowait> <leader>d :<C-u>CocList --top --ignore-case --auto-preview diagnostics<cr>

fu! FzfRgCurrWord()
	call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case -- '".expand('<cword>')."'", 1 , {}, 0)
endfu
fu! FzfTagsCurrWord()
	call fzf#vim#tags(expand('<cword>'))
endfu
let g:fzf_action = {
	\ 'ctrl-t': 'tab split',
	\ 'ctrl-x': 'split',
	\ 'ctrl-v': 'vsplit',
	\ 'ctrl-y': {lines -> setreg('*', join(lines, "\n"))}}
nnoremap <leader>gt :call FzfTagsCurrWord()<cr>
" nnoremap <leader>t :Tags<cr>

nmap <leader>qf <Plug>(coc-fix-current)
nmap <leader>ac <Plug>(coc-codeaction-line)
nmap <leader>r <Plug>(coc-rename)
nmap <silent> <leader>cd <Plug>(coc-definition)
nmap <silent> <leader>ctd <Plug>(coc-type-definition)
nmap <silent> <leader>ci <Plug>(coc-implementation)
nmap <silent> <leader>cr <Plug>(coc-references)
nmap <silent> <leader>dh <Plug>(coc-diagnostic-info)
nmap <silent> <leader>dj <Plug>(coc-diagnostic-next)
nmap <silent> <leader>dk <Plug>(coc-diagnostic-prev)


" Navigation
nnoremap H ^
nnoremap L $
nnoremap <C-j> <C-w><C-j>
tnoremap <C-j> <C-\><C-n><C-w><C-j>
nnoremap <C-h> <C-w><C-h>
tnoremap <C-h> <C-\><C-n><C-w><C-h>
nnoremap <C-k> <C-w><C-k>
tnoremap <C-k> <C-\><C-n><C-w><C-k>
nnoremap <C-l> <C-w><C-l>
tnoremap <C-l> <C-\><C-n><C-w><C-l>
nnoremap <C-n> :bnext<cr>
tnoremap <C-n> <C-\><C-n>:bnext<cr>
nnoremap <C-m> :bprevious<cr>
" tnoremap <C-m> <C-\><C-n>:bprevious<cr>
nnoremap <C-w> :bd!<cr>
tnoremap <C-w> <C-\><C-n>:bd!<cr>

augroup general
	autocmd!
augroup END

" Autocmd - vimrc
augroup vim
	autocmd!
augroup END


augroup python
	autocmd!
	autocmd FileType python nnoremap <localleader>r :!python3 %<cr>
	autocmd FileType python setlocal ts=4
	autocmd FileType python setlocal shiftwidth=4
	autocmd FileType python setlocal expandtab
	autocmd FileType python setlocal autoindent
	autocmd FileType python setlocal showmatch
augroup END

augroup go
	autocmd!
	autocmd FileType go nnoremap <localleader>r :GoRename<cr>
	autocmd FileType go nnoremap <localleader>b :GoBuild<cr>
	autocmd FileType go nnoremap <localleader>e :GoRun<cr>
	autocmd FileType go nnoremap <localleader>dn :GoDebugNext<cr>
	autocmd FileType go nnoremap <localleader>ds :GoDebugStep<cr>
	autocmd FileType go nnoremap <localleader>dc :GoDebugContinue<cr>
	autocmd FileType go nnoremap <localleader>db :GoDebugStart<cr>
	autocmd FileType go nnoremap <localleader>dt :GoDebugStop<cr>
	autocmd FileType go nnoremap <localleader>n :cnext<cr>
	autocmd FileType go nnoremap <localleader>m :cprevious<cr>
	autocmd FileType go nnoremap <localleader>a :cclose<cr>
	autocmd FileType go nnoremap <localleader>N :lnext<cr>
	autocmd FileType go nnoremap <localleader>M :lprevious<cr>
	autocmd FileType go nnoremap <localleader>A :lclose<cr>
	autocmd FileType go nnoremap <localleader>g :GoDeclsDir<cr>
	autocmd FileType go nnoremap <localleader>c :GoCallers<cr>
	autocmd FileType go nnoremap <localleader>C :GoCallees<cr>
augroup END

augroup Terminal
	autocmd!
	autocmd TermOpen * setlocal nonu nornu
	autocmd BufEnter * if &l:buftype ==# 'terminal' | :normal A | endif
augroup END

augroup Markdown
	autocmd!
	autocmd Filetype markdown nnoremap <leader>m <Plug>(coc-codeaction)
augroup END

augroup tex
	autocmd!
	autocmd Filetype tex nnoremap <localleader><space> :set rl!<cr>
	autocmd Filetype tex inoremap <localleader><space> <esc>:set rl!<cr>i
	autocmd FileType tex call SetServerName()
augroup END
function! SetServerName()
  call system('echo ' . v:servername . ' > /tmp/curvimserver')
endfunction

" Plugin config
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:NERDSpaceDelims = 1
let g:go_def_mode='gopls'
let g:go_metalinter_autosave= 1
let g:go_metalinter_command='gopls'
let g:go_info_mode='gopls'
set noshowmode
nnoremap <leader>gy :Goyo<cr>

let g:coc_global_extensions =
	\  ["coc-clangd",
	\ "coc-fzf-preview",
	\ "coc-go",
	\ "coc-cmake",
	\ "coc-markdownlint",
	\ "coc-python", 
	\ "coc-lists",
	\ "coc-json" ,
	\ "coc-texlab"]

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction


function! s:check_back_space() abort
let col = col('.') - 1
return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <TAB>
	\ pumvisible() ? "\<C-n>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\ coc#refresh()
nnoremap <C-Space> :CocCommand<cr>


" Develop shortcuts

" Open Terminal
nnoremap <leader>ts :vsplit term://zsh<cr>
nnoremap <leader>tt :terminal<cr>
let g:terminal_scrollback_buffer_size = 1000000


" ===========================
" ===== Markdown Config =====
" ===========================

" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 1

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" default: ''
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
" disable_filename: if disable filename header for preview page, default: 0
let g:mkdp_preview_options = {
	\ 'mkit': {},
	\ 'katex': {},
	\ 'uml': {},
	\ 'maid': {},
	\ 'disable_sync_scroll': 0,
	\ 'sync_scroll_type': 'middle',
	\ 'hide_yaml_meta': 1,
	\ 'sequence_diagrams': {},
	\ 'flowchart_diagrams': {},
	\ 'content_editable': v:false,
	\ 'disable_filename': 0
	\ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or random for empty
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

" Vista tab
let g:vista_fzf_preview = ['right:50%']

" Treesitter
" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { },  -- list of language that will be disabled
  },
}
EOF


" vim-clap
let g:clap_disable_run_rooter = v:true
let g:clap_layout = { 'relative': 'editor' }

" vim lens
let g:lens#width_resize_max = 120
let g:lens#width_resize_min = 10
let g:lens#height_resize_max = 50
let g:lens#height_resize_min = 10
