" BEHAVIOUR

set splitbelow splitright
set ignorecase smartcase
set confirm
set visualbell
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=-1
set mouse=a
set clipboard=unnamedplus
set breakindent 
set undofile
set cmdheight=2
set number
set scrolloff=8
set sidescrolloff=8
set hidden
set autoread
set termguicolors
set title
set wildmode=longest:full,full
set list
set listchars=tab:▸\ ,trail:·
set nojoinspaces
set updatetime=300 " Reduce time for highlighting other references
set redrawtime=10000 " Allow more time for loading syntax on large files
set completeopt=menu,menuone,noselect
set noshowmode

colorscheme gruvbox
let g:gruvbox_italics=1

au BufRead,BufNewFile *.ipy set filetype=python
" Automatically reload file when entering buffer or gaining focus
au FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif


" GENERAL MAPPINGS

" Split tabs navigation shortcuts
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" Reselect visual selection after indenting
vnoremap < <gv
vnoremap > >gv
" Maintain the cursor position when yanking/joining a visual selection
" works by putting markers and jumping back to them
" http://ddrscott.github.io/blog/2016/yank-without-jank/
vnoremap y myy`y
vnoremap Y myY`y
vnoremap J mjJ`j
" Paste replace visual selection without copying it
vnoremap <leader>p "_dP
" Center search and open folds if needed
nnoremap n nzzzv
nnoremap N Nzzzv
" Quick escape
imap jj <esc>
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
nnoremap <c-g> :call ToggleSpellCheck()<cr>
" accept local or remote changes with mergetool
nnoremap <A-,> :diffget LO<CR>
nnoremap <A-.> :diffget RE<CR>


" PLUGINS
" Automatically install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Installed via arch packages
"   auto-pairs
"   deoplete
"   fastfold
"   fugitive
"   gitgutter
"   gruvbox
"   julia
"   lastplace
"   lspconfig
"   lualine (requires InconsolataGo nerd font)
"   nerdcommenter
"   nerdtree
"   pynvim
"   remote
"   repeat
"   splitjoin
"   surround
"   targets(-opt)
"   telescope
"   treesitter (and relative languages)
"   trouble
"   unimpaired
"   vim-which-key
"   vimtex
"   vimwiki
"   vista
"   visual-multi
"   hexokinase
call plug#begin("$XDG_DATA_HOME/nvim/plugged")
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tmhedberg/SimpylFold'
Plug 'kkoomen/vim-doge'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'deoplete-plugins/deoplete-lsp'
Plug 'lervag/vimtex'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'ElPiloto/telescope-vimwiki.nvim'
Plug 'preservim/vim-pencil'
"Plug 'pierreglaser/folding-nvim' # currently broken, for now using simpylfold
Plug 'tommcdo/vim-exchange'
Plug 'sickill/vim-pasta'
Plug 'airblade/vim-rooter'
Plug 'vim-test/vim-test'
Plug 'bronson/vim-visual-star-search'
call plug#end()


" PLUGIN SETTINGS

" DEOPLETE
let g:deoplete#enable_at_startup = 1
" close automatically on completion
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | silent! pclose | endif
" enable completion with latex
call deoplete#custom#var('omni', 'input_patterns', {'tex': g:vimtex#re#deoplete})
" tab-complete
inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<s-tab>"
inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<tab>"

" VISTA
nnoremap <leader>v :Vista!!<cr>
let g:vista_stay_on_open = 0
let g:vista_default_executive = 'nvim_lsp'

" LUALINE
lua << EOF
require('lualine').setup {
    options = {
        theme = 'gruvbox_dark',
        sections = {
            lualine_a = {'mode'},
            lualine_b = {'branch', 'diff', {'diagnostics', sources={'nvim_lsp'}}},
            lualine_c = {'filename'},
            lualine_x = {'buffers'},
            lualine_y = {'progress'},
            lualine_z = {'location'}
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {'filename'},
            lualine_x = {'location'},
            lualine_y = {},
            lualine_z = {}
        },
    }
}
EOF

" NEOSNIPPETS
imap <M-space>     <Plug>(neosnippet_expand_or_jump)
smap <M-space>     <Plug>(neosnippet_expand_or_jump)
xmap <M-space>     <Plug>(neosnippet_expand_target)
let g:neosnippet#snippets_directory="${XDG_DATA_HOME}/nvim/custom/snippets"

" AUTOPAIR
let g:AutoPairsShortcutBackInsert = '<M-b>'

" VIMTEX and latex-related
" Enable latex filetype even for empty .tex files
let g:tex_flavor='latexmk'
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'
let g:vimtex_quickfix_mode=2
let g:vimtex_fold_enabled = 1
let g:vimtex_fold_types = {
           \ 'preamble' : {'enabled' : 1},
           \ 'sections' : {'enabled' : 1},
           \ 'envs' : {
           \   'blacklist' : ['figures'],
           \ },
           \}
let g:vimtex_compiler_latexmk_engines = {
    \ '_': '-pdf -shell-escape',
    \}


" SIMPYLFOLD
let g:SimpylFold_docstring_preview = 1
let g:SimpylFold_fold_docstring = 0

" COLORIZER
let g:colorizer_maxlines = 1000

" VIMWIKI
let wiki_main = {}
let wiki_main.path = '~/git/wiki'
let wiki_main.path_html = '~/git/wiki/html/'
let wiki_main.syntax = 'markdown'
let wiki_main.ext = '.md'
let wiki_main.template_path = '~/git/wiki/templates'
let wiki_main.template_default = 'default'
let wiki_main.template_ext = '.html'
let wiki_main.auto_tags = 1
let wiki_main.auto_diary_index = 1

let wiki_lim_baraan = {}
let wiki_lim_baraan.path = '~/git/lim-baraan-wiki/'
let wiki_lim_baraan.path_html = '~/git/lim-baraan-wiki/html/'
let wiki_lim_baraan.syntax = 'default'
let wiki_lim_baraan.ext = '.wiki'
let wiki_lim_baraan.template_path = '~/git/lim-baraan-wiki/templates'
let wiki_lim_baraan.template_default = 'default'
let wiki_lim_baraan.template_ext = '.html'
let wiki_lim_baraan.auto_tags = 1
let wiki_lim_baraan.auto_diary_index = 1

let dndwiki = {}
let dndwiki.path = '~/git/dndwiki/'
let dndwiki.path_html = '~/git/dndwiki/html/'
let dndwiki.syntax = 'markdown'
let dndwiki.ext = '.md'
let dndwiki.template_path = '~/git/dndwiki/templates'
let dndwiki.template_default = 'default'
let dndwiki.template_ext = '.html'
let dndwiki.auto_tags = 1
let dndwiki.auto_diary_index = 1

let g:vimwiki_list = [wiki_main, wiki_lim_baraan, dndwiki]

let g:vimwiki_table_mappings = 0
nmap <leader>wa :VimwikiAll2HTML<cr><cr>
nmap <leader>we <Plug>VimwikiSplitLink
nmap <leader>wq <Plug>VimwikiVSplitLink
" disable temporary wikis
let g:vimwiki_global_ext = 0

" NERDTREE
" toggle in the right place: https://github.com/jessarcher/dotfiles/blob/master/nvim/plugins/nerdtree.vim
nnoremap <expr> <leader>n g:NERDTree.IsOpen() ? ':NERDTreeClose<CR>' : @% == '' ? ':NERDTree<CR>' : ':NERDTreeFind<CR>'
nmap <leader>N :NERDTreeFind<CR>
" If more than one window and previous buffer was NERDTree, go back to it.
autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif
" avoid crashes when calling vim-plug functions while the cursor is on the NERDTree window
let g:plug_window = 'noautocmd vertical topleft new'
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1

" JULIA
let g:default_julia_version = '1.0'

" LANGUAGE SERVER
lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- require('folding').on_attach()
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
  buf_set_keymap('n', 'gh', '<cmd>lua vim.lsp.buf.lsp_finder()<cr>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>', opts)
  buf_set_keymap('n', '<leader>ds', '<cmd>lua vim.lsp.buf.document_symbol()<cr>', opts)
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

" TELESCOPE
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fz <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <leader>fw <cmd>Telescope vimwiki<cr>
lua <<EOF
    require('telescope').load_extension('fzf')
    require('telescope').load_extension('vimwiki')
EOF


" PENCIL
let g:pencil#wrapModeDefault = 'soft'
augroup pencil
    autocmd!
    autocmd FileType markdown,mkd call pencil#init()
    autocmd FileType text call pencil#init()
    autocmd FileType tex call pencil#init()
augroup END


" TREESITTER
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    -- disable = { "c", "rust" },
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = {
    enable = true
  },
}
EOF

" VIM-TEST
nnoremap <silent> <leader>tn :TestNearest<cr>
nnoremap <silent> <leader>tf :TestFile<cr>
nnoremap <silent> <leader>ts :TestSuite<cr>
nnoremap <silent> <leader>tl :TestLast<cr>
nnoremap <silent> <leader>tv :TestVisit<cr>

" TROUBLE
nnoremap <leader>xx <cmd>TroubleToggle<cr>
