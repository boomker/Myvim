
" -----------------------------------------------------------------------------
"  < 判断操作系统是否是 Windows 还是 Unix >
" -----------------------------------------------------------------------------
let g:isWin = 0
let g:isUnix = 0
if(has("win32") || has("win64"))
    let g:isWin = 1
else
    let g:isUnix = 1
endif

" -----------------------------------------------------------------------------
"  < 判断是终端还是 Gvim >
" -----------------------------------------------------------------------------
if has("gui_running")
    let g:isGUI = 1
    set imi=2                                             "搜狗输入法在macvim混乱的解决方法如下:
    set ims=2
    set guiheadroom=0                                     "禁止GTK填充窗口底部为主题背景色，此设置会消除底部的水平滚动条"
    set termguicolors
    " set background=light
    colorscheme onedark
    " colorscheme solarized8_dark_flat
    syntax on
    " 下面一行的注释必须放下面，不然就被上面一样的设置给覆盖掉
    " highlight Comment gui=italic
    " 在 GUIvim 里中文看不到是斜体的，似乎需要斜体中文字体支持
else
    let g:isGUI = 0
    set t_Co=256                   " 在终端启用256色
    set background=dark
    colorscheme gruvbox
    " colorscheme solarized8_dark_flat
    syntax on
    " highlight Comment cterm=italic
endif

if (g:isWin && g:isGUI)
    source ${VIMRUNTIME}/vimrc_example.vim
    source ${VIMRUNTIME}/mswin.vim
    " behave mswin
    language messages zh_CN.utf-8                           "解决状态信息栏乱码问题
    set iminsert=2                                          "输入法设置"
    set mousef                                              "启用光标激活pane
    set mouse=a                                           " 在任何模式下启用鼠标,但是右键用不了
    au GUIEnter * simalt ~x                                 "窗口启动时自动最大化
    autocmd bufwritepost .vimrc source $VIM/_vimrc
endif

if (g:isUnix)
    set rtp+=~/gitrep/fzf
    if exists('$TMUX')
        let &t_8f = "\<ESC>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<ESC>[48;2;%lu;%lu;%lum"
    endif
endif

if has('nvim')
    colorscheme onedark
    set runtimepath+=~/.nvim/share/nvim/runtime
    let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
    let $XDG_CONFIG_HOME="~/.nvim"
    let &packpath = &runtimepath
    let g:python3_host_prog = '/usr/local/bin/python3'
    let g:python_host_prog  = '/usr/local/bin/python'
endif

if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

" 设置标记一列的背景颜色和数字一行颜色一致
hi! link SignColumn   LineNr
hi! link ShowMarksHLl DiffAdd
hi! link ShowMarksHLu DiffChange

" for error highlight，防止错误整行标红导致看不清
highlight clear SpellBad
highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline
highlight clear SpellCap
highlight SpellCap term=underline cterm=underline
highlight clear SpellRare
highlight SpellRare term=underline cterm=underline
highlight clear SpellLocal
highlight SpellLocal term=underline cterm=underline

set guifont=Source_Code_Pro_for_Powerline:h15,Sauce_Code_Pro_Medium_Nerd_Font_Complete_Mono:15
" set guifont=Source_Code_Variable_Semibold:h14

set nocompatible                                      "禁用 Vi 兼容模式
set shortmess=atI                                     "去掉欢迎界面
set guioptions-=m                                     "去掉菜单栏"
set guioptions-=e                                     "去掉标签栏"
set guioptions-=T                                     "去掉工具栏"
set guioptions-=r                                     "去掉右边的滚动条"
set guioptions-=L
set laststatus=2                                      "启用状态栏信息
set showtabline=2                                     "当只有一个标签时也显示标签行
set noshowmode                                        " 使用 airline 时不再显示模式状态
set noshowcmd
set lazyredraw
set helplang=cn
set number                                            "显示行号
set wrap                                              "设置自动折行
set formatoptions+=j
" set nolinebreak                                       "不自动换行
set magic                                             "打开正则匹配模式
set noimd                                             "关闭输入法
set nobomb                                            " 禁止UTF-8 BOM
set termencoding=utf-8
set encoding=utf-8                                      "设置gvim内部编码
set fileencoding=utf-8                                  "设置此缓冲区所在文件的字符编码
set fileencodings=utf-8,cp936,ucs-bom,gb18030,gb2312    "设置支持打开的文件的编码
set fileformat=unix
set fileformats=unix,dos                                "给出文件的<EOL>格式类型
set backspace=indent,eol,start
set viewoptions=folds,options,cursor,unix,slash         "better unix/Windows compatible
set virtualedit=onemore                                 "curso可以移动到行尾最后一个字符之后"
set autochdir
set autoindent
set smartindent                                         "启用智能对齐方式
set shiftround
set smarttab                                            "指定行首按一次backspace就删除shiftwidth宽度的空格
set expandtab                                           "将Tab键转换为空格
set tabstop=4                                           "设置Tab键的宽度
set softtabstop=4
set shiftwidth=4                                        "换行时自动缩进4个空格
set scrolloff=3                                         "上下滚动时当前行距顶或低保持有3行"
set cursorcolumn                                        "突出显示当前行
" set cursorline cursorcolumn                           "突出显示当前行
set colorcolumn=120
set selection=inclusive
set selectmode=mouse,key
set ttyfast

set foldenable                                          "启用折叠
" set foldmethod=marker
set foldmethod=indent                                   "indent 折叠方式
" set foldopen=all                                        "光标移到折叠时自动打开
" set foldclose=all
set autoread                                            "当文件在外部被修改，自动更新该文件
set clipboard=unnamed                                   "与其他应用共享剪贴板,抽出和粘贴选择内容,而无须在这些命令前面附加"*.
set hlsearch                                "高亮搜索
set incsearch                               "在输入要搜索的文字时，实时匹配
set ignorecase                              "搜索模式里忽略大小写
set smartcase                               "搜索模式包含大写字符，忽略上一行设置
set matchtime=3                             "匹配括号光标停留时间"
set showmatch
set matchpairs+=<:>                         " specially for html"
set history=500                             "保存更多的history"
set wildmenu
set vb t_vb=                                "关闭提示音
set nobackup                                "设置无备份文件
set noswapfile                              "设置无临时文件
set nowritebackup                           "无写入备份
filetype plugin on
autocmd! bufwritepost .vimrc source ~/.vimrc
au BufRead,BufNewFile,BufEnter * cd %:p:h               "自动切换到正在编辑文件所在的目录
"au BufWinEnter * let w:m2=matchadd('Underlined', '\%>' . 78 . 'v.\+', -1)
" au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" ===============< Hotkey mapping >======================
let mapleader = ";"
inoremap <ESC> <ESC>:nohl<CR>
inoremap <C-e> <C-y>
inoremap <C-y> <C-e>
" quick movements in Insert-Mode
inoremap II <Esc>I
inoremap AA <Esc>A
inoremap OO <Esc>o

nnoremap <leader><space> :nohl<CR>
nmap <Up> <Nop>
nmap <Down> <Nop>
nmap <Left> <Nop>
nmap <Right> <Nop>
noremap <silent> <expr> j (v:count == 0 ? 'gjzz' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gkzz' : 'k')
noremap '' ''zz
vmap j gj
vmap k gk

nmap J gJ
nmap gh ^
nmap ge $
noremap gl gu
noremap gu gU
" select last paste in visual mode
nnoremap <expr> gb '`[' . strpart(getregtype(), 0, 1) . '`]'
nmap gp <Plug>GitGutterPrevHunk
nmap gn <Plug>GitGutterNextHunk

nmap sf :w!<CR>
nmap sj <C-o>
nmap sk <C-i>
nmap su <C-r>

" like o or O, but not change cursor position and mode
nmap tj mQo<esc>`Qm<space>
nmap tk mQ<S-o><esc>`Qm<space>
nmap tt :tabnew!<CR>
nmap tn :tabn<CR>
nmap tp :tabp<CR>
nmap tw vwP
noremap cp ""P

nmap md <S-*>
nmap ms <S-#>
nmap mm ``

nnoremap <CR> :
" Delete character end of current cursor
nmap dh d^
nmap de d$
nmap d<CR> dG
nmap dj 2dd
nmap dk k2dd
nmap y<CR> yG
nmap yj 2yy
nmap yk k2yy
nmap yh y^
nmap ye y$
nmap yp yyp
nmap ysiw{ ysiw}

nnoremap zg :q!<CR>
nnoremap zp <C-w>pZQ
nnoremap zf <S-z><S-z>
nnoremap zl <C-w>v
nnoremap zh <C-w>s
" space key to toggle whether fold
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zO')<CR>

cnoremap <C-a> <Home>
cnoremap <c-v> <C-r>"

nnoremap <leader>cp I#<Space><Home><Tab><ESC>
vnoremap < <gv
vnoremap > >gv
vnoremap v <Esc>

" saving file as sudo when forgot to start vim using sudo
nmap <Leader>sw :w !sudo tee > /dev/null %<CR>
command! W w !sudo tee % > /dev/null

" quickly way to move between buffers or tabs
nmap <Leader>wj <C-W>j
nmap <Leader>wk <C-W>k
nmap <Leader>wh <C-W>h
nmap <Leader>wl <C-W>l

noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>
noremap <leader>bf :tabfirst<cr>
noremap <leader>bl :tablast<cr>
noremap <leader>bb :tabprev<cr>
noremap <leader>bn :tabnext<cr>
noremap <leader>bm :tabmove

" ------------------------------------< Complex configure >------------------------------------
"  in the normal mode autoset relative_number
augroup relative_numbser
    autocmd!
    autocmd InsertEnter * :set norelativenumber
    autocmd InsertLeave * :set relativenumber
augroup END

" highlight keyword
if has("autocmd")
    " Highlight TODO, FIXME, NOTE, etc.
      if v:version > 701
          autocmd Syntax * call matchadd('Todo', '\W\zs\(TODO\|IDEA\|NOTE\|NOTICE\|重要\|要点\|注意\|现象\|原因\|解决\)')
          autocmd Syntax * call matchadd('ErrorMsg', '\W\zs\(HACK\|XXX\|错误\|故障\)')
      endif
endif

" 以下是让 insert mode 的光标成为下划线, 一个终极的解决办法就是安装terminus plugin
" if exists('$ITERM_PROFILE')
    " if exists('$TMUX') 
        " let &t_SI = "\<Esc>[3 q"
        " let &t_EI = "\<Esc>[0 q"
    " else
        " let &t_SI = "\<Esc>]50;CursorShape=1\x7"
        " let &t_EI = "\<Esc>]50;CursorShape=0\x7"
    " endif
" endif

" 设置在 tmux & xterm 里粘贴系统剪贴板里的字符时保持原有排版格式
function! WrapForTmux(s)
    if !exists('$TMUX')
        return a:s
    endif

    let tmux_start ="\<Esc>Ptmux;"
    let tmux_end ="\<Esc>\\"

    return tmux_start . substitute(a:s,"\<Esc>","\<Esc>\<Esc>",'g'). tmux_end
endfunction
let&t_SI .=WrapForTmux("\<Esc>[?2004h")
let&t_EI .=WrapForTmux("\<Esc>[?2004l")

" 在tmux 里使用 tmux 的方式复制文本的话(跨窗口共享 tmux buffer), 粘贴时直接使用<C-V>/<⌘ -V>
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
function! XTermPasteBegin()
    set pastetoggle=<Esc>[201~
    set paste
    return""
endfunction

" 设置 Python/shell 文件格式的文件头部信息
autocmd BufNewFile *.py,*.sh :call SetFileHeadInfo()
let $author_name = "Shingo"
let $author_email = "gmboomker@gmail.com"
func! SetFileHeadInfo()
    if expand("%:e") == 'py'
        " call setline(1, '#!/usr/local/bin/genv python3')
        call setline(1, '# !/usr/bin/env python3')
    elseif expand("%:e") == 'sh'
        " call setline(1, '#!/usr/bin/env bash')
        call setline(1, '# !/usr/local/bin/env bash') 
        " call setline(1, '#!/usr/local/bin/genv bash') 
    endif
    call append(1, '# *************************************************')
    call append(2, '#')
    call append(3, '#       Filename: '.expand("%"))
    call append(4, '#         Author: '.$author_name)
    call append(5, '#          Email: '.$author_email)
    call append(6, '#         Create: '.strftime("%Y-%m-%d %H:%M:%S"))
    call append(7, '#       Description: -')
    call append(8, '#')
    call append(9, '# *************************************************')
    normal Go
endfunc
map <Leader>sh <ESC>ggO<ESC>:call SetFileHeadInfo()<CR>

" Delete trailing whitespace
autocmd FileType python,go,php,javascript,yml,txt,sh autocmd BufWritePre <buffer> :call StripTrailingWhitespaces()
fun! StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

" open terminal in specified eatra split window
" press <C-d> to exit terminal
if has('nvim')
    func! OpenTerminal()
        " open split windows on the topleft
        topleft split
        " resize the height of terminal windows to 30
        resize 15
        :terminal
    endf
else
    func! OpenTerminal()
        topleft split
        resize 15
        :call term_start('zsh', {'curwin' : 1, 'term_finish' : 'close'})
    endf
endif
nnoremap <Leader>ot :call OpenTerminal()<cr>
nnoremap <Leader>zt :ZoomWinTabToggle<cr>
" ==============< Plugins configure >================

" vim easymotion configure:
    let g:EasyMotion_smartcase = 1
    let g:EasyMotion_leader_key = 'f'
    let g:EasyMotion_startofline = '0'
    nmap fu <Plug>(easymotion-N)
    nmap f/ <Plug>(easymotion-fn)
    " support multi keyword used expr to find
    nmap f? <Plug>(easymotion-Fn)
    nmap ff <Plug>(easymotion-w)
    nmap fh <Plug>(easymotion-lineanywhere)
    nmap fl <Plug>(easymotion-lineforward)
    nmap fo <Plug>(easymotion-overwin-f)
    nmap fi <Plug>(easymotion-overwin-line)
    nmap f. <Plug>(easymotion-repeat)

" airline configure:
    " let g:airline_theme='wombat'
    " let g:airline#extensions#tabline#show_buffers = 0
    " let g:airline#extensions#tabline#show_tab_type = 0
    " let g:airline#extensions#tabline#show_close_button = 0
    " let g:airline#extensions#tabline#right_alt_sep = ''
    " let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
    " let g:airline_powerline_fonts = 1
    " let g:airline_extensions = ['tabline', 'ale', 'obsession']
    " let g:airline#extensions#whitespace#symbol = 'WS'
    " let b:airline_whitespace_checks = [ 'indent', 'trailing' ]
    " let g:ale_pattern_options = {'python实例手册.py$': {'ale_enabled': 0}}

" lightline configure:
	let g:lightline = {
		\ 'component': {
		\   'lineinfo': ' %3l:%-2v',
		\ },
		\ 'component_function': {
		\   'readonly': 'LightlineReadonly'
		\ },
		\ 'separator': { 'left': '', 'right': '' },
		\ 'subseparator': { 'left': '', 'right': '' }
		\ }
	function! LightlineReadonly()
		return &readonly ? '' : ''
	endfunction

" easy_align configure:
    vmap <Enter> <Plug>(EasyAlign)
    nmap <Leader>ga <Plug>(EasyAlign)
    xmap <Leader>ga <Plug>(EasyAlign)

" multiplecursors configure:
    let g:multi_cursor_use_default_mapping=0
    " Default mapping
    let g:multi_cursor_start_key='<C-n>'
    let g:multi_cursor_next_key='<C-n>'
    let g:multi_cursor_prev_key='<C-p>'
    let g:multi_cursor_skip_key='<C-x>'
    let g:multi_cursor_quit_key='<Esc>'

" Leaderf configure:
    nnoremap <Leader>fh :LeaderfMru<CR>
    nnoremap <Leader>fl :LeaderfLine<CR>
    let g:Lf_ShortcutF = '<Leader>ff'
    let g:Lf_ShortcutB = '<Leader>fb'
    let g:Lf_DefaultMode = 'Regex'
    let g:Lf_NeedCacheTime = 0.5
    let g:Lf_WildIgnore = {
       \ 'dir': ['.svn','.git','.hg','.DS_Store','*node_modules','*compiled','*dist'],
       \ 'file': ['*.sw?','~$*','*.dat','*.exe','*.o','*.so','*.py[co]']
       \}

" ctrsf configure:
    nmap <leader>sf :CtrlSF<space>-smartcase -R<space>
    nmap <leader>fw <Plug>CtrlSFCCwordExec
    let g:ctrlsf_default_view_mode = 'compact'
    let g:ctrlsf_regex_pattern = 1

" fzf configure:
    command! -bang -nargs=* Ag
        \ call fzf#vim#ag(<q-args>,
        \                 <bang>0 ? fzf#vim#with_preview('up:60%')
        \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
        \                 <bang>0)
    command! -bang Colors
        \ call fzf#vim#colors({'left': '15%', 'options': '--reverse --margin 30%,0'}, <bang>0)
    command! -bang -nargs=? -complete=dir Files
        \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
    nmap <leader>fs :Files<CR>
    nmap <leader>fa :Ag<CR>

" nerdcommenter configure:
    let g:NERDSpaceDelims=1
    let g:NERDCompactSexyComs = 1
    let g:NERDAltDelims_python = 1
    let g:NERDDefaultAlign = 'left'

" nerdtree configure:
    map <leader>st :NERDTreeToggle<CR>
    let NERDTreeIgnore=['\.pyc','\~$','\.swp','__pycache__','\.git$','\.DS_Store']
    let g:nerdtree_tabs_open_on_gui_startup=0
    let g:NERDTreeMapToggleBookmarks="b"
    let g:NERDTreeMapChangeRoot="c"
    let g:NERDTreeMapChdir="C"
    let g:NERDTreeMapCWD="w"
    let g:NERDTreeMapToggleFiles=";f"
    let g:NERDTreeMapToggleFilters="F"
    let g:NERDTreeMapToggleZoom="zm"
    let NERDTreeQuitOnOpen=1
    let NERDTreeShowHidden=1
    let NERDTreeDirArrows=0
    let NERDTreeAutoDeleteBuffer=1
    let NERDTreeHijackNetrw=1
    let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }
    " autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    " vim不指定具体文件打开是，自动使用nerdtree
    autocmd StdinReadPre * let s:std_in=1
    " autocmd VimEnter,GUIEnter * if argc() == 0 && !exists("s:std_in") | NERDTree |endif

" gitgutter configure configure:
    set updatetime=50
    let g:gitgutter_max_signs = 1000
    let g:gitgutter_sign_added = '✚'
    " let g:gitgutter_sign_modified = '✎'
    let g:gitgutter_sign_modified = '☻'
    let g:gitgutter_sign_removed = '✖'
    let g:gitgutter_sign_removed_first_line = '➤'
    let g:gitgutter_sign_modified_removed = '✹'
    let g:easygit_enable_command = 1

" GundoToggle configure:
    nnoremap <Leader>ut :GundoToggle<CR>
    let g:gundo_prefer_python3 = 1

" ale configure:
    let g:ale_fix_on_save = 1
    let g:ale_completion_enabled = 1
    let g:ale_sign_column_always = 1
    " let g:ale_set_highlights = 1
    let g:ale_set_highlights = 0
    let g:ale_sign_error = '◉'
    let g:ale_sign_warning = '◉'
    highlight! ALEErrorSign ctermfg=9 guifg=#C30500
    highlight! ALEWarningSign ctermfg=11 guifg=#F0C674
    let g:ale_echo_msg_error_str = 'E'
    let g:ale_echo_msg_warning_str = 'W'
    let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
    let g:ale_open_list = 0
    let g:ale_lint_delay = 500
    let g:ale_python_flake8_options="--ignore=E114,E116,E131,E221,E501 --max-line-length=120"
    " https://blog.csdn.net/zgljl2012/article/details/51907663
    let g:ale_emit_conflict_warnings = 0
    nmap sn <Plug>(ale_next_wrap)
    nmap sp <Plug>(ale_previous_wrap)

" tagbar configure:
    let g:tagbar_sort=0
    let g:tagbar_compact=1
    let g:tagbar_indent = 1
    let g:tagbar_autoshowtag=1
    let g:tagbar_autoclose = 1
    let g:tagbar_autofocus = 1
    let g:tagbar_autopreview = 1
    let g:tagbar_singleclick = 1
    let g:tagbar_width = 35
    let g:tagbar_systemenc = 'utf-8'
    let g:tagbar_map_nexttag = "J"
    let g:tagbar_map_prevtag = "K"
    let g:tagbar_map_openallfolds = "ao"
    let g:tagbar_map_closeallfolds = "ac"
    nmap <Leader>tb :TagbarToggle<CR>

" markdown configure:
    au bufread,bufnewfile *.md,*.markdown setlocal ft=mkd
    let g:vim_markdown_folding_disabled=1
    let g:vim_markdown_no_default_key_mappings=1
    let g:vim_markdown_math=1
    let g:vim_markdown_frontmatter=1

" YouCompleteMe configure:
    " completor和YCM一样都是补全插件, 但是和YCM有冲突
    " let g:completor_python_binary = '/usr/local/bin/python3' 
    " completor 是基于标签补全的, 同时还可以模糊匹配Snippets的key
    let g:ycm_python_binary_path = 'python3'
    let g:ycm_path_to_python3_interpreter = '/usr/local/bin/python3'
    " 禁止缓存匹配项,每次都重新生成匹配项
    let g:ycm_cache_omnifunc = 0
    " 开启语义补全
    let g:ycm_seed_identifiers_with_syntax = 1
    " 在注释输入中也能补全
    let g:ycm_complete_in_comments = 1
    " 在字符串输入中也能补全
    let g:ycm_complete_in_strings = 1
    let g:ycm_use_ultisnips_completer = 1
    let g:ycm_collect_identifiers_from_tags_files = 1
    let g:ycm_collect_identifiers_from_comments_and_strings = 1
    " 输入第2个字符开始补全
    let g:ycm_min_num_of_chars_for_completion = 2
    let g:ycm_max_diagnostics_to_display = 0
    let g:ycm_show_diagnostics_ui = 0
    let g:ycm_key_invoke_completion = '<c-space>'
    " let g:ycm_key_list_select_completion = ['<C-n>', '<C-j>']
    " let g:ycm_key_list_previous_completion = ['<C-p>', '<C-k>']
    let g:ycm_key_list_select_completion = ['<C-n>', '<Tab>']
    let g:ycm_key_list_previous_completion = ['<C-p>']
    let g:ycm_autoclose_preview_window_after_completion = 1
    let g:ycm_autoclose_preview_window_after_insertion = 1
    let g:ycm_filetype_whitelist = { 
        \ 'sh': 1,
        \ 'python': 1,
        \ }
    let g:ycm_filetype_blacklist = { 
        \ 'tagbar' : 1,
        \ 'nerdtree' : 1,
        \ 'gitcommit' : 1,
        \ }
    " 如果配置下面输入两个字符来自动触发语义补全，会导致utilsnap的补全不在补全窗口里面显示
    let g:ycm_semantic_triggers =  {
        \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{3}'],
        \ 'cs,lua,javascript': ['re!\w{3}'],
        \ }
    let g:ycm_global_ycm_extra_conf = '${VIMFILES}/bundle/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'
    " let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
    let g:ycm_confirm_extr_conf = 0
    " 回车即选中当前项"
    let g:ycm_key_list_stop_completion = ['<CR>']
    set completeopt=longest,menu
    " let g:ycm_add_preview_to_completeopt = 0
    " 离开插入模式后自动关闭预览窗口"
    let g:ycm_goto_buffer_command = 'horizontal-split'
    let g:ycm_register_as_syntastic_checker = 0
    autocmd InsertLeave * if pumvisible() == 0|pclose|endif
    nnoremap <leader>gd :YcmCompleter GoToDeclaration<CR>
    nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
    nnoremap <leader>gg :YcmCompleter GoTo<CR>
    nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
    " nnoremap <leader>gw :YcmCompleter GetDoc<CR>

" Snippets configure:
    imap <C-k>     <Plug>(neosnippet_expand_or_jump)
    smap <C-k>     <Plug>(neosnippet_expand_or_jump)
    xmap <C-k>     <Plug>(neosnippet_expand_target)
    " imap <expr><TAB>
    " \ pumvisible() ? "\<C-n>" :
    " \ neosnippet#expandable_or_jumpable() ?
    " \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
    let g:deoplete#enable_at_startup = 1
    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpForwardTrigger  = "<tab>"
    let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
    " let g:UltiSnipsJumpForwardTrigger="<c-b>"
    " let g:UltiSnipsJumpBackwardTrigger="<c-z>"
    let g:UltiSnipsSnippetDirectories  = ['UltiSnips']
    " If you want :UltiSnipsEdit to split your window.
    let g:UltiSnipsEditSplit="vertical"

" CompleteParameter configure: 
    inoremap <silent> <expr> ) complete_parameter#pre_complete("()")
    smap <c-j> <Plug>(complete_parameter#goto_next_parameter)
    imap <c-j> <Plug>(complete_parameter#goto_next_parameter)
    smap <c-k> <Plug>(complete_parameter#goto_previous_parameter)
    imap <c-k> <Plug>(complete_parameter#goto_previous_parameter)

" Autopep8 configure:
    autocmd FileType python noremap <buffer> <Leader>ap :w!<CR>:call Autopep8()<CR>
    let g:autopep8_ignore="W391"
    " let g:autopep8_select="E501,W293"

" autoformat configure for F10 run Pycode:
    let g:autoformat_autoindent = 0
    let g:autoformat_retab = 0
    let g:autoformat_remove_trailing_spaces = 0
    map <Leader>rp <ESC>:Autoformat<CR>:w<CR>:call RunPython()<CR>
    function! RunPython()
        let mp = &makeprg
        let ef = &errorformat
        let exeFile = expand("%:t")
        setlocal makeprg=python3\ -u
        set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
        silent make %
        copen
        let &makeprg = mp
        let &errorformat = ef
    endfunction

" python-mode Settings {{{
    let g:pymode_python = 'python3'
    let g:pymode_lint = 0
    let g:pymode_run = 0
    let g:pymode_breakpoint = 1
    let g:pymode_doc = 1
    let g:pymode_folding = 1
    let g:pymode_motion = 1
    let g:pymode_virtualenv = 1
    let g:pymode_rope = 1
    let g:pymode_rope_lookup_project = 0
    let g:pymode_rope_completion = 0
    " 重命名光标下的函数，方法，变量及类名
    let g:pymode_rope_rename_bind = '<Leader>rr'
    let g:pymode_rope_show_doc_bind = '<Leader>sd'
    let g:pymode_rope_rename_module_bind = '<Leader>rm'
    let g:pymode_rope_goto_definition_bind = '<Leader>rd'
    let g:pymode_rope_goto_definition_cmd = 'vnew'
    " 重命名光标下的模块或包
    " 开启python所有的语法高亮
    let g:pymode_syntax = 1
    let g:pymode_syntax_all = 1
" 参考：https://blog.csdn.net/demorngel/article/details/71158792 }}}

" indentline AutoPairs, configure:
    let g:indent_guides_enable_on_vim_startup = 1
    let g:indent_guides_guide_size = 3
    let g:indent_guides_start_level = 2
    let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`'}
    " let g:AutoPairs = {'[':']', '{':'}', "'":"'", '"':'"', '`':'`'}
    " inoremap <buffer><silent> ) <C-R>=AutoPairsInsert(')')<CR>

" rainbow configure:
    let g:rainbow_active = 1
	let g:rainbow_conf = {
        \	'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
        \	'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
        \   }

" incsearch configure:
    map /  <Plug>(incsearch-forward)
    map ?  <Plug>(incsearch-backward)
    map g/ <Plug>(incsearch-stay)
    map n  <Plug>(incsearch-nohl-n)
    map N  <Plug>(incsearch-nohl-N)
    map *  <Plug>(incsearch-nohl-*)
    map #  <Plug>(incsearch-nohl-#)
    map g* <Plug>(incsearch-nohl-g*)
    map g# <Plug>(incsearch-nohl-g#)

" MarkdownPreview configure:
    let g:mkdp_path_to_chrome = "/Applications/Google\\ Chrome.app/Contents/MacOS/Google\\ Chrome"
    nmap <silent> <leader>mp <Plug>MarkdownPreview
    nmap <silent> <leader>mP <Plug>StopMarkdownPreview

" plugins manager autodownload and keymap configure:
    let vim_plug_just_installed = 0
    let vim_plug_path = '${VIMRUNTIME}/autoload/plug.vim'
    if !empty(glob('${VIMRUNTIME}/autoload/plug.vim'))
        echo "Installing Vim-plug..."
        echo ""
        silent !mkdir -p ${VIMRUNTIME}/autoload
        silent !curl -fLo ${VIMRUNTIME}/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        let vim_plug_just_installed = 1
    endif
    if vim_plug_just_installed
        :execute 'source '.fnameescape(vim_plug_path)
    endif
    " Plug keymap configure:
    nnoremap <Leader>pi :PlugInstall<Cr>
    nnoremap <Leader>pc :PlugClean<Cr>
    nnoremap <Leader>pu :PlugUpdate<Cr>

"  < Plugin lists >
call plug#begin('$VIM/vimfiles/bundle')
    Plug 'flazz/vim-colorschemes'
    Plug 'itchyny/lightline.vim'
    Plug 'lifepillar/vim-solarized8'
    " Plug 'vim-airline/vim-airline-themes'
    " Plug 'vim-airline/vim-airline'
    Plug 'troydm/zoomwintab.vim'
    " Plug 'ryanoasis/vim-devicons'
    Plug 'wincent/terminus'
    Plug 'easymotion/vim-easymotion'
    Plug 'junegunn/vim-easy-align'
    Plug 'luochen1990/rainbow'
    Plug 'kshenoy/vim-signature'
    " Plug 'airblade/vim-gitgutter'
    " Plug 'neoclide/vim-easygit'
    Plug 'Shougo/denite.nvim'
    " Plug 'jreybert/vimagit'
    " Plug 'mhinz/vim-signify' support more vcs
    " Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-obsession'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
    Plug 'jiangmiao/auto-pairs'
    Plug 'tommcdo/vim-exchange'
    " Plug 'davidhalter/jedi-vim'
    " Plug 'python-mode/python-mode', { 'branch': 'develop' }
    " Plug 'maralla/completor.vim'
    " Plug '~/.vim/bundle/YouCompleteMe'
    Plug 'Valloric/YouCompleteMe'
    " Plug 'oblitum/YouCompleteMe'
    if has('nvim')
        Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
        Plug 'Shougo/neosnippet.vim'
        Plug 'Shougo/neosnippet-snippets'
        " Plug 'rhysd/nyaovim-popup-tooltip'
    else
        Plug 'sirver/ultisnips'
        Plug 'honza/vim-snippets'
    endif
    Plug 'rhysd/nyaovim-popup-tooltip'
    Plug 'tenfyzhong/CompleteParameter.vim'
    Plug 'tell-k/vim-autopep8'
    Plug 'Chiel92/vim-autoformat'
    Plug 'w0rp/ale'
    " Plug 'neomake/neomake'
    " Plug 'plytophogy/vim-virtualenv'
    Plug 'majutsushi/tagbar'
    Plug 'scrooloose/nerdcommenter'
    Plug 'scrooloose/nerdtree'
    Plug 'jistr/vim-nerdtree-tabs'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'sjl/gundo.vim'
    Plug 'dyng/ctrlsf.vim'
    "Plug 'junegunn/fzf', { 'dir': '$VIM/vimfiles/bundle/fzf', 'do': './install --all'  }
    Plug 'junegunn/fzf.vim'
    Plug '~/gitrepo/fzf'
    Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
    Plug 'haya14busa/incsearch.vim'
    Plug 'terryma/vim-multiple-cursors'
    Plug 'yonchu/accelerated-smooth-scroll'
    Plug 'nathanaelkane/vim-indent-guides'
    Plug 'sheerun/vim-polyglot'
    Plug 'rizzatti/dash.vim'
    Plug 'iamcco/markdown-preview.vim'
call plug#end()
