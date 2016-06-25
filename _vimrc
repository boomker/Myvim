" =============================================================================
"        << 判断操作系统是 Windows 还是 Linux 和判断是终端还是 Gvim >>
" =============================================================================

" -----------------------------------------------------------------------------
"  < 判断操作系统是否是 Windows 还是 Linux >
" -----------------------------------------------------------------------------
let g:isWin = 0
let g:isLinux = 0
if(has("win32") || has("win64"))
    let g:isWin = 1
else
    let g:isLinux = 1
endif

" -----------------------------------------------------------------------------
"  < 判断是终端还是 Gvim >
" -----------------------------------------------------------------------------
if has("gui_running")
    let g:isGUI = 1
    set background=dark
    colorscheme solarized
    " let g:solarized_termtrans=1
    au GUIEnter * simalt ~x                               "窗口启动时自动最大化
else
    let g:isGUI = 0
endif

if (g:isWin && g:isGUI)
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
    "把下面一行文件中的else给注释掉就不会生成XXX~的备份文件了。
    source $VIMRUNTIME/vimrc_example.vim
    "在Linux里把mswin里C-v注释掉
    source $VIMRUNTIME/mswin.vim
    behave mswin
    language messages zh_CN.utf-8                           "解决状态信息栏乱码问题
    set iminsert=2                                          "输入法设置"
    set mousef                                              "启用光标激活pane
    nmap so :so $VIM/_vimrc<CR>:nohl<CR>
    set diffexpr=MyDiff()
    function! MyDiff()
          let opt = '-a --binary '
          if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
          if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
          let arg1 = v:fname_in
          if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
          let arg2 = v:fname_new
          if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
          let arg3 = v:fname_out
          if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
          let eq = ''
              if $VIMRUNTIME =~ ' '
            if &sh =~ '\<cmd'
              let cmd = '""' . $VIMRUNTIME . '\diff"'
              let eq = '"'
            else
              let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
            endif
          else
            let cmd = $VIMRUNTIME . '\diff'
          endif
          silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
    endfunction
endif

if g:isLinux
    " Uncomment the following to have Vim jump to the last position when
    " reopening a file
    if has("autocmd")
        au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    endif

    if g:isGUI
        " Source a global configuration file if available
        if filereadable("~/_vimrc")
            source ~/_vimrc
            nmap so :so ~/_vimrc<CR>:nohl<CR>
        endif
    else
        " Vim5 and later versions support syntax highlighting. Uncommenting the next
        " line enables syntax highlighting by default.
        if has("syntax")
            syntax on
        endif

        " set mouse=a                    " 在任何模式下启用鼠标,但是右键用不了
        colorscheme desert
        set background=dark
        set t_Co=256                   " 在终端启用256色
        nmap so :so ~/_vimrc<CR>:nohl<CR>
        " Source a global configuration file if available
        if filereadable("~/_vimrc")
            source ~/_vimrc
        endif
    endif
endif

set guifont=XHei_OSX_Mono:h13
"set guifont=Monaco:h13                                "Mac平台上的默认字体Monaco

set number                                            "显示行号
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
"set imsearch=2
"inoremap <ESC> <ESC>:set iminsert=0<CR>

set encoding=utf-8                                      "设置gvim内部编码
set fileencoding=utf-8                                  "设置此缓冲区所在文件的字符编码
set fileencodings=utf-8,ucs-bom,chinese,latin1          "设置支持打开的文件的编码
set termencoding=utf-8                                  "终端使用的编码
set fileformat=unix                                     "设置新文件的<EOL>格式
set fileformats=unix,dos,mac                            "给出文件的<EOL>格式类型

" -----------------------------------------------------------------------------
"  < 码字时的一些功能性配置 >
" -----------------------------------------------------------------------------
"开启语法高亮
syntax enable
syntax on
filetype on                                             "启用文件类型侦测
filetype plugin on                                      "针对不同的文件类型加载对应的插件
filetype plugin indent on
set nocompatible                                        "禁用 Vi 兼容模式
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
"set foldopen=all                                        "光标移到折叠时自动打开
"set foldclose=all
set autoread                                            "当文件在外部被修改，自动更新该文件
set clipboard=unnamed                                   "与其他应用共享剪贴板,抽出和粘贴选择内容,而无须在这些命令前面附加"*.
au BufRead,BufNewFile,BufEnter * cd %:p:h               "自动切换到正在编辑文件所在的目录
" 启用每行超过110列的字符提示(字体变蓝并加下划线)
au BufWinEnter * let w:m2=matchadd('Underlined', '\%>' . 110 . 'v.\+', -1)
autocmd  FileType  text  setlocal  textwidth=110

set hlsearch                                "高亮搜索
set incsearch                               "在输入要搜索的文字时，实时匹配
set ignorecase                              "搜索模式里忽略大小写
set smartcase                               "搜索模式包含大写字符，忽略上一行设置
set matchtime=6                             "匹配括号光标停留时间"
set showmatch
set history=500                             "保存更多的history"
set wildmenu
set backspace=indent,eol,start
set vb t_vb=                                "关闭提示音
set nobackup                                "设置无备份文件
set noswapfile                              "设置无临时文件
set nowritebackup                           "无写入备份
"保存的同时也备份一份到指定位置
if g:isWin
    nmap sf :w!<CR>:w! d:\Download\Documents\Vim_backupdir\/%.bak<CR>
else
    nmap sf :w!<CR>:w! ~/Vim_backupdir\/%.bak<CR>
endif

"===============< 我定义的一些快捷键 >======================
let mapleader = ","
"inoremap jj <Esc>
inoremap <ESC> <ESC>
" snoremap <ESC> <Up>
nnoremap <ESC> <ESC>:nohl<CR>

"复制到行未.
nmap ye y$
nmap yh y^
"将本行复制到寄存器里面并粘贴到下行
nmap yp mYyyp`Yj

nnoremap gb G
nmap ge $
nmap gh ^
"粘贴到词头
nmap gp bP
noremap gl gu
noremap gu gU

nmap sc <S-c>
"代替s的删除并insert
nmap si i<Delete>
nmap ss ``
nmap sm `m
vmap sm y/<C-v><CR>
nmap sl `l
nmap sj <C-o>
nmap sk <C-i>
nmap su <C-r>
"快速替换一词
nmap sp vep
nmap sP bvep

"设置在normal模式下,在光标所在行的上行或下行插入一空行,但是不变模式和光标的位置.
nmap tj mQo<esc>`Q
nmap tk mQ<S-o><esc>`Q
"新建.
nmap tn :tabnew!<CR>
nmap tp <S-End><C-v>
"设置光标所在行标后的字符置于下行.
nmap to a<CR><ESC>k$

"字符串时不置换临时寄存器
xnoremap p "0p
nnoremap mp "0p
nnoremap mP "0P
"inoremap <leader>vp <esc>"+p
"inoremap <leader>vP <esc>"+P
"noremap <leader>vp "+p
"noremap <leader>vP "+P
"vnoremap <leader>vp "+p
"vnoremap <leader>vP "+P
"noremap <leader>yc "*y
"noremap <leader>Yc "*Y

nmap mr "Z
nmap md <S-*>
nmap ms <S-#>

"normal模式下删除光标之前或之后的所有字符
nmap dt d^
nmap dl d$

nmap d<CR> dG
nmap y<CR> yG

    "nmap dir di(   "nmap yswr ysw(
    "nmap dim di[   "nmap ysiwr ysiw(
    "nmap dif di{   "nmap ysws ysw[
    "nmap dia di<   "nmap ysiws ysiw[
    "nmap dii di'   "nmap yswf ysw{
    "nmap did di"   "nmap ysiwf ysiw{
    "nmap cir ci(   "nmap yswi ysw'
    "nmap yir yi(   "nmap ysiwi ysiw'
    "nmap yim yi[   "nmap yswd ysw"
    "nmap yif yi{   "nmap ysiwd ysiw"
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

nnoremap z, <<
nnoremap z. >>
nnoremap zh zH
nnoremap zl zL
nnoremap zc zC
nnoremap zu [z
nnoremap zn ]z
nnoremap zg :q!<CR>
nnoremap zf <S-z><S-z>
nnoremap zv <C-w>v
nnoremap zi <C-w>s
nnoremap zq <C-w>w:q!<CR>
" 用空格键来开关折叠
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zO')<CR>

"Smart way to move between windows 分屏窗口移动
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l

cnoremap <C-a> <Home>
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
cnoremap <c-v> <C-r>"

inoremap <A-h> <Home>
inoremap <A-j> <Down><Home>
inoremap <A-k> <Up><End>
inoremap <A-l> <End>
inoremap <c-j> <Down>
inoremap <c-k> <Up>
inoremap <c-h> <Left>
inoremap <c-l> <Right>

nnoremap <c-s> mz<<`zhhhh
inoremap <c-s> <esc>mz<<`zhhhi
nnoremap <c-t> mz>>`zllll
inoremap <c-t> <esc>mz>>`zllllli
nnoremap <c-a> mz:m-2<cr>`z
inoremap <c-a> <esc>mz:m-2<cr>`zli
nnoremap <c-x> mz:m+<cr>`z
inoremap <c-x> <esc>mz:m+<cr>`zli

:inoremap < <><ESC>i

:ab rig Right
:ab del Delete
:ab spa Space
:ab shi Shift

noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 3gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>
noremap <leader>bf :tabfirst<cr>
noremap <leader>bl :tablast<cr>
noremap <leader>bb :tabprev<cr>
noremap <leader>bn :tabnext<cr>
noremap <leader>bm :tabmove 

noremap <leader>sv ggvG
noremap <leader>sc :!
nmap <silent> <Leader>dt <Plug>DictSearch
vmap <silent> <Leader>dt <Plug>DictVSearch

" 常规模式下输入 cS 清除行尾空格
nnoremap cS :%s/\s\+$//g<CR>:noh<CR>

" 常规模式下输入 cM 清除行尾 ^M 符号
nnoremap cM :%s/\r$//g<CR>:noh<CR>

" convert tab to space
noremap cT :%s/\v\t/    /g<CR>

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


"function! CurDir()
"        let curdir = substitute(getcwd(), $HOME, "~", "g")
"        return curdir
"endfunction


autocmd BufNewFile *.sh,*.py exec ":call SetFileHeadTitle()"
func! SetFileHeadTitle()
    if &filetype == 'python'
        call setline(1, "\#!/usr/bin/python")
        call setline(2, "\#Author: boomk-p")
        normal Go
    endif
    if &filetype == 'sh'
        call setline(1, "\#!/bin/bash")
        normal o
    endif
endfunction

au FileType python call AddPythonDict_txt()
function! AddPythonDict_txt()
    set dict+=$VIM/vimfiles/dict/python.txt
    set complete+=k
endfunction

augroup vimrc_Python
    autocmd!
    "highlight characters past column 120
    highlight BadWhitespace ctermbg=red guibg=red
    autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType python set nowrap
    autocmd FileType python set autoindent
    autocmd FileType python match Excess /\%120v.*/
    autocmd BufRead,BufNewFile *.py set textwidth=110
    autocmd BufRead,BufNewFile *.py match BadWhitespace /^\t\+/
    autocmd BufRead,BufNewFile *.py match BadWhitespace /\s\+$/
    " autocmd BufWritePost *.py call Flake8()
    augroup END

" -----------------------------------------------------------------------------
"  < ctags 工具配置 >
" -----------------------------------------------------------------------------
" 对浏览代码非常的方便,可以在函数,变量之间跳转等
" set tags=./tags;                            "向上级目录递归查找tags文件（好像只有在Windows下才有用）

" -----------------------------------------------------------------------------
"  < gvimfullscreen 工具配置 > 请确保已安装了工具
" -----------------------------------------------------------------------------
" 用于 Windows Gvim 全屏窗口，可用 F11 切换
" 全屏后再隐藏菜单栏、工具栏、滚动条效果更好
if (g:isWin && g:isGUI)
    nmap <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
endif

"==============< 插件配置 >================
"透明+置顶插件的配置:

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
    map <leader>ta :call Alpha_add()<CR>
    map <leader>td :call Alpha_sub()<CR>
    map <leader>tt :call Top_window()<CR>
endif

"easy_align configure
    vmap <Enter> <Plug>(EasyAlign)
    nmap ga <Plug>(EasyAlign)
    xmap ga <Plug>(EasyAlign)

"MRU文件历史插件_最近使用的文件列表:se modifiable<CR>
    nmap gf :MRU <CR>
    if g:isWin
        let MRU_File = 'd:\Program Files\Vim\vimfiles\tmp\_vim_mru_files'
    else
        let MRU_File = '/usr/share/vim/vimfiles/tmp/_vim_mru_files'
    endif
    let MRU_Max_Entries = 50
    let MRU_Window_Height = 15
    let MRU_Max_Menu_Entries =15

"ctrlP configure
    let g:ctrlp_map = '<Leader>sf'
    "map <leader>sr :CtrlPMRU<CR>
    "let g:ctrlp_by_filename = 1
    set wildignore+=*\\tmp\\*,*.swp,*.zip,*.rar,*.7z,*.dat,*.ico,*pyc
    let g:ctrlp_cache_dir = '$VIM/vimfiles/tmp/ctrlp'
    let g:ctrlp_mruf_include = '\.py$\|\.txt$'
    let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
    let g:ctrlp_custom_ignore = '\v[\/]\.(exe|so|dll|tar|tar.gz|iso|ipk)$'

"vim easymotion--改标记按键顺序"
    let g:EasyMotion_smartcase = 1
    let g:EasyMotion_leader_key = 'f'
    let g:EasyMotion_startofline = '0'
    map fu <Plug>(easymotion-F)
    map fs <Plug>(easymotion-sn)
    map f/ <Plug>(easymotion-tn)
    map fz <Plug>(easymotion-s2)
    map ft <Plug>(easymotion-t2)
    " map n <Plug>(easymotion-vim-n)
    " map N <Plug>(easymotion-vim-N)
    map fp <Plug>(easymotion-vim-N)
    map fl <Plug>(easymotion-lineforward)
    map fh <Plug>(easymotion-linebackward)
    map fa <Plug>(easymotion-iskeyword-b)

"txtBrowser插件配置:
    let tlist_txt_settings = 'txt;c:content;f:figures;t:tables'
    au BufRead,BufNewFile *.txt setlocal ft=txt
    nmap <silent> <leader>tf <ESC>:TFind<RETURN>
    nmap <silent> <leader>ts <ESC>:TSearch<RETURN>
    nmap <silent> <leader>tg <ESC>:TGoto<RETURN>
    nmap <silent> <leader>th <ESC>:TBMatch<RETURN>

"airline configure
    set guitablabel=%f
    let g:airline_theme = 'solarized'                " 设置主题
    let g:airline_powerline_fonts = 1
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tavline#enabled = 1
    let g:airline#extensions#tabline#show_close_button = 0
    let g:airline#extensions#tabline#fnametruncate = 1
    let g:airline#extensions#tabline#formatter = 'unique_tail'
    "let g:airline#extensions#tabline#tab_nr_type = 1
    let g:airline#extensions#tabline#tab_nr_type = 2 " splits and tab number
    let g:airline_section_b = '%{strftime("%H:%M")}'
    "let g:airline_section_c = '%{CurDir()}\%t'
	"let g:airline_section_y = 'BN: %{bufnr("%")}'

"EasyGrep configure
    "map <silent> ,mw <plug>EasyGrepInvertWholeWord
    map <silent> <Leader>vv <plug>EgMapGrepCurrentWord_v
    vmap <silent> <Leader>vv <plug>EgMapGrepCurrentWord_v
    map <silent> <Leader>vw <plug>EgMapGrepCurrentWord_V
    vmap <silent> <Leader>vw <plug>EgMapGrepCurrentWord_V
    "map <silent> <Leader>mr <plug>EgMapReplaceCurrentWord_r
    "vmap <silent> <Leader>mr <plug>EgMapReplaceCurrentWord_r
    map <silent> <Leader>vr <plug>EgMapReplaceCurrentWord_R
    vmap <silent> <Leader>vr <plug>EgMapReplaceCurrentWord_R

    let g:EasyGrepFilesToExclude="*.svn*,*.git*,*.a,*.o,*.so,*.d,*.depend,tags"
    " let g:EasyGrepRecursive=1
    " let g:EasyGrepAllOptionsInExplorer=1
    " let g:EasyGrepCommand=1
    " let g:EasyGrepReplaceWindowMode=2

"neocomplete配置
    " Disable AutoComplPop.
    "let g:acp_enableAtStartup = 0
    "打开vim自动启用neocomplete
    let g:neocomplete#enable_at_startup = 1
    " Use smartcase.
    let g:neocomplete#enable_smart_case = 1
    let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
    " Define dictionary.
    let g:neocomplete#data_directory = $VIM.'/vimfiles/tmp/neocomplete'
    let g:neocomplete#sources#dictionary#dictionaries = {
            \ 'default' : '',
            \ 'autohotkey' : $VIM.'/vimfiles/dict/AutoHotkey',
            \ }
    if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns['default'] = '\h\w*'
    " Plugin key-mappings.
    "inoremap <expr><C-g>     neocomplete#undo_completion()
    "inoremap <expr><C-l>     neocomplete#complete_common_string()
    " Recommended key-mappings.
    " <CR>: close popup and save indent.
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
      return neocomplete#close_popup() . "\<CR>"
      " For no inserting <CR> key.
      "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
    endfunction
    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    " <C-h>, <BS>: close popup and delete backword char.
    " inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><C-u>  neocomplete#close_popup()
    inoremap <expr><A-u>  neocomplete#cancel_popup()
    " Close popup by <Space>.
    "inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"
    " For cursor moving in insert mode(Not recommended)
    "inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
    "inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
    "inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
    "inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
    " Or set this.
    "let g:neocomplete#enable_cursor_hold_i = 1
    " Or set this.
    "let g:neocomplete#enable_insert_char_pre = 1
    "像AutoComplPop一样自动选中第一项
    "let g:neocomplete#enable_auto_select = 1
    " Shell like behavior(not recommended).
    "set completeopt+=longest
    "let g:neocomplete#enable_auto_select = 1
    "let g:neocomplete#disable_auto_complete = 1
    "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"
    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    " Enable heavy omni completion.
    if !exists('g:neocomplete#sources#omni#input_patterns')
      let g:neocomplete#sources#omni#input_patterns = {}
    endif
    if !exists('g:neocomplete#force_omni_input_patterns')
      let g:neocomplete#force_omni_input_patterns = {}
    endif

"neosnippet configure:
    imap <A-s>     <Plug>(neosnippet_expand_or_jump)
    smap <A-s>     <Plug>(neosnippet_expand_or_jump)
    xmap <A-s>     <Plug>(neosnippet_expand_target)
    let g:neosnippet#snippets_directory='$VIM/vimfiles/bundle/neosnippet-snippets/neosnippets'

"pydiction configure
    " let g:pydiction_location = '$VIM/vimfiles/bundle/pydiction/complete-dict'
    " let python_highlight_all = 1
    " let g:pydiction_menu_height = 6

"nerdtree configure
    map <leader>st :NERDTreeToggle<CR>
    let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree"
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

"nerdcommenter configure：
    imap <A-i> <plug>NERDCommenterInsert

"repeat configure
    silent! call repeat#set("\<surround.vim><Leader>rp1", v:count)
    silent! call repeat#set("\<vim-easymotion><Leader>rp2", v:count)

" configure syntastic syntax checking to check on open as well as save
    let g:syntastic_check_on_open=1
    let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_wq = 0
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

"taglist/tagbar configure
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
     "--------------------------------------------------------------------
     let Tlist_Auto_Highlight_Tag=1
     let Tlist_Auto_Open=0
     let Tlist_Auto_Update=1
     let Tlist_Close_On_Select=1
     let Tlist_Display_Tag_Scope=1
     let Tlist_Exit_OnlyWindow=1
     let Tlist_Enable_Dold_Column=1
     let Tlist_File_Fold_Auto_Close=1
     let Tlist_GainFocus_On_ToggleOpen=1
     let Tlist_Show_One_File=1
     let Tlist_Use_Right_Window=1
     let Tlist_Use_SingleClick=1
     nnoremap <silent> <leader>vt :TlistToggle<CR>  “设定F8为taglist开关

"auto-pairs configure:
    let g:AutoPairsFlyMode = 1
    " let g:AutoPairsShortcutBackInsert = '<M-b>'
    " let g:AutoPairsShortcutToggle = '<Leader>pt'

"markdown configure:
    let g:vim_markdown_folding_disabled=1
    let g:vim_markdown_no_default_key_mappings=1
    let g:vim_markdown_math=1
    let g:vim_markdown_frontmatter=1

"undotree configure:
    nnoremap <Leader>su :UndotreeToggle<cr>
    " let g:undotree_DiffAutoOpen = 0
    let g:undotree_SetFocusWhenToggle = 1
    function! g:Undotree_CustomMap()
        nmap <buffer> J <plug>UndotreeGoNextState
        nmap <buffer> K <plug>UndotreeGoPreviousState
        nmap <buffer> r <plug>UndotreeRedo
    endfunc

"tmuxline configure:
    let g:tmuxline_powerline_separators = 0
    "let g:tmuxline_preset = 'nightly_fox'
    let g:tmuxline_preset = 'powerline'
    let g:tmuxline_theme = 'powerline'

"syntastic configure:
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0
    let g:syntastic_python_checkers = ['flake8']

"flake8 configure:
     " autocmd FileType python map <buffer> <leader>cp :call Flake8()<CR>
     " "let g:flake8_cmd="/opt/strangebin/flake8000"
     " let g:flake8_show_in_gutter=1
     " highlight link Flake8_Error      Error
     " highlight link Flake8_Warning    WarningMsg
     " highlight link Flake8_Complexity WarningMsg
     " highlight link Flake8_Naming     WarningMsg
     " highlight link Flake8_PyFlake    WarningMsg

"python-mode configure:
    " let g:pymode_rope_goto_definition_bind = "<Leader>gd"
    " " Override run current python file key shortcut to Ctrl-Shift-e
    " let g:pymode_run_bind = "<Leader>rs"
    " " Override view python doc key shortcut to Ctrl-Shift-d
    " let g:pymode_doc_bind = "<Leader>vd"
    " let g:pymode_breakpoint_bind = '<leader>bp'
    " let g:pymode_syntax = 1
    " let g:pymode_indent = 1
    " let g:pymode_folding = 1
    " let g:pymode_options = 1
    " let g:pymode_trim_whitespaces = 1
    " let g:pymode_options_colorcolumn = 1
    " let g:pymode_options_max_line_length = 110

"indent-guides:
    let g:indent_guides_guide_size = 2  " 指定对齐线的尺寸
    let NERDSpaceDelims = 1             " 自动添加前置空格

"vim-bgimg:
    ":call bgimg#set_image("d:\Download\zipp\壁纸\starry-night.jpg")

"  < Vundle 插件管理工具配置 >
set rtp+=$VIM/vimfiles/bundle/Vundle.vim/                 "在Windows下本行及下行必须这样"
call vundle#rc('$VIM/vimfiles/bundle/')
"使用Vundle来管理Vundle，这个必须要有。
    Bundle 'gmarik/Vundle.vim'
    " Bundle 'tpope/vim-fugitive'
    Plugin 'easymotion/vim-easymotion'
    Plugin 'vim-airline/vim-airline'
    "Plugin 'plasticboy/vim-markdown'
    "Bundle 'godlygeek/tabular'
    Bundle 'dimasg/vim-mark'
    "Plugin 'iamcco/dict.vim'
    " Bundle 'rkulla/pydiction'
    "Bundle 'nvie/vim-flake8'
    "Bundle 'klen/python-mode'
    "Bundle 'vim-scripts/indentpython.vim'
    "Bundle 'edkolev/tmuxline.vim'
    Bundle 'txtbrowser'
    Bundle 'taglist.vim'
    "Bundle 'petdance/ack2'
    Bundle 'svermeulen/EasyGrep'
    Bundle 'majutsushi/tagbar'
    Bundle 'junegunn/vim-easy-align'
    Bundle 'jiangmiao/auto-pairs'
    Bundle 'tpope/vim-surround'
    Bundle 'tpope/vim-repeat'
    Bundle 'Shougo/neocomplete.vim'
    Bundle 'Shougo/neosnippet.vim'
    Bundle 'Shougo/neosnippet-snippets'
    Bundle 'scrooloose/syntastic'
    Bundle 'scrooloose/nerdcommenter'
    Bundle 'scrooloose/nerdtree'
    Bundle 'kien/ctrlp.vim'
    Bundle 'yegappan/mru'
    Bundle 'mbbill/undotree'
    Bundle 'yonchu/accelerated-smooth-scroll'
    Bundle 'nathanaelkane/vim-indent-guides'
    Bundle 'vim-bgimg'
