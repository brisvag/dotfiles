" BEHAVIOUR

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
set tabstop=4
set softtabstop=4
set shiftwidth=4
" clear last search highlight by pressing ESC in normal mode
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[
" set vim to use systemclipboard
set clipboard+=unnamedplus
" indent wrapped text as original line
set breakindent 
" save undo history
set undofile
" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2
" Display line numbers on the left
set number
" Show context lines before and after the cursor
set so=10
" trigger `autoread` when files changes on disk
set autoread
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif


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
nnoremap <A-,> :diffget LO
nnoremap <A-.> :diffget RE


" OTHER PERSISTENT CHANGES

au BufRead,BufNewFile *.ipy		set filetype=python


" APPEARANCE

set termguicolors
set background=dark
let g:gruvbox_italics=1
colorscheme gruvbox


" PLUGINS
"   deoplete
"   lightline
"   lspconfig
"   remote
"   targets-opt
"   vista
"   pynvim
"   auto-pairs
"   fastfold
"   fugitive
"   gitgutter
"   gruvbox
"   julia
"   molokai
"   nerdcommenter
"   nerdtree
"   repeat
"   surround
"   unimpaired
"   vimtex
"   vimwiki
"   treesitter (with various language packs)
"   telescope
call plug#begin("$XDG_DATA_HOME/nvim/plugged")
Plug 'lilydjwg/colorizer'
" broken atm Plug 'scrooloose/nerdtree-git-plugin'
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' }
Plug 'tmhedberg/SimpylFold'
Plug 'kkoomen/vim-doge'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
"Plug 'deoplete-plugins/deoplete-lsp'
Plug 'lervag/vimtex'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
call plug#end()


" PLUGIN SETTINGS
"
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

" AUTOPAIR
let g:AutoPairsShortcutBackInsert = '<M-b>'

" VIMTEX and latex-related
" Enable latex filetype even for empty .tex files
let g:tex_flavor='latexmk'
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'
let g:vimtex_quickfix_mode=0
let g:vimtex_fold_enabled = 1
let g:vimtex_fold_types = {
           \ 'preamble' : {'enabled' : 1},
           \ 'sections' : {'enabled' : 1},
           \ 'envs' : {
           \   'blacklist' : ['figures'],
           \ },
           \}

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

" LANGUAGE SERVER
lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  -- conflict with finder buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pylsp', 'pyright', 'julials' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF


" TREESITTER
" highlight

lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      ["foo.bar"] = "Identifier",
    },
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF

" folding
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()


" TELESCOPE
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fz <cmd>Telescope current_buffer_fuzzy_find<cr>
lua <<EOF
    require('telescope').load_extension('fzf')
EOF
