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

" automatically close vim if nerdtree/vista is the only thing left
function CloseIfOnlyNerdtreeOrVista()
    if tabpagenr('$') == 1
        let count = 0
        if bufexists('NERD_tree_1')
            let count += 1
        endif
        if bufexists('__vista__')
            let count += 1
        endif
        if count == winnr('$')
            qall
        endif
    endif
endfunction
autocmd BufEnter * nested call CloseIfOnlyNerdtreeOrVista()


" GENERAL MAPPINGS

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
nnoremap <leader>i [s
nnoremap <leader>o ]s
nnoremap <c-p> zg]s
" accept local or remote changes with mergetool
nnoremap <A-,> :diffget LO<CR>
nnoremap <A-.> :diffget RE<CR>


" OTHER PERSISTENT CHANGES

au BufRead,BufNewFile *.ipy		set filetype=python


" APPEARANCE

set termguicolors
set background=dark
let g:gruvbox_italics=1
colorscheme gruvbox
" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2
" Display line numbers on the left
set number
" Show context lines before and after the cursor
set so=10


" PLUGINS

call plug#begin("$XDG_DATA_HOME/nvim/plugged")
Plug 'lilydjwg/colorizer'
" broken atm Plug 'scrooloose/nerdtree-git-plugin'
" local fzf
Plug '/usr/bin/fzf'
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' }
Plug 'tmhedberg/SimpylFold'
Plug 'kkoomen/vim-doge'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
call plug#end()


" PLUGIN SETTINGS
" DEOPLETE
let g:deoplete#enable_at_startup = 1
" close atuomatically on completion
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | silent! pclose | endif
" enable completion with latex
call deoplete#custom#var('omni', 'input_patterns', {'tex': g:vimtex#re#deoplete})
" tab-complete
inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<s-tab>"
inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<tab>"

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
      \ 'colorscheme': 'jellybeans',
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
						\'syntax': 'markdown',
						\'ext': '.md',
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
" disable temporary wikis
let g:vimwiki_global_ext = 0

" NERDTREE
" open nerdtree
map <leader>n :NERDTreeToggle<CR>
" pretty arrows
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'


" JULIA
let g:default_julia_version = '1.0'
" language server
let g:LanguageClient_serverCommands = {
\ }


" LANGUAGE SERVER
" Required for operations modifying multiple buffers like rename.
set hidden
let g:LanguageClient_serverCommands = {
\   'python': ['/usr/bin/pyls'],
\   'julia': ['julia', '--startup-file=no', '--history-file=no', '-e', '
\       using LanguageServer;
\       using Pkg;
\       import StaticLint;
\       import SymbolServer;
\       env_path = dirname(Pkg.Types.Context().env.project_file);
\       
\       server = LanguageServer.LanguageServerInstance(stdin, stdout, env_path, "");
\       server.runlinter = true;
\       run(server);
\   ']
\ }
" note that if you are using Plug mapping you should not use `noremap` mappings.
nmap <F5> <Plug>(lcn-menu)
nmap <silent> K <Plug>(lcn-hover)
nmap <silent> <leader>gd <Plug>(lcn-definition)
nmap <silent> <leader>gr <Plug>(lcn-references)
nmap <silent> <leader>rn <Plug>(lcn-rename)
