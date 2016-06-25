# Markdown Vim Mode

[![Build Status](https://travis-ci.org/plasticboy/vim-markdown.svg)](https://travis-ci.org/plasticboy/vim-markdown)

Syntax highlighting, matching rules and mappings for [the original Markdown](http://daringfireball.net/projects/markdown/) and extensions.

## Installation

If you use [Vundle](https://github.com/gmarik/vundle), add the following line to your `~/.vimrc`:

```vim
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
```

The `tabular` plugin must come *before* `vim-markdown`.

Then run inside Vim:

```vim
:so ~/.vimrc
:PluginInstall
```

If you use [Pathogen](https://github.com/tpope/vim-pathogen), do this:

```sh
cd ~/.vim/bundle
git clone https://github.com/plasticboy/vim-markdown.git
```

To install without Pathogen using the Debian [vim-addon-manager](http://packages.qa.debian.org/v/vim-addon-manager.html), do this:

```sh
git clone https://github.com/plasticboy/vim-markdown.git
cd vim-markdown
sudo make install
vim-addon-manager install mkd
```

If you are not using any package manager, download the [tarball](https://github.com/plasticboy/vim-markdown/archive/master.tar.gz) and do this:

```sh
cd ~/.vim
tar --strip=1 -zxf vim-markdown-master.tar.gz
```

## Options

### Disable Folding

Add the following line to your `.vimrc` to disable folding configuration.

```vim
let g:vim_markdown_folding_disabled=1
```

This option only controls vim_markdown's folding configuration. To enable/disable folding use Vim's folding configuration.

```vim
set [no]foldenable
```

### Disable Default Key Mappings

Add the following line to your `.vimrc` to disable default key mappings. You can map them by yourself with `<Plug>` mappings.

```vim
let g:vim_markdown_no_default_key_mappings=1
```

### Syntax extensions

The following options control which syntax extensions will be turned on. They are off by default.

#### LaTeX math

Used as `$x^2$`, `$$x^2$$`, escapable as `\$x\$` and `\$\$x\$\$`.

```vim
let g:vim_markdown_math=1
```

#### YAML frontmatter

Highlight YAML frontmatter as used by Jekyll:

```vim
let g:vim_markdown_frontmatter=1
```

## Mappings

The following work on normal and visual modes:

- `]]`: go to next header. `<Plug>(Markdown_MoveToNextHeader)`
- `[[`: go to previous header. Contrast with `]c`. `<Plug>(Markdown_MoveToPreviousHeader)`
- `][`: go to next sibling header if any. `<Plug>(Markdown_MoveToNextSiblingHeader)`
- `[]`: go to previous sibling header if any. `<Plug>(Markdown_MoveToPreviousSiblingHeader)`
- `]c`: go to Current header. `<Plug>(Markdown_MoveToCurHeader)`
- `]u`: go to parent header (Up). `<Plug>(Markdown_MoveToParentHeader)`

## Commands

- `:HeaderDecrease`:

    Decrease level of all headers in buffer: `h2` to `h1`, `h3` to `h2`, etc.

    If range is given, only operate in the range.

    If an `h1` would be decreased, abort.

    For simplicity of implementation, Setex headers are converted to Atx.

- `:HeaderIncrease`: Analogous to `:HeaderDecrease`, but increase levels instead.

- `:SetexToAtx`:

    Convert all Setex style headers in buffer to Atx.

    If a range is given, e.g. hit `:` from visual mode, only operate on the range.

- `:TableFormat`: Format the table under the cursor [like this](http://www.cirosantilli.com/markdown-styleguide/#tables).

    Requires [Tabular](https://github.com/godlygeek/tabular).

    The input table *must* already have a separator line as the second line of the table.
    That line only needs to contain the correct pipes `|`, nothing else is required.

- `:Toc`: create a quickfix vertical window navigable table of contents with the headers.

    Hit `<Enter>` on a line to jump to the corresponding line of the markdown file.

- `:Toch`: Same as `:Toc` but in an horizontal window.

- `:Toct`: Same as `:Toc` but in a new tab.

- `:Tocv`: Same as `:Toc` for symmetry with `:Toch` and `Tocv`.

## Credits

The main contributors of vim-markdown are:

- **Ben Williams** (A.K.A. **plasticboy**). The original developer of vim-markdown. [Homepage](http://plasticboy.com/).

If you feel that your name should be on this list, please make a pull request listing your contributions.

## License

The MIT License (MIT)

Copyright (c) 2012 Benjamin D. Williams

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


## 一.主要特性
+ 支持通用 Markdown / CommonMark 和 GFM (GitHub Flavored Markdown) 风格的语法，也可 变身为代码编辑器 ；
+ 支持实时预览、图片（跨域）上传、预格式文本/代码/表格插入、代码折叠、跳转到行、搜索替换、只读模式、自定义样式主题和多语言语法高亮等功能；
+ 支持  ToC（Table of Contents） 、 Emoji表情 、 Task lists 、 @链接 等 Markdown 扩展语法；
+ 支持 TeX 科学公式（基于  KaTeX ）、流程图  Flowchart  和  时序图 Sequence Diagram ;
+ 支持 识别和解析 HTML 标签，并且支持自定义过滤标签及属性解析 ，具有可靠的安全性和几乎无限的扩展性；
+ 支持 AMD / CMD 模块化加载（支持  Require.js  &  Sea.js ），并且支持 自定义扩展插件 ；
+ 兼容主流的浏览器（IE8+）和  Zepto.js ，且支持 iPad 等平板设备；
 
来源： < http://blog.csdn.net/akof1314/article/details/45102385 > 
 
## 二. 黑体字      # 主标题，最粗最黑的。
 
     ## This is title two
     #### 字号更小的标题，跟**这种样式一样的**
     ###### 这个的效果是淡灰色样式
 
## 三. 斜体字
     *很细的 斜体字 *
    **这个是用在行中加粗的样式**
     ***这个的效果是上面的字体大小+斜体***
 
 
## 四.有序列表
     1. 有序列表一，注意“.”后面是有空格的，而且是必须的
     2. 好像也没有什么样式改变
     3.在这里可以看到缩进的效果，这行数字后面的圆点没有空格
 
## 五.无序列表
+ 无序列表一，注意空格。
+ 其实就是前面的加号变成了淡黑色实心圆圈，这行“+”后面空了两格
_________________________________________________________________
下划线的样式是一个有图案的分界线
 
## 六.  链接
     为知笔记 | 如何用 markdown 写出格式良好的笔记？  http://blog.wiz.cn/feature-markdown.html
---------------------------------------------------------------------
这样做就会让紧接着的上一行加粗(如果不tab缩进的话，像主标题一样粗)
 
## 七.表格
| 应用名称 | 使用体验 |
| - - - - - - - -| - - - - - - - - |
| 有道云笔记 | 功能少 没什么感觉 |
| 印象笔记 | 厌恶总是要创建副本 |
| Wiz | 目前用得还行 |
| OneNote | 没有用过 |
 
## 八. Wiz MarkDownk下载安装及使用Tips
点击[这里下载安装]( https://github.com/akof1314/Wiz.Editor.md/releases)
                                  ↓
 
然后拖拽到wiz窗口即可安装，或者解压放到`XX\MyKonwledge\Plugins\``下
                                  ↓
新建一篇以 .md为后缀的笔记，预览效果使用组合键Ctrl+e/F4
 
## 十.想快速入门MarkDown语法和学习更多关于MarkDown，请看这里：
+ Markdown 语法快速入门
  http://wowubuntu.com/markdown/basic.html
+ Markdown 语法说明手册(简体中文版)
  http://wowubuntu.com/markdown/
+ Markdown 工具补完--小众介绍
http://www.appinn.com/markdown-tools/
+ 知乎· 怎样引导新手使用 Markdown？
  http://www.zhihu.com/question/20409634
 
