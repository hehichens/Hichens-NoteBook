# vim 使用

## 1. 快捷键
```

u " undo
<C-r> " redo

:e <path> " 打开具体文件
:saveas <path> " 保存具体文件

:sv filename " 纵向分割
:vs filename " 横向分割
nnoremap <C-J> <C-W><C-J> " 设置快捷键, 正常模式下快捷键映射

% " 括号匹配 
* " 匹配上一个同名单词
# " 匹配下一个同名单词

w " 下一个单词词首
e " 下一个单词词尾

N<cmd> " 重复命令几次
" egg:
3dd " 删除3行
3p " 粘贴3次`

```

## 2. 基本配置
```
set compatible " 兼容vi
filetype off
set rtp+=~/.vim/bundle/Vundle.vim "vundle 路径


call vundle#begin()i

" 放置插件
" egg:
" Plugin 'VundleVim/Vundle.vim'

call vundle#end()
filetype plugin indent on 

" 配置代码折叠
set foldmethod=indent
set foldlevel=99
nnoremap <space> za " 空格键映射为折叠代码

" 支持 PEP8 风格缩进
au BufNewFile,BufRead *.py
\ set tabstop=4
\ set softtabstop=4
\ set shiftwidth=4
\ set textwidth=79
\ set expandtab
\ set autoindent
\ set fileformat=unix
" 其他文件格式
au BufNewFile,BufRead *.js, *.html, *.css
\ set tabstop=2
\ set softtabstop=2
\ set shiftwidth=2

" 避免多余空白字符
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" 支持utf-8
set encoding=utf-8

" 支持Python虚拟环境
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF




```


## 3. 安装插件
- 安装Vundle:
```
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```
然后即可配置 ~/.vimrc 文件来配置vim

- 安装插件方法
	1. 在~/.vimrc中Plugin
	2. 在vim中执行 ```PluginInstall```



## 4. 插件使用
### SimplyFold 
用于代码折叠
```
" 看到折叠代码的文档字符
let g:SimplyFold_docstring_preview=1
```

### indentpython.vim
自动缩进

###  YouCompleteMe
自动代码补全
[问题解决](https://www.xncoding.com/2016/06/02/linux/vim.html)
```
" 确保了在你完成操作之后，自动补全窗口不会消失
let g:ycm_autoclose_preview_window_after_completion=1
" 定义了**“转到定义”**的快捷方式。
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

```

### syntastic | vim-flake8
语法高亮
```
let python_highlight_all=1
syntax on
```

### Zenburn | vim-colors-solarized
配色方案
```
if has('gui_running')
  set background=dark
  colorscheme solarized
else
  colorscheme zenburn
endif

call togglebg#map("<F5>") # 快捷键, F5切换亮度
```

### NERDTree
文件树

```
map <F2> :NERDTreeToggle<CR> # F2打开NERDTree

ctrl + w + l 切换到目录
ctrl + w + h 切换到窗口
? 帮助
q 退出
t 新标签形式打开

"tab 页操作
:tabc close tab
:tabp pre tab
:tabn next tab


```




## 5. 其他

