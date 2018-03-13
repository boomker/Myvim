" =============================================================================
"        << 判断操作系统是 Windows 还是 Mac 和判断是终端还是 Gvim >>
" =============================================================================

" -----------------------------------------------------------------------------
"  < 判断操作系统是否是 Windows 还是 Mac >
" -----------------------------------------------------------------------------
let g:isWin = 0
let g:isMac = 0
if(has("win32") || has("win64"))
    let g:isWin = 1
else
    let g:isMac = 1
endif

" -----------------------------------------------------------------------------
"  < 判断是终端还是 Gvim >
" -----------------------------------------------------------------------------
if has("gui_running")
    let g:isGUI = 1
    set imi=2                                             "搜狗输入法在macvim混乱的解决方法如下:
    set ims=2
    set background=dark
    " colorscheme lucius
    colorscheme solarized
    " let g:solarized_termtrans=1
    " au GUIEnter * simalt ~x                               "窗口启动时自动最大化
    set guiheadroom=0                                     "禁止GTK填充窗口底部为主题背景色，此设置会消除底部的水平滚动条"
else
    let g:isGUI = 0
endif

if (g:isWin && g:isGUI)
    "把下面一行文件中的else给注释掉就不会生成XXX~的备份文件了。
    source $VIMRUNTIME/vimrc_example.vim
    source $VIMRUNTIME/mswin.vim
    " behave mswin
    language messages zh_CN.utf-8                           "解决状态信息栏乱码问题
    set iminsert=2                                          "输入法设置"
    set mousef                                              "启用光标激活pane
endif

if g:isMac
    let $VIMFILES = '$VIM/vimfiles'
    " set mouse=a                    " 在任何模式下启用鼠标,但是右键用不了
    colorscheme solarized
    set background=dark
    set t_Co=256                   " 在终端启用256色
    if has("autocmd")
        au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    endif

    if g:isGUI
        " Source a global configuration file if available
        if filereadable("~/.vimrc")
            source ~/.vimrc
            nmap so :so ~/.vimrc<CR>:nohl<CR>
        endif
    else
        if has("syntax")
            syntax on
        endif

        if filereadable("~/.vimrc")
            source ~/.vimrc
        endif
    endif
endif


" 配置文件自动载入
if g:isWin
    autocmd! bufwritepost source $VIM/_vimrc %
elseif g:isMac
    autocmd! bufwritepost source $HOME/.vimrc %
endif

" set guifont=XHei_OSX_Mono:h13
set guifont=Source_Code_Pro_Semibold_for_Powerline:h15

set number                                            "显示行号
" set relativenumber                                    "启用相对行号"
set wrap                                              "设置自动折行
" set nolinebreak                                       "不自动换行
set shortmess=atI                                     "去掉欢迎界面
set guioptions-=m                                     "去掉菜单栏"
set guioptions-=e                                     "去掉标签栏"
set guioptions-=T                                     "去掉工具栏"
set guioptions-=r                                     "去掉右边(下行是去左边的)的滚动条"
set guioptions-=L
set laststatus=2                                      "启用状态栏信息
set showtabline=2                                     "当只有一个标签时也显示标签行
set magic                                             "打开正则匹配模式
set noimd                                             "关闭输入法

" 禁止UTF-8 BOM
set nobomb
set termencoding=utf-8
set encoding=utf-8                                      "设置gvim内部编码
set fileencoding=utf-8                                  "设置此缓冲区所在文件的字符编码
set fileencodings=utf-8,cp936,ucs-bom,gb18030,gb2312    "设置支持打开的文件的编码
set fileformat=mac
set fileformats=mac,unix,dos                            "给出文件的<EOL>格式类型
set pyxversion=2
" 下面两行至于此是为解决右键菜单乱码问题
source $VIMRUNTIME/delmenu.vim
" source $VIMRUNTIME/menu.vim

" -----------------------------------------------------------------------------
"  < 码字时的一些功能性配置 >
" -----------------------------------------------------------------------------
set nocompatible                                        "禁用 Vi 兼容模式
set backspace=indent,eol,start
set viewoptions=folds,options,cursor,unix,slash         "better unix/Windows compatible
set virtualedit=onemore                                 "curso可以移动到行尾最后一个字符之后"
set autoindent
set smartindent                                         "启用智能对齐方式
set smarttab                                            "指定行首按一次backspace就删除shiftwidth宽度的空格
set expandtab                                           "将Tab键转换为空格
set tabstop=4                                           "设置Tab键的宽度
set softtabstop=4
set shiftwidth=4                                        "换行时自动缩进4个空格
set scrolloff=3                                         "上下滚动时当前行距顶或低保持有3行"
set cursorline                                          "突出显示当前行
set foldenable                                          "启用折叠
set foldmethod=indent                                   "indent 折叠方式
" set foldopen=all                                        "光标移到折叠时自动打开
" set foldclose=all
set autoread                                            "当文件在外部被修改，自动更新该文件
set clipboard=unnamed                                   "与其他应用共享剪贴板,抽出和粘贴选择内容,而无须在这些命令前面附加"*.
au BufRead,BufNewFile,BufEnter * cd %:p:h               "自动切换到正在编辑文件所在的目录
" 启用每行超过110列的字符提示(字体变蓝并加下划线)
au BufWinEnter * let w:m2=matchadd('Underlined', '\%>' . 78 . 'v.\+', -1)

set hlsearch                                "高亮搜索
set incsearch                               "在输入要搜索的文字时，实时匹配
set ignorecase                              "搜索模式里忽略大小写
set smartcase                               "搜索模式包含大写字符，忽略上一行设置
set matchtime=6                             "匹配括号光标停留时间"
set showmatch
set history=500                             "保存更多的history"
set wildmenu
set vb t_vb=                                "关闭提示音
set nobackup                                "设置无备份文件
set noswapfile                              "设置无临时文件
set nowritebackup                           "无写入备份

" ===============< 我定义的一些快捷键 >======================
let mapleader = ","
inoremap <ESC> <ESC>:nohl<CR>
noremap <leader>nl :nohl<CR>

nmap <Up> <Nop>
nmap <Down> <Nop>
nmap <Left> <Nop>
nmap <Right> <Nop>
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

nmap J gJ
nmap sf :w!<CR>

" reload configure and edit configure 保存的同时也备份一份到指定位置
if g:isWin
    " nmap <leader>sf :w!<CR>:w! $VIM\tmp\Vim_backupdir\/%.bak<CR>
    nmap <Leader>rc :so $VIM/_vimrc<CR>:nohl<CR>
else
    " nmap <leader>sf :w!<CR>:w! ~/Vim_backupdir\/%.bak<CR>
    nmap <Leader>rc :so $HOME/.vimrc<CR>:nohl<CR>
endif

" 复制到行未.
nmap ye y$
nmap yh y^
" 将本行复制到寄存器里面并粘贴到下行
nmap yp mYyyp`Yj

nnoremap gb G
nmap ge $
nmap gh ^
" 粘贴到词头
nmap gp bP
noremap gl gu
noremap gu gU

nmap sc <S-c>
" 代替s的删除并insert
nmap si i<Delete>
nmap ss ``zz
nmap sm `mzz
nmap sl `lzz
" nmap sj <C-o>
" nmap sk <C-i>
nmap su <C-r>
" 快速替换一词
nmap sp vep
nmap sP bvep

" 设置在normal模式下,在光标所在行的上行或下行插入一空行,但是不变模式和光标的位置.
nmap tj mQo<esc>`Q
nmap tk mQ<S-o><esc>`Q
" 新建 Untitled.
nmap tn :tabnew!<CR>
nmap tp <S-End><C-v>
" 设置光标所在行标后的字符置于下行.
nmap to a<CR><ESC>k$

" 字符串时不置换临时寄存器
noremap p ""p
xnoremap p "0p
nnoremap mp "0p
nnoremap mP "0P
" inoremap <leader>vp <esc>"+p
" inoremap <leader>vP <esc>"+P
" noremap <leader>vp "+p
" noremap <leader>vP "+P
" vnoremap <leader>vp "+p
" vnoremap <leader>vP "+P
" noremap <leader>yc "*y
" noremap <leader>Yc "*Y

nmap mr "Z
nmap md <S-*>
vmap md y/<C-v><CR>
nmap ms <S-#>

" normal模式下删除光标之前或之后的所有字符
nmap dt d^
nmap dl d$

nmap d<CR> dG
nmap dj 2dd
nmap dk k2dd
nmap y<CR> yG
nmap yj 2yy
nmap yk k2yy

    "nmap yswr ysw(
    "nmap dim di[   "nmap ysiwr ysiw(
    "nmap ysws ysw[
    "nmap dia di<   "nmap ysiws ysiw[
    "nmap dii di'   "nmap yswf ysw{
    "nmap did di"   "nmap ysiwf ysiw{
    "nmap yswi ysw'
    "nmap ysiwi ysiw'
    "nmap yim yi[   "nmap yswd ysw"
    "nmap ysiwd ysiw"
    "nmap yia yi<
    "nmap yii yi'
    "nmap yid yi"

    "nmap yssr yss(    "nmap cstr cst(     "nmap dsr ds(
    "nmap ysss yss[    "nmap csts cst[     "nmap dss ds[
    "nmap yssf yss{    "nmap cstf cst{     "nmap dsf ds{
    "nmap yssi yss'    "nmap cstd cst"     "nmap dsd ds"
    "nmap yssd yss"    "nmap csti cst'     "nmap dsi ds'

    "nmap csid cs'"
    "nmap csdi cs"'

vmap <Leader>fb S{
vmap <Leader>sb S[
xmap <Leader>fb S{
xmap <Leader>sb S[

" nnoremap zc zC
"nnoremap zu [z
"nnoremap zn ]z
nnoremap zg :q!<CR>
nnoremap zf <S-z><S-z>
nnoremap zv <C-w>v
nnoremap zi <C-w>s
nnoremap zq <C-w>w:q!<CR>
" 用空格键来开关折叠
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

" Smart way to move between windows 分屏窗口移动
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l

cnoremap <C-a> <Home>
cnoremap <c-v> <C-r>"

" :inoremap < <><ESC>i
" {[( rigTab补全 )]}
:ab rig Right
:ab del Delete
:ab spa Space
:ab shi Shift

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

" noremap <leader>sv ggvG
onoremap af :<C-u>normal! ggVG<CR>''

" 常规模式下输入 dS 清除行尾空格
nnoremap <Leader>ds :%s/\s\+$//g<cr>:w!<CR>''

" 常规模式下输入 dM 清除行尾 ^M 符号
nnoremap <Leader>dm :%s/\r$//g<CR>:w!<CR>''

" convert tab to space
noremap <Leader>tcs :%s/\v\t/    /g<CR>

" 设置可以高亮的关键字
if has("autocmd")
  " Highlight TODO, FIXME, NOTE, etc.
  if v:version > 701
      autocmd Syntax * call matchadd('Todo', '\W\zs\(TODO\|IDEA\|NOTE\|NOTICE\|重要\|要点\|注意\|现象\|原因\|解决\)')
      autocmd Syntax * call matchadd('ErrorMsg', '\W\zs\(HACK\|XXX\|错误\|故障\)')
  endif
endif

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

function! XTermPasteBegin()
    set pastetoggle=<Esc>[201~
    set paste
    return""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! CurDir()
       let curdir = substitute(getcwd(), $HOME, "~", "g")
       return curdir
endfunction

autocmd BufNewFile,BufRead,FileType sh,python exec ":call SetFileHeadTitle()"
func! SetFileHeadTitle()
    if &filetype == 'python'
        call setline(1, "\#!/usr/bin/python3")
        call setline(2, "\# Description: ")
        call setline(3, "\# Author: boomker")
        call setline(4, "\# Mail: gmboomker@gmail.com")
        normal Go
    endif
    if &filetype == 'sh'
        call setline(1, "\#!/bin/bash")
        call setline(2, "\# Description: ")
        call setline(3, "\# Author: boomker")
        call setline(4, "\# Mail: 15800545854@139.com")
        " call setline(5, "\# Date: strftime("+%F %H:%M")")
        normal Go
    endif
endfunction

au FileType python call AddPythonDict_txt()
function! AddPythonDict_txt()
    set dict+=$VIMFILES/dict/python.txt
    set complete+=k
endfunction

" 保存python文件时删除多余空格
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd FileType python,go,php,javascript,yml,txt,sh autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

" ==============< 插件配置 >================

" 透明+置顶插件的配置:
if (g:isWin && g:isGUI)
    let g:Current_Alpha = 255
    let g:Top_Most = 0
    func! Alpha_add()
        let g:Current_Alpha = g:Current_Alpha + 10
        if g:Current_Alpha > 255
            let g:Current_Alpha = 255
        endif
        call libcallnr("vimtweak.dll","SetAlpha",g:Current_Alpha)
    endfunc
    func! Alpha_sub()
        let g:Current_Alpha = g:Current_Alpha - 10
        if g:Current_Alpha < 155
            let g:Current_Alpha = 155
        endif
        call libcallnr("vimtweak.dll","SetAlpha",g:Current_Alpha)
    endfunc
    func! Top_window()
        if  g:Top_Most == 0
            call libcallnr("vimtweak.dll","EnableTopMost",1)
            let g:Top_Most = 1
        else
            call libcallnr("vimtweak.dll","EnableTopMost",0)
            let g:Top_Most = 0
        endif
    endfunc

    "透明&置顶的快捷键设置
    nmap <leader>ta :call Alpha_add()<CR>
    nmap <leader>td :call Alpha_sub()<CR>
    nmap <leader>tt :call Top_window()<CR>
    " 用于 Windows Gvim 全屏窗口，可用 F11 切换 全屏后再隐藏菜单栏、工具栏、滚动条效果更好
    nmap <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
endif

" easy_align configure:
    vmap <Enter> <Plug>(EasyAlign)
    nmap ga <Plug>(EasyAlign)
    xmap ga <Plug>(EasyAlign)

" ctrlP configure:
    let g:ctrlp_map = '<Leader>gf'
    map <leader>sm :CtrlPMRU<CR>
    let g:ctrlp_by_filename = 1
    let g:ctrlp_mruf_case_sensitive = 1
    let g:ctrlp_cache_dir = '$VIM/vimfiles/tmp/ctrlp'
    let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
    let g:ctrlp_custom_ignore = '\v[\/]\.(exe|so|dll|tar|tar.gz|iso|ipk)$'
    set wildignore+=*\\tmp\\*,*.swp,*.zip,*.rar,*.7z,*.dat,*.ico,*pyc

" vim easymotion configure: --改标记按键顺序
    let g:EasyMotion_smartcase = 1
    let g:EasyMotion_leader_key = 'f'
    let g:EasyMotion_startofline = '0'
    nmap fu <Plug>(easymotion-N)
    nmap f/ <Plug>(easymotion-fn)
    "支持多关键词正则搜索
    nmap f? <Plug>(easymotion-Fn)
    nmap fl <Plug>(easymotion-lineforward)
    nmap fh <Plug>(easymotion-linebackward)
    nmap f. <Plug>(easymotion-repeat)

" txtBrowser configure:
    let tlist_txt_settings = 'txt;c:content;f:figures;t:tables'
    au BufRead,BufNewFile *.txt setlocal ft=txt
    " nmap <silent> <leader>tf <ESC>:TFind<RETURN>
    nmap <silent> <leader>ts <ESC>:TSearch<RETURN>
    nmap <silent> <leader>tg <ESC>:TGoto<RETURN>
    nmap <silent> <leader>th <ESC>:TBMatch<RETURN>

" airline configure:
    " let g:airline_theme = 'solarized'                " 设置主题
    let g:airline_powerline_fonts = 1
    let g:airline#extensions#tabline#show_buffers = 1
    " let g:airline#extensions#tabline#switch_buffers_and_tabs = 1
    let g:airline#extensions#tabline#show_tabs = 0
    let g:airline#extensions#tabline#buf_label_first = 1
    let g:airline#extensions#tabline#buffers_label = 'bfs'
    let g:airline#extensions#branch#enabled = 1
    let g:airline#extensions#tavline#enabled = 1
    " let g:airline#extensions#syntastic#enabled = 1
    let g:airline#extensions#tagbar#enabled = 1
    let g:airline#extensions#tagbar#flags = 'f'
    " let g:airline#extensions#virtualenv#enabled = 1
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#show_close_button = 0
    let g:airline#extensions#tabline#fnametruncate = 1
    let g:airline#extensions#tabline#formatter = 'unique_tail'
    let g:airline#extensions#tabline#tab_nr_type = 1
    " let g:airline#extensions#tabline#tab_nr_type = 2 " splits and tab number
    let g:airline#extensions#whitespace#symbol = '!'
    let g:airline#extensions#whitespace#enabled = 1
    let g:airline#extensions#whitespace#mixed_indent_format = 'm-i[%s]'
    let g:airline#extensions#whitespace#mixed_indent_file_format = 'm-i-f[%s]'
    let g:airline_section_b = '%{strftime("%H:%M")}'
    let g:airline_section_c = '%{CurDir()}\%t'
    let g:airline_section_y = 'BN: %{bufnr("%")}'

" ag/greper/ctrlsf configure:
    nnoremap <leader>G :Grepper -tool ag<cr>
    "nmap <leader>gs <plug>(GrepperOperator)
    nnoremap <leader># :Grepper -buffer -tool ag -cword -noprompt<cr>
" ctrsf configure:
    nmap <leader>sf <Plug>CtrlSFPrompt
    nmap <leader>sw <Plug>CtrlSFCwordExec
    nmap <leader>ww <Plug>CtrlSFCCwordExec
    let g:ctrlsf_default_view_mode = 'compact'

    " Optional. The default behaviour should work for most users.
    let g:grepper               = {}
    let g:grepper.tools         = ['ag', 'ack', 'grep', 'findstr', 'git']
    let g:grepper.jump          = 0
    let g:grepper.next_tool     = '<leader>g<tab>'
    let g:grepper.simple_prompt = 1
    let g:grepper.quickfix      = 1
    let g:grepper.highlight = 1

" pydiction configure:
    let g:pydiction_location = '$VIMFILES/Plugin/pydiction/complete-dict'
    let python_highlight_all = 1
    let g:pydiction_menu_height = 6

" nerdtree configure:
    map <leader>st :NERDTreeToggle<CR>
    let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$', '\.DS_Store$']
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
    " let NERDTreeWinSize=45
    " let NERDTreeShowLineNumbers=1
    let NERDTreeDirArrows=0
    let NERDTreeAutoDeleteBuffer=1
    let NERDTreeHijackNetrw=1
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" ale configure:
    let g:ale_fix_on_save = 1
    let g:ale_completion_enabled = 1
    let g:ale_sign_column_always = 1
    let g:airline#extensions#ale#enabled = 1

" tagbar configure:
    let g:tagbar_sort=0
    let g:tagbar_compact=1
    let g:tagbar_indent = 1
    let g:tagbar_autoshowtag=1
    let g:tagbar_autoclose = 1
    let g:tagbar_autofocus = 1
    let g:tagbar_autopreview = 1                   " 开启自动预览 [随着光标在标签上的移动，顶部会出现一个实时的预览窗口]
    let g:tagbar_singleclick = 1
    " let g:tagbar_type_elixir = {'ctagstype': 'elixir', 'kinds': ['f:functions:0:0', 'c:callbacks:0:0', 'd:delegates:0:0', 'e:exceptions:0:0', 'i:implementations:0:0', 'a:macros:0:0', 'o:operators:0:0', 'm:modules:0:0', 'p:protocols:0:0', 'r:records:0:0'], 'sro': '.'}
    let g:tagbar_width = 35
    let g:tagbar_systemenc = 'utf-8'
    nmap <Leader>vt :TagbarToggle<CR>
    let g:tagbar_map_nexttag = "J"
    let g:tagbar_map_prevtag = "K"
    let g:tagbar_map_openallfolds = "ao"
    let g:tagbar_map_closeallfolds = "ac"

" auto-pairs configure:
    let g:AutoPairsFlyMode = 0
    " let g:AutoPairsShortcutBackInsert = '<M-b>'
    " let g:AutoPairsShortcutToggle = '<Leader>pt'

" markdown configure:
    au bufread,bufnewfile *.md,*.markdown setlocal ft=mkd
    let g:vim_markdown_folding_disabled=1
    let g:vim_markdown_no_default_key_mappings=1
    let g:vim_markdown_math=1
    let g:vim_markdown_frontmatter=1

" undotree configure:
    nnoremap <Leader>su :UndotreeToggle<cr>
    " let g:undotree_DiffAutoOpen = 0
    let g:undotree_SetFocusWhenToggle = 1
    function! g:Undotree_CustomMap()
        nmap <buffer> J <plug>UndotreeGoNextState
        nmap <buffer> K <plug>UndotreeGoPreviousState
        nmap <buffer> r <plug>UndotreeRedo
    endfunc

" Autopep8 configure:
    autocmd FileType python noremap <buffer> <Leader>ap :w!<CR>:call Autopep8()<CR>
    let g:autopep8_ignore="W391"
    " let g:autopep8_select="E501,W293"

" indentline configure:
    " let g:indentLine_setColors = 0
    let g:indentLine_color_dark = 1
    let g:indentLine_char = '┆'
    let g:indentLine_leadingSpaceEnabled = 1
    let g:indentLine_leadingSpaceChar = '·'

" YouCompleteMe configure:
    " let g:ycm_collect_identifiers_from_tags_files = 0
    " let g:ycm_collect_identifiers_from_comments_and_strings = 0
    " let g:ycm_path_to_python_interpreter = '/usr/local/bin/python'
    " let g:ycm_path_to_python3_interpreter = '/usr/local/bin/python3'
    " " 输入第0个字符开始补全
    " let g:ycm_min_num_of_chars_for_completion = 0
    " " 禁止缓存匹配项,每次都重新生成匹配项
    " let g:ycm_cache_omnifunc = 0
    " " 开启语义补全
    " let g:ycm_seed_identifiers_with_syntax = 1
    " " 在注释输入中也能补全
    " let g:ycm_complete_in_comments = 1
    " " 在字符串输入中也能补全
    " let g:ycm_complete_in_strings = 1
    " let g:ycm_min_num_of_chars_for_completion= 2
    " let g:ycm_max_diagnostics_to_display = 0
    " let g:ycm_key_list_select_completion = ['<C-n>', '<C-j>']
    " let g:ycm_key_list_previous_completion = ['<C-p>', '<C-k>']
    " let g:ycm_autoclose_preview_window_after_completion = 1
    " let g:ycm_autoclose_preview_window_after_insertion = 1
    " let g:ycm_filetype_whitelist = { 'python': 1  }
    " let g:ycm_filetype_blacklist = {
          " \ 'tagbar' : 1,
          " \ 'nerdtree' : 1,
          " \}
    " " set complete-= i
    " " let g:ycm_python_binary_path = 'python'
    " let g:ycm_global_ycm_extra_conf = '$VIM/vimfiles/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
    " let g:ycm_confirm_extr_conf = 0
    " set completeopt=longest,menu
    " noremap <Leader>gd  :YcmCompleter GoToDefinitionElseDeclaration<CR>
    " "离开插入模式后自动关闭预览窗口"
    " autocmd InsertLeave * if pumvisible() == 0|pclose|endif
    " "回车即选中当前项"
    " " inoremap <expr> <CR>       pumvisible() ? '\<C-y>' : '\<CR>'
    " "上下左右键行为"
    " inoremap <expr> <Down>     pumvisible() ? '\<C-n>' : '\<Down>'
    " inoremap <expr> <Up>       pumvisible() ? '\<C-p>' : '\<Up>'
    " inoremap <expr> <PageDown> pumvisible() ? '\<PageDown>\<C-p>\<C-n>' : "'\<PageDown>'
    " inoremap <expr> <PageUp>   pumvisible() ? '\<PageUp>\<C-p>\<C-n>' : '\<PageUp>'

" deoplete or nvim-completion-manager configure:
    let g:deoplete#enable_at_startup = 1
    set shortmess+=c
    " inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
    " imap <expr> <CR>  (pumvisible() ?  "\<c-y>\<Plug>(expand_or_nl)" : "\<CR>")
    " imap <expr> <Plug>(expand_or_nl) (cm#completed_is_snippet() ? "\<C-U>":"\<CR>")
    inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" jedi-vim configre:
    let g:jedi#completions_enabled = 1
    let g:jedi#completions_command = "<Tab>"
    inoremap <silent> <buffer> <C-N> <c-x><c-o>
    let g:jedi#goto_command = "<leader>gc"
    let g:jedi#goto_assignments_command = "<leader>ga"
    let g:jedi#goto_definitions_command = ""
    let g:jedi#documentation_command = "K"
    let g:jedi#usages_command = "<leader>uc"
    " let g:jedi#completions_command = "<C-Space>"
    let g:jedi#rename_command = "<leader>rn"

" autoformat configure for F6 run Pycode:
    let g:autoformat_autoindent = 0
    let g:autoformat_retab = 0
    let g:autoformat_remove_trailing_spaces = 0
    map <F6> <ESC>:Autoformat<CR>:w<CR>:call RunPython()<CR>
    function! RunPython()
        let mp = &makeprg
        let ef = &errorformat
        let exeFile = expand("%:t")
        setlocal makeprg=python\ -u
        set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
        silent make %
        copen
        let &makeprg = mp
        let &errorformat = ef
    endfunction

" RainbowParentheses configure:
    let g:rbpt_loadcmd_toggle = 0
    au VimEnter * RainbowParenthesesToggle
    au Syntax * RainbowParenthesesLoadRound
    au Syntax * RainbowParenthesesLoadSquare
    au Syntax * RainbowParenthesesLoadBraces

" plugins manager plug configure:
    if empty(glob('$VIMRUNTIME/autoload/plug.vim'))
        silent execute "!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
        autocmd VimEnter * PlugInstall | source $HOME/.vimrc
    endif

"  < Plug 插件管理工具配置 >
call plug#begin('$VIM/vimfiles/bundle')
    Plug 'tpope/vim-fugitive'
    Plug 'mhinz/vim-signify'
    Plug 'easymotion/vim-easymotion'
    Plug 'vim-airline/vim-airline'
    " Plug 'jmcantrell/vim-virtualenv'
    Plug 'plasticboy/vim-markdown'
    Plug 'davidhalter/jedi-vim'
    " Plug 'dimasg/vim-mark'
    Plug 'rkulla/pydiction'
    Plug 'tell-k/vim-autopep8'
    Plug 'Chiel92/vim-autoformat'
    " Plug '$VIM/vimfiles/bundle/txtbrowser'
    Plug 'majutsushi/tagbar'
    Plug 'junegunn/vim-easy-align'
    Plug 'jiangmiao/auto-pairs'
    Plug 'tpope/vim-surround'
    Plug 'kien/rainbow_parentheses.vim'
    " Plug 'Valloric/YouCompleteMe'
    " Plug 'Shougo/deoplete.nvim'
    " Plug 'roxma/nvim-yarp'
    " Plug 'roxma/vim-hug-neovim-rpc'
    " Plug 'roxma/nvim-completion-manager'
    Plug 'w0rp/ale'
    Plug 'scrooloose/nerdcommenter'
    Plug 'scrooloose/nerdtree'
    "Plug 'junegunn/fzf', { 'dir': '$VIM/vimfiles/bundle/fzf', 'do': './install --all'  }
    "Plug '/usr/local/opt/fzf'
    "Plug 'junegunn/fzf.vim'
    Plug 'mhinz/vim-grepper'
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'dyng/ctrlsf.vim'
    Plug 'terryma/vim-multiple-cursors'
    Plug 'mbbill/undotree'
    Plug 'yonchu/accelerated-smooth-scroll'
    Plug 'rizzatti/dash.vim'
    Plug 'Yggdroot/indentLine'
    " Plug 'pearofducks/ansible-vim'
call plug#end()

