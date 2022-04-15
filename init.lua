-- old config pasted into here
vim.cmd([[
	call plug#begin("~/AppData/Local/nvim/autoload/plugged")

	Plug 'ggandor/lightspeed.nvim'
	Plug 'tpope/vim-repeat'
	Plug 'sonph/onehalf', { 'rtp': 'vim' }
	Plug 'neovim/nvim-lspconfig'
	Plug 'bfrg/vim-cpp-modern'
	Plug 'nvim-treesitter/nvim-treesitter'

	call plug#end()

	" Set truecolor
	if exists('+termguicolors')
	  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	  set termguicolors
	endif


	noremap ; :
	"nnoremap : ,
	"nnoremap , ;
	map , <Plug>Lightspeed_;_ft
	map : <Plug>Lightspeed_,_ft
	noremap <CR> G

	nnoremap <F5> :w<CR>:make<CR>
	nnoremap <Left> :cp<CR>
	nnoremap <Right> :cn<CR>
]])

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

require'lspconfig'.clangd.setup{}
--vim.cmd("let g:coq_settings = { 'auto_start': 'shut-up', 'completion.always': v:false, 'keymap.manual_complete': '<C-a>', 'keymap.pre_select': v:true, 'limits.completion_manual_timeout': 2}")
--require("coq")

vim.opt.nu = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0
vim.opt.mouse = "nvi"
vim.opt.signcolumn = "yes"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.magic = false

vim.opt.cursorline = true
vim.cmd 'colorscheme onehalfdark'

-- depends on OS
vim.opt.undofile = true
vim.opt.undodir = "C:/apps/Neovim/undodir"
vim.opt.makeprg = "gnumake"

--vim.opt.omnifunc = "v:lua.vim.lsp.omnifunc"

vim.api.nvim_buf_set_keymap(0, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', {noremap = true})
vim.cmd 'nnoremap <c-]> <cmd>lua vim.lsp.buf.definition()<CR>'
vim.cmd 'autocmd FileType cpp set omnifunc=v:lua.vim.lsp.omnifunc'
vim.cmd 'au BufRead,BufNewFile *.ixx set filetype=cpp'
vim.opt.completeopt = 'menu,longest'
--on_attach = function() vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc') end
vim.opt.wildignore = '*.o,*.pcm,*.exe,*.out'
