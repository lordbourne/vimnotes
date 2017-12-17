" Plugin location: ~/.vim/bundle/
"
set nocompatible
syntax on
set number
set laststatus=2
set clipboard=unnamed
" set pastetoggle=<F11> " conflict with vdebug keymap
set foldcolumn=0

set tabstop=4
set softtabstop=4
set shiftwidth=4
set backspace=2
set expandtab
set showcmd

" set foldmethod=indent
set hlsearch
set incsearch
set ignorecase
set wrap
set textwidth=80

set fileformat=unix

" nnoremap k gk
" nnoremap gk k
" nnoremap j gj
" nnoremap gj j

" make & trigger :&&, first & for last substitution and second for last flags
nnoremap & :&&<CR>
xnoremap & :&&<CR>

" ---------- Settings for files with specific extension ----------
au BufNewFile,BufRead *.py
\ set autoindent |
\ set makeprg=python |

" map <F5> :Autopep8<CR> :w<CR> :call RunPython()<CR> " conflict with vdebug keymap
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

" for html
au BufNewFile,BufRead *.html
\ set tabstop=2 |
\ set softtabstop=2 |
\ set shiftwidth=2 |

" \ set autoindent
" \ set textwidth=79
" ---------- Settings for files with specific extension ----------

" refine the * command in visual mode
xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>
function! s:VSetSearch()
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
    let @s = temp
endfunction


:let mapleader = "\\"

filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'davidhalter/jedi-vim'
Plugin 'mattn/emmet-vim'
Plugin 'scrooloose/nerdtree'    " 目录树
Plugin 'Yggdroot/indentLine'
Plugin 'taglist.vim'            " 函数浏览器
Plugin 'vimwiki'
Plugin 'tell-k/vim-autopep8'
Plugin 'joonty/vdebug'          " debug 插件
Plugin 'Tabular'
Plugin 'lifepillar/vim-cheat40'
call vundle#end()
filetype plugin indent on

" --------------- Netrw plugin settings -------------------- "
let g:netrw_winsize=15  " 窗口大小，占总列数或总行数的 15%
let g:netrw_list_hide='^\.\S\+,.*\.pyc$,I_,^_$'
let g:netrw_banner=0    " 不显示 banner 部分
let g:netrw_liststyle=3 " display in tree form 
let g:netrw_browse_split=2 " open files in a new vertical split
" --------------- Netrw plugin settings -------------------- "

" --------------- YouCompleteMe plugin settings -------------------- "
"youcompleteme  默认tab  s-tab 和自动补全冲突
let g:ycm_key_list_select_completion=['<c-n>', '<Down>']
let g:ycm_key_list_previous_completion=['<c-p>', '<Up>']
"let g:ycm_confirm_extra_conf=0 "关闭加载.ycm_extra_conf.py提示
"
"let g:ycm_collect_identifiers_from_tags_files=1 " 开启 YCM 基于标签引擎
"let g:ycm_min_num_of_chars_for_completion=2 " 从第2个键入字符就开始罗列匹配项
"let g:ycm_cache_omnifunc=0  " 禁止缓存匹配项,每次都重新生成匹配项
" let g:ycm_seed_identifiers_with_syntax=1    " 语法关键字补全
"nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>    "force recomile with
"syntastic
""nnoremap <leader>lo :lopen<CR> "open locationlist
"nnoremap <leader>lc :lclose<CR>    "close locationlist
"inoremap <leader><leader> <C-x><C-o>
let g:ycm_complete_in_comments = 1                          " 在注释输入中也能补全
let g:ycm_complete_in_strings = 1                           " 在字符串输入中也能补全
let g:ycm_collect_identifiers_from_comments_and_strings = 0 " 注释和字符串中的文字也会被收入补全
let g:ycm_server_python_interpreter='/usr/bin/python'
let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py'
" --------------- YouCompleteMe plugin settings -------------------- "

" --------------- jedi-vim plugin settings -------------------- "
let g:jedi#completions_command = "<C-n>"
let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#rename_command = "<leader>r"
let g:jedi#popup_on_dot = 1
" --------------- jedi-vim plugin settings -------------------- "
"
" --------------- nerdtree plugin settings -------------------- "
map <F2> :NERDTreeToggle<CR>
let NERDTreeChDirMode=1
let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$', '\.tags$', 'tags'] " ignore files
let NERDTreeWinSize=25
" --------------- nerdtree plugin settings -------------------- "

" --------------- indentLine plugin settings -------------------- "
let g:indentLine_char='┆'
let g:indentLine_enabled = 0
" --------------- indentLine plugin settings -------------------- "
"
" --------------- vim-autopep8 plugin settings -------------------- "
let g:autopep8_disable_show_diff=1
" --------------- vim-autopep8 plugin settings -------------------- "
"
" --------------- taglist plugin settings -------------------- "
" if MySys() == 'windows'                "设定windows系统中ctags程序的位置
"     let Tlist_Ctags_Cmd = 'ctags'
" elseif MySys() == 'linux'              "设定windows系统中ctags程序的位置
"     let Tlist_Ctags_Cmd = '/usr/bin/ctags'
" endif
let Tlist_Ctags_Cmd = '/usr/bin/ctags'
let Tlist_Show_One_File = 1            "不同时显示多个文件的tag，只显示当前文件的
let Tlist_Exit_OnlyWindow = 1          "如果taglist窗口是最后一个窗口，则退出vim
let Tlist_Use_Right_Window = 1         "在右侧窗口中显示taglist窗口
let Tlist_WinWidth=20                  "设置taglist宽度
let Tlist_Enable_Fold_Column=0
" --------------- taglist plugin settings -------------------- "
"
" --------------- cscope plugin settings --------------- "
" Run commands below before using cscopes:
" find . -name '*.py' > cscope.files
" find /usr/lib64/python2.7/site-packages -name '*.py' >> cscope.files
" find /usr/lib/python2.7/site-packages -name '*.py' >> cscope.files
" cscope -Rbqk

if has("cscope")
	set csprg=/usr/local/bin/cscope
	set csto=0
	set cst
	set nocsverb
	" add any database in current directory
	if filereadable("cscope.out")
		cs add cscope.out
	" else add database pointed to by environment
	elseif $CSCOPE_DB != ""
		cs add $CSCOPE_DB
	endif
	set csverb
endif
:set cscopequickfix=s-,c-,d-,i-,t-,e-

nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-@>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>
" --------------- cscope plugin settings --------------- "
"
" --------------- statusline settings --------------- "
function! Buf_total_num()
    return len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))
endfunction
function! File_size(f)
    let l:size = getfsize(expand(a:f))
    if l:size == 0 || l:size == -1 || l:size == -2
        return ''
    endif
    if l:size < 1024
        return l:size.''
    elseif l:size < 1024*1024
        return printf('%.1f', l:size/1024.0).'k'
    elseif l:size < 1024*1024*1024
        return printf('%.1f', l:size/1024.0/1024.0) . 'm'
    else
        return printf('%.1f', l:size/1024.0/1024.0/1024.0) . 'g'
    endif
endfunction
set statusline=%<%1*[B-%n]%*
" TOT is an abbreviation for total
set statusline+=%2*[TOT:%{Buf_total_num()}]%*
set statusline+=%3*\ %{File_size(@%)}%*
set statusline+=%4*\ %f\ %*                   " relative file path
set statusline+=%5*『\ %{exists('g:loaded_ale')?ALEGetStatusLine():''}』%{exists('g:loaded_fugitive')?fugitive#statusline():''}%*
set statusline+=%6*\ %m%r%y\ %*               " modified readonly filetype
set statusline+=%=%7*\ %{&ff}\ \|\ %{\"\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"\ \|\"}\ %-14.(%l:%c%V%)%*
set statusline+=%8*\ %P\ %*                   " Percentage
" default bg for statusline is 236 in space-vim-dark
" hi User1 cterm=bold ctermfg=232 ctermbg=179
" hi User2 cterm=None ctermfg=214 ctermbg=242
" hi User3 cterm=None ctermfg=251 ctermbg=240
" hi User4 cterm=bold ctermfg=169 ctermbg=239
" hi User5 cterm=None ctermfg=208 ctermbg=238
" hi User6 cterm=None ctermfg=246 ctermbg=237
" hi User7 cterm=None ctermfg=250 ctermbg=238
" hi User8 cterm=None ctermfg=249 ctermbg=240
hi User1 cterm=bold ctermfg=black ctermbg=white
hi User2 cterm=None ctermfg=black ctermbg=white
hi User3 cterm=None ctermfg=black ctermbg=white
hi User4 cterm=bold ctermfg=black ctermbg=white
hi User5 cterm=None ctermfg=black ctermbg=white
hi User6 cterm=None ctermfg=black ctermbg=white
hi User7 cterm=None ctermfg=black ctermbg=white
hi User8 cterm=None ctermfg=black ctermbg=white
" --------------- statusline settings --------------- "
