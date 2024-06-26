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
"let g:did_load_filetypes = 0

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
" accept local or remote changes with mergetool
nnoremap <A-,> :diffget LOCAL<cr>
nnoremap <A-.> :diffget REMOTE<cr>
nnoremap <A-/> :diffget BASE<cr>
vnoremap <A-,> :diffget LOCAL<cr>
vnoremap <A-.> :diffget REMOTE<cr>
vnoremap <A-/> :diffget BASE<cr>
" print current syntax group under cursor
function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun
map gm :call SynGroup()<CR>
" terminal enter/exit easily
nnoremap <leader>t :sp +te<cr>:startinsert<cr>
nnoremap <leader>vt :vs +te<cr>:startinsert<cr>
tnoremap <esc> <c-\><c-n>
" populate quickfix. Note this is overwritten by LSP if present???
nnoremap <leader>Q :cad<cr>:cw<cr>
" make sure gf always creates a file
map gf :e <cfile><CR>

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
Plug 'RRethy/vim-hexokinase'  " requires hexokinase binary
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neosnippet.vim'
Plug 'abeleinin/papyrus'
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'  " sets wd to root of project
Plug 'bronson/vim-visual-star-search'  " # and * works with visual mode
Plug 'deoplete-plugins/deoplete-lsp'
Plug 'ellisonleao/gruvbox.nvim'
Plug 'ethanholz/nvim-lastplace'
Plug 'f-person/git-blame.nvim'
Plug 'folke/trouble.nvim'
Plug 'kkoomen/vim-doge', {'do': ':call doge#install()'}
Plug 'kyazdani42/nvim-tree.lua'
Plug 'kyazdani42/nvim-web-devicons'  " needed for trouble and nvim-tree
Plug 'lambdalisue/suda.vim'
Plug 'lervag/vimtex'
Plug 'mg979/vim-visual-multi'
Plug 'mhinz/neovim-remote'  " dep of a few plugins?
Plug 'mhinz/vim-startify'
Plug 'neovim/nvim-lspconfig'
Plug 'numToStr/Comment.nvim'
Plug 'nvim-lua/plenary.nvim'  " dep of telescope
Plug 'nvim-lualine/lualine.nvim'  " patched nerd font needed for icons
Plug 'nvim-telescope/telescope-fzf-native.nvim', {'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context'  " shows outer functions/classes at top
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'p00f/nvim-ts-rainbow'  " rainbow brackets from treesitter (might fail soon cause deprecation)
Plug 'preservim/vim-pencil'  " small utility for writing prose (wrap, movement, etc)
Plug 'sickill/vim-pasta'  " paste respecting indentation
Plug 'tikhomirov/vim-glsl'
Plug 'tpope/vim-abolish'  " Smart-case replace with fancy plural handling and stuff
Plug 'tpope/vim-fugitive'  " Git commands
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'  " cs, ds, ys mappings to change surrounding
Plug 'tpope/vim-unimpaired'  " e.g: ]b ]e ]space yod yos
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-test/vim-test'
Plug 'vimwiki/vimwiki'
Plug 'wellle/targets.vim'  " more text objects (like parens, commas, quotes..., args)
call plug#end()


" PLUGIN SETTINGS

" GRUVBOX
let g:gruvbox_italic=1
let g:gruvbox_transparent_bg=1
lua << EOF
local config = require("gruvbox").config
local colors = require("gruvbox").palette
require("gruvbox").setup({
    overrides = {
        Character = {fg = colors.neutral_green, italic = config.italic.strings},
        Float = {fg = colors.neutral_purple},
        Boolean = {fg = colors.purple, bold = config.bold},
    }
})
vim.cmd("colorscheme gruvbox")
EOF

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

" NVIM-TREE
lua << EOF
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require'nvim-tree'.setup()
EOF
nnoremap <leader>n :NvimTreeToggle<cr>
" auto-close if last remaining
autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif

" LUALINE
lua << EOF
local git_blame = require('gitblame')
require('lualine').setup {
    options = {
        globalstatus = true,
        theme = 'gruvbox_dark',
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', {'diagnostics', sources={'nvim_diagnostic', 'nvim_lsp'}}},
        lualine_c = {'filename', {git_blame.get_current_blame_text, cond=git_blame.is_blame_text_available}},
        lualine_x = {'buffers', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'},
    },
}
EOF

" NEOSNIPPETS
imap <m-tab> <Plug>(neosnippet_expand_or_jump)
smap <m-tab> <Plug>(neosnippet_expand_or_jump)
xmap <m-tab> <Plug>(neosnippet_expand_target)
let g:neosnippet#snippets_directory="${XDG_DATA_HOME}/nvim/custom/snippets"

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
" NOTE: need to install python-lsp opt dependencies! see https://github.com/python-lsp/python-lsp-server
"       on arch: python-lsp-all and python-lsp-ruff
lua << EOF
local nvim_lsp = require('lspconfig')
local servers = { 'pylsp', 'julials', 'ccls', 'typst_lsp'}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    init_options = {
      cache = {
        directory = '.lsp-cache'
      }
    }
  }
end

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf , noremap = true}
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gsd', function() vim.api.nvim_command('split') vim.lsp.buf.definition() end, opts)
    vim.keymap.set('n', 'gvsd', function() vim.api.nvim_command('vsplit') vim.lsp.buf.definition() end, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>k', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>cf', function() vim.lsp.buf.format { async = true } end, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  end,
})
EOF

" TELESCOPE
lua <<EOF
local telescope = require("telescope")
local builtin = require('telescope.builtin')

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

-- https://github.com/nvim-telescope/telescope.nvim/issues/564#issuecomment-1410204181
function fuzzyFindFiles()
    require'telescope.builtin'.grep_string({
    path_display = { 'tail' },
    only_sort_text = true,
    search = '',
  })
end

vim.keymap.set('n', '<leader>ff', builtin.find_files)
vim.keymap.set('n', '<leader>fg', fuzzyFindFiles)
vim.keymap.set('n', '<leader>fb', builtin.buffers)
vim.keymap.set('n', '<leader>fh', builtin.help_tags)
vim.keymap.set('n', '<leader>fz', builtin.current_buffer_fuzzy_find)
vim.keymap.set('n', '<leader>fw', telescope.extensions.vimwiki.vimwiki)
vim.keymap.set('n', '<leader>fm', builtin.keymaps)
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
set nofoldenable
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
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["as"] = "@scope.outer",
        ["is"] = "@scope.inner",
        ["ap"] = "@parameter.outer",
        ["ip"] = "@parameter.inner",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>a"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>A"] = "@parameter.inner",
      },
    },
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

" PAPYRUS
let g:papyrus_latex_engine = 'xelatex'
let g:papyrus_viewer = 'okular'
let g:papyrus_template = 'default'

map <leader>pc :PapyrusCompile<cr>
map <leader>pa :PapyrusAutoCompile<cr>
map <leader>pv :PapyrusView<cr>
map <leader>ps :PapyrusStart<cr>
map <leader>ph :PapyrusHeader<cr>

" SPLITJOIN
let g:splitjoin_split_mapping = ''
let g:splitjoin_join_mapping  = ''
nnoremap <leader>s :SplitjoinSplit<cr>
nnoremap <leader>j :SplitjoinJoin<cr>
let g:splitjoin_trailing_comma = 1
let g:splitjoin_python_brackets_on_separate_lines = 1

" GIT-BLAME
nnoremap <leader>gc :GitBlameOpenCommitURL
" disable virtual text cause we show it in lualine
let g:gitblame_display_virtual_text = 0

" GITGUTTER
nnoremap <leader>hd :GitGutterDiffOrig<cr>
