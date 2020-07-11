call plug#begin()
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'universal-ctags/ctags'
Plug 'webastien/vim-ctags'
Plug 'xolox/vim-misc'
Plug 'prabirshrestha/vim-lsp'
Plug 'ericcurtin/CurtineIncSw.vim'
Plug 'prabirshrestha/async.vim'
Plug 'rhysd/vim-clang-format'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neomake/neomake'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'dikiaap/minimalist'
Plug 'Resonious/vim-camo'
" Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'owickstrom/vim-colors-paramount'
Plug 'reedes/vim-colors-pencil'
Plug 'cideM/yui'
Plug 'hardselius/warlock'
Plug 'LuRsT/austere.vim'
Plug 'jaredgorski/fogbell.vim'
Plug 'danishprakash/vim-yami'
Plug 'andreypopp/vim-colors-plain'
Plug 'axvr/photon.vim'
Plug 'zaki/zazen'
Plug 'robertmeta/nofrils'
Plug 'Lokaltog/vim-monotone'
Plug 'huyvohcmc/atlas.vim'
Plug 'stillwwater/vim-nebula'
Plug 'eemed/sitruuna.vim'
call plug#end()


call neomake#configure#automake('nrwi', 500)

if executable('clangd')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd', '-background-index']},
        \ 'initialization_options': {
            \ 'highlight': { 'enabled' : v:true },
        \ },
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'h', 'hpp'],
        \ })
endif
if executable('pyls')
    " pip install python-language-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python', 'py'],
        \ })
endif
map <F4> :call CurtineIncSw()<CR>
map <F2> :LspDefinition<CR>
map <F3> :LspRename<CR>
let g:clang_format#auto_format = 1
let g:lsp_diagnostics_enabled = 0

imap <c-space> <Plug>(asyncomplete_force_refresh)

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" let g:syntastic_cpp_compiler_options = "-std=c++2a -Wall -Wextra -Wno-extra-semi"
" let g:syntastic_c_compiler_options = "-std=c11 -Wall -Wextra -Wno-extra-semi"
let g:neomake_cpp_enabled_makers=['clang']
let g:neomake_cpp_clang_args = ["-Wall", "-Wextra", "-Weverything", "-std=c++2a", "-Wno-c++98-compat", "-Wno-c++98-c++11-compat-binary-literal", "-Wno-c++98-compat-pedantic", "--pedantic", "-Wimplicit-fallthrough", "-Iinclude", "-fsyntax-only", "-I../include", "@flags.clang"]

function DelayedRunCommandsOnStartup(timer)
    AirlineTheme raven
endfunction

let g:airline_section_z = airline#section#create(['windowswap', '%3p%% ', 'linenr', ':%3v']) 

let timer=timer_start(10,'DelayedRunCommandsOnStartup')

set statusline+=%F

" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
"let g:airline_left_sep = '»'
"let g:airline_left_sep = '▶'
"let g:airline_right_sep = '«'
"let g:airline_right_sep = '◀'
"let g:airline_symbols.linenr = '␊'
"let g:airline_symbols.linenr = '␤'
"let g:airline_symbols.linenr = '¶'
"let g:airline_symbols.branch = '⎇'
"let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = 'Þ'
"let g:airline_symbols.paste = '∥'
"let g:airline_symbols.whitespace = 'Ξ'
"
"" airline symbols
" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''
" let g:airline_symbols.branch = ''
" let g:airline_symbols.readonly = ''
" let g:airline_symbols.linenr = ''

let g:asyncomplete_auto_popup = 0

set path+=**

nnoremap ,cmake :-1read ~/.config/nvim/templates/CMakeLists.txt<CR>5jwli
nnoremap ,cpp   :-1read ~/.config/nvim/templates/cpp.cpp<CR>4ji<TAB>
nnoremap ,main  :-1read ~/.config/nvim/templates/cpp.cpp<CR>4ji<TAB>
nnoremap ,cppsingle :-1read ~/.config/nvim/templates/cppsingle.cpp<CR>

command! Wq wq
command! WQ wq

" colorscheme minimalist
" colorscheme camo
" colorscheme paramount
" colorscheme austere
" colorscheme nebula
colorscheme sitruuna

set nowrap


let g:ctrlp_working_path_mode = 'ra'

let g:ctrlp_user_command = 'find %s -type f \( ! -iname "*.o" ! -path ".git/*" ! -path "*/CMakeFiles/*" ! -path "*/message_logs/*" ! -path "*/.cmake/*" ! -iname "*.cmake" ! -iname "CMakeCache*" ! -iname "*.user" \)'

" let g:cpp_class_scope_highlight = 1
" let g:cpp_member_variable_highlight = 1
" let g:cpp_class_decl_highlight = 1
" let g:cpp_posix_standard = 1

set mouse=a
set clipboard+=unnamedplus
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab autoindent
set incsearch ignorecase smartcase hlsearch
set number 
set splitright
set backspace=indent,eol,start
set undofile
set undodir=/tmp
set nocursorline
set nocursorcolumn
set lazyredraw
set redrawtime=10000
set synmaxcol=180

