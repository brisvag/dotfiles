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
set wildmode=longest:full,full
set list
set listchars=tab:▸\ ,trail:·
set nojoinspaces
set updatetime=300 " Reduce time for highlighting other references
set redrawtime=10000 " Allow more time for loading syntax on large files
set completeopt=menu,menuone,noselect
set noshowmode
set background=dark

" TMP: new filetype detection
let g:do_filetype_lua = 1
let g:did_load_filetypes = 0

au BufRead,BufNewFile *.ipy set filetype=python
au BufRead,BufNewFile *.qss set filetype=css
" Automatically reload file when entering buffer or gaining focus
au FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif

" ensure plugins always use system python
let g:python3_host_prog = '/usr/bin/python'


" GENERAL MAPPINGS

" Split tabs navigation shortcuts
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" Move/indent visual selection
vnoremap <S-Left> <gv
vnoremap <S-Right> >gv
vmap <S-Up> [egv
vmap <S-Down> ]egv
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
nnoremap <A-,> :diffget LOCAL<CR>
nnoremap <A-.> :diffget REMOTE<CR>
nnoremap <A-/> :diffget BASE<CR>
vnoremap <A-,> :diffget LOCAL<CR>
vnoremap <A-.> :diffget REMOTE<CR>
vnoremap <A-/> :diffget BASE<CR>


" PLUGINS
" Automatically install vim-plug
let data_dir =  stdpath('data') . '/site'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" pynvim needed!
call plug#begin("$XDG_DATA_HOME/nvim/plugged")
Plug 'AndrewRadev/splitjoin.vim'
Plug 'ElPiloto/telescope-vimwiki.nvim'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'RRethy/vim-hexokinase' " requires hexokinase binary
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neosnippet.vim'
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'bronson/vim-visual-star-search'
Plug 'deoplete-plugins/deoplete-lsp'
Plug 'ellisonleao/gruvbox.nvim'
Plug 'ethanholz/nvim-lastplace'
Plug 'folke/trouble.nvim'
Plug 'f-person/git-blame.nvim'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-easy-align'
Plug 'kkoomen/vim-doge', { 'do': ':call doge#install()'}
Plug 'kyazdani42/nvim-tree.lua'
Plug 'kyazdani42/nvim-web-devicons' " needed for trouble and nvim-tree
Plug 'lambdalisue/suda.vim'
Plug 'lervag/vimtex'
Plug 'liuchengxu/vista.vim'
Plug 'mfussenegger/nvim-dap'
Plug 'mfussenegger/nvim-dap-python'
Plug 'mg979/vim-visual-multi'
Plug 'mhinz/neovim-remote'
Plug 'mhinz/vim-startify'
Plug 'neovim/nvim-lspconfig'
Plug 'numToStr/Comment.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lualine/lualine.nvim' " patched nerd font needed for icons
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/playground'
Plug 'p00f/nvim-ts-rainbow'
Plug 'preservim/vim-pencil'
Plug 'sickill/vim-pasta'
Plug 'tikhomirov/vim-glsl'
Plug 'tommcdo/vim-exchange'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-test/vim-test'
Plug 'vimwiki/vimwiki'
Plug 'wellle/targets.vim'
call plug#end()


" PLUGIN SETTINGS

" GRUVBOX
let g:gruvbox_italic=1
let g:gruvbox_transparent_bg=1
colorscheme gruvbox

" DEOPLETE
let g:deoplete#enable_at_startup = 1
call deoplete#custom#source('_', 'smart_case', v:true)
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
"let g:vista_default_executive = 'nvim_lsp'

" NVIM-TREE
lua require'nvim-tree'.setup()
nnoremap <leader>t :NvimTreeToggle<cr>
" auto-close if last remaining
autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif

" LUALINE
lua << EOF
require('lualine').setup {
    options = {
        globalstatus = true,
        theme = 'gruvbox_dark',
        sections = {
            lualine_a = {'mode'},
            lualine_b = {'branch', 'diff', {'diagnostics', sources={'nvim_diagnostic'}}},
            lualine_c = {'filename'},
            lualine_x = {'buffers'},
            lualine_y = {'progress'},
            lualine_z = {'location'}
        },
    }
}
EOF

" NEOSNIPPETS
imap <m-tab> <Plug>(neosnippet_expand_or_jump)
smap <m-tab> <Plug>(neosnippet_expand_or_jump)
xmap <m-tab> <Plug>(neosnippet_expand_target)
let g:neosnippet#snippets_directory="${XDG_DATA_HOME}/nvim/custom/snippets"

" AUTOPAIR
let g:AutoPairsShortcutBackInsert = '<M-b>'

" VIMTEX and latex-related
" Enable latex filetype even for empty .tex files
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
let g:vimtex_quickfix_mode=2
let g:vimtex_fold_enabled = 1
let g:vimtex_fold_types = {
           \ 'preamble' : {'enabled' : 1},
           \ 'sections' : {'enabled' : 1},
           \ 'envs' : {
           \   'blacklist' : ['figures'],
           \ },
           \}
" shell escape is needed to run external tools needed for compilation
let g:vimtex_compiler_latexmk_engines = {
    \ '_': '-pdf -shell-escape -lualatex',
    \}
let g:vimtex_syntax_enabled = 0
let g:vimtex_syntax_conceal_disable = 1

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
  buf_set_keymap('n', '<leader>k', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.open_float()<cr>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.setloclist()<cr>', opts)
  -- buf_set_keymap('n', '<leader>ds', '<cmd>lua vim.lsp.buf.document_symbol()<cr>', opts)
  buf_set_keymap('n', '<leader>r', '<cmd>lua vim.lsp.buf.formatting()<cr>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pylsp', 'julials' }
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
nnoremap <leader>fg <cmd>Telescope grep_string only_sort_text=true<cr>  "vim-telescope/telescope.nvim#564
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fz <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <leader>fw <cmd>Telescope vimwiki<cr>
lua <<EOF
    local telescope = require("telescope")

    telescope.setup {
        defaults = {
            set_env = {["COLORTERM"] = "truecolor"}, -- default = nil,
        },
        pickers = {
            find_files = {
                find_command = {
                    "fd",
                    "--type", "file",
                    "--exclude", ".git/",
                    "--hidden",  -- show hidden files
                },
            },
        },
    }

    telescope.load_extension('fzf')
    telescope.load_extension('vimwiki')
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
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "python", "julia", "json", "glsl", "latex", "bash", "vim", "lua"},
  highlight = {
    enable = true,
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
  textobjects = {
    enable = true
  },
  context = {
    enable = true
  },
  rainbow = {
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

" COMMENT
lua require('Comment').setup()

" EASY-ALIGN
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" DOGE
let g:doge_doc_standard_python = 'numpy'
