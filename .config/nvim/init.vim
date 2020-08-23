" BEHAVIOUR

" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible
" Non-retarded splitting (bottom-right instead of the opposite)
set splitbelow splitright
" Use case insensitive search, except when using capital letters
set ignorecase smartcase
" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm
" Use visual bell instead of beeping when doing something wrong
" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set visualbell
set t_vb= 
" Enable use of the mouse for all mode. Press shift to highlight normally!
set mouse=a
" Indentation settings for using hard tabs for indent. Display tabs as
" four characters wide
set expandtab
set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
" clear last search highlight by pressing ESC in normal mode
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[
" set vim to use systemclipboard
set clipboard+=unnamedplus
" change working directory to current file automatically
set autochdir


" APPEARANCE

colorscheme default
" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2
" Display line numbers on the left
set number
" Show context lines before and after the cursor
set so=10


" GENERAL MAPPINGS

" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>
" Split tabs navigation shorcuts
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" space to open/close a fold and Ctrl space to do toggle all folding
nnoremap <space> za
nnoremap <expr> <C-space> &foldlevel ? 'zM' :'zR'
" toggle on/off spellcheck
let b:spell_toggled=0
function ToggleSpellCheck()
    if b:spell_toggled == 0
        setlocal spell spelllang=en_us
        let b:spell_toggled=1
    else
        setlocal nospell
        let b:spell_toggled=0
    endif
endfunction
nnoremap <c-g> :call ToggleSpellCheck()<CR>
" navigate spellchecks or add to dictionary
nnoremap <c-i> [s
nnoremap <c-o> ]s
nnoremap <c-p> zg]s


" PLUGINS

call plug#begin("$XDG_DATA_HOME/nvim/plugged")
" general
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-eunuch'
Plug 'wellle/targets.vim'
Plug 'lilydjwg/colorizer'
Plug 'scrooloose/nerdtree'
"Plug 'scrooloose/nerdtree-git-plugin'
Plug 'scrooloose/nerdcommenter'
Plug 'airblade/vim-gitgutter'
Plug 'liuchengxu/vista.vim'
"Plug 'jiangmiao/auto-pairs'
Plug 'vimwiki/vimwiki'
"Plug 'danilamihailov/vim-tips-wiki'
" languages
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' }
Plug 'tmhedberg/SimpylFold'
Plug 'Konfekt/FastFold'
Plug 'kkoomen/vim-doge'
Plug 'lervag/vimtex'
" completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'Shougo/neco-syntax'
" snippets
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
call plug#end()


" PLUGIN SETTINGS

" DEOPLETE
let g:deoplete#enable_at_startup = 1
" close atuomatically on completion
"if !exists('g:deoplete#omni#input_patterns')
"	let g:deoplete#omni#input_patterns = {}
"endif
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | silent! pclose | endif
" enable completion with latex
call deoplete#custom#var('omni', 'input_patterns', {'tex': g:vimtex#re#deoplete})
" tab-complete
inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<s-tab>"
inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<tab>"
" slow down delay to allow better compatibility with semshi
" let g:deoplete#auto_complete_delay = 100

" VISTA
nnoremap <leader>v :Vista!!<CR>
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_stay_on_open = 0
" function for lightline
function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunctio
" need this line to automatically run the vista function on startup
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

" LIGHTLINE
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode' ],
      \             [ 'readonly', 'filename', 'modified', 'method' ] ],
      \   'right': [ [ 'percent', 'lineinfo' ],
      \             [ 'lintstatus' ] ],
      \ },
      \ 'component_function': {
 	  \   'method': 'NearestMethodOrFunction',
      \ },
      \ }
" hide mode, since lightline is taking care of that now
set noshowmode

" NEOSNIPPETS
imap <Space><Space>     <Plug>(neosnippet_expand_or_jump)
smap <Space><Space>     <Plug>(neosnippet_expand_or_jump)
xmap <Space><Space>     <Plug>(neosnippet_expand_target)
let g:neosnippet#snippets_directory="${XDG_DATA_HOME}/nvim/custom/snippets"

" VIMTEX and latex-related
" Enable latex filetype even for empty .tex files
let g:tex_flavor='latex'
" Vim-latex live preview
let g:livepreview_previewer = 'mupdf'
let g:vimtex_view_method = 'mupdf'
" folding
let g:vimtex_fold_enabled = 1

" PYTHON-MODE
nnoremap <leader> <C-c>
let g:pymode_options_max_line_length = 119
let g:pymode_options_colorcolumn = 0
let g:pymode_rope = 0 "broken :(

" SEMSHI
let g:semshi#update_delay_factor = 0.0001
let g:semshi#error_sign = v:false

" SIMPYLFOLD
let g:SimpylFold_docstring_preview = 1
let g:SimpylFold_fold_docstring = 0

" COLORIZER
let g:colorizer_maxlines = 1000

" VIMWIKI
let g:vimwiki_list = [
						\{
						\'path': '~/git/wiki',
						\'path_html': '~/git/wiki/html/',
						\'syntax': 'default',
						\'ext': '.wiki',
						\'template_path': '~/git/wiki/templates',
						\'template_default': 'default',
						\'template_ext': '.html',
						\'auto_tags': 1,
						\'auto_diary_index': 1,
						\},
					\]
let g:vimwiki_table_mappings = 0
nmap <leader>wa :VimwikiAll2HTML<CR><CR>
nmap <leader>we <Plug>VimwikiSplitLink
nmap <leader>wq <Plug>VimwikiVSplitLink

" NERDTREE
" open nerdtree
map <leader>n :NERDTreeToggle<CR>
" automatically close vim if nerdtree is the only thing left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" pretty arrows
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" AUTO-PAIRS
"let g:AutoPairs = {'(':')', '[':']', '{':'}', '"""':'"""', "'''":"'''",}
