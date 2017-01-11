" =============================================================================
"        << �жϲ���ϵͳ�� Windows ���� Linux ���ж����ն˻��� Gvim >>
" =============================================================================

" -----------------------------------------------------------------------------
"  < �жϲ���ϵͳ�Ƿ��� Windows ���� Linux >
" -----------------------------------------------------------------------------
if(has("win32") || has("win64") || has("win95") || has("win16"))
    let g:iswindows = 1
else
    let g:iswindows = 0
endif

" -----------------------------------------------------------------------------
"  < �ж����ն˻��� Gvim >
" -----------------------------------------------------------------------------
if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif

" =============================================================================
"                          << ����Ϊ���Ĭ������ >>
" =============================================================================

" -----------------------------------------------------------------------------
"  < Windows Gvim Ĭ������> ����һ���޸�
" -----------------------------------------------------------------------------
if (g:iswindows && g:isGUI)
    source $VIMRUNTIME/vimrc_example.vim
    "source $VIMRUNTIME/mswin.vim
    "behave mswin

    set diffexpr=MyDiff()
    function MyDiff()
      let opt = '-a --binary '
      if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
      if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
      let arg1 = v:fname_in
      if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
      let arg2 = v:fname_new
      if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
      let arg3 = v:fname_out
      if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
      if $VIMRUNTIME =~ ' '
        if &sh =~ '\<cmd'
          if empty(&shellxquote)
            let l:shxq_sav = ''
            set shellxquote&
          endif
          let cmd = '"' . $VIMRUNTIME . '\diff"'
        else
          let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
        endif
      else
        let cmd = $VIMRUNTIME . '\diff'
      endif
      silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
      if exists('l:shxq_sav')
        let &shellxquote=l:shxq_sav
      endif
    endfunction
endif

" -----------------------------------------------------------------------------
"  < Linux Gvim/Vim Ĭ������> ����һ���޸�
" -----------------------------------------------------------------------------
if !g:iswindows
    set hlsearch        "��������
    set incsearch       "������Ҫ����������ʱ��ʵʱƥ��

    " Uncomment the following to have Vim jump to the last position when
    " reopening a file
    if has("autocmd")
        au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    endif

    if g:isGUI
        " Source a global configuration file if available
        if filereadable("/etc/vim/gvimrc.local")
            source /etc/vim/gvimrc.local
        endif
    else
        " This line should not be removed as it ensures that various options are
        " properly set to work with the Vim-related packages available in Debian.
        runtime! debian.vim

        " Vim5 and later versions support syntax highlighting. Uncommenting the next
        " line enables syntax highlighting by default.
        if has("syntax")
            syntax on
        endif

        set mouse=a                    " ���κ�ģʽ���������
        set t_Co=256                   " ���ն�����256ɫ
        set backspace=2                " �����˸������

        " Source a global configuration file if available
        if filereadable("/etc/vim/vimrc.local")
            source /etc/vim/vimrc.local
        endif
    endif
endif

" =============================================================================
"                          << ����Ϊ�û��Զ������� >>
" =============================================================================

" -----------------------------------------------------------------------------
"  < pathogen ������������� >
" -----------------------------------------------------------------------------
execute pathogen#infect()
execute pathogen#helptags()

" -----------------------------------------------------------------------------
"  < �������� >
" -----------------------------------------------------------------------------
" ע��ʹ��utf-8��ʽ����������Դ�롢�ļ�·�����������ģ����򱨴�
set encoding=utf-8                                    "����gvim�ڲ�����
set fileencoding=utf-8                                "���õ�ǰ�ļ�����
set fileencodings=ucs-bom,utf-8,gbk,cp936,latin-1     "����֧�ִ򿪵��ļ��ı���

" �ļ���ʽ��Ĭ�� ffs=dos,unix
set fileformat=unix                                   "�������ļ���<EOL>��ʽ
set fileformats=unix,dos,mac                          "�����ļ���<EOL>��ʽ����

if (g:iswindows && g:isGUI)
    "����˵�����
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim

    "���consle�������
    language messages zh_CN.utf-8
endif

" -----------------------------------------------------------------------------
"  < ��д�ļ�ʱ������ >
" -----------------------------------------------------------------------------
filetype on                                           "�����ļ��������
filetype plugin on                                    "��Բ�ͬ���ļ����ͼ��ض�Ӧ�Ĳ��
filetype plugin indent on                             "��������
set smartindent                                       "�������ܶ��뷽ʽ
set expandtab                                         "��Tab��ת��Ϊ�ո�
set tabstop=4                                         "����Tab���Ŀ��
set shiftwidth=4                                      "����ʱ�Զ�����4���ո�
set smarttab                                          "ָ����һ��backspace��ɾ��shiftwidth��ȵĿո�
"set foldenable                                       "�����۵�
"set foldmethod=indent                                "indent �۵���ʽ
"set foldmethod=marker                                "marker �۵���ʽ

" -----------------------------------------------------------------------------
"  < �������� >
" -----------------------------------------------------------------------------
"set writebackup                            "�����ļ�ǰ�������ݣ�����ɹ���ɾ���ñ���
set nobackup                                "�����ޱ����ļ�
set noswapfile                              "��������ʱ�ļ�
set vb t_vb=                                "�ر���ʾ��

set ignorecase                              "����ģʽ����Դ�Сд
set smartcase                               "�������ģʽ������д�ַ�����ʹ�� 'ignorecase' ѡ�ֻ������������ģʽ���Ҵ� 'ignorecase' ѡ��ʱ�Ż�ʹ��
"set noincsearch                            "������Ҫ����������ʱ��ȡ��ʵʱƥ��

"set autoread                               "���ļ����ⲿ���޸ģ��Զ����¸��ļ�
"set autochdir                              "�Զ��л�Ŀ¼

" -----------------------------------------------------------------------------
"  < �������� >
" -----------------------------------------------------------------------------
set number                                            "��ʾ�к�
set laststatus=2                                      "����״̬����Ϣ
set cmdheight=1                                       "���������еĸ߶�Ϊ2��Ĭ��Ϊ1
set cursorline                                        "ͻ����ʾ��ǰ��
set guifont=Consolas:h11                              "��������:�ֺţ��������ƿո����»��ߴ��棩
set nowrap                                            "���ò��Զ�����
set shortmess=atI                                     "ȥ����ӭ����

" ���ô��ڳ�ʼ��λ�ü���С
if g:isGUI
    au GUIEnter * simalt ~x                           "��������ʱ�Զ����
    winpos 100 10                                     "ָ�����ڳ��ֵ�λ�ã�����ԭ������Ļ���Ͻ�
    set lines=38 columns=120                          "ָ�����ڴ�С��linesΪ�߶ȣ�columnsΪ���
    au GuiEnter * set t_vb=                           "��ֹ����
endif

colorscheme monokai                                   "��ɫ����

" ��ʾ/���ز˵������������������������� Ctrl + F11 �л�
if g:isGUI
    "set guioptions-=m
    set guioptions-=T
    "set guioptions-=r
    set guioptions-=L
    map <silent> <c-F11> :if &guioptions =~# 'm' <Bar>
        \set guioptions-=m <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=r <Bar>
        \set guioptions-=L <Bar>
    \else <Bar>
        \set guioptions+=m <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=r <Bar>
        \set guioptions+=L <Bar>
    \endif<CR>
endif

" =============================================================================
"                          << ����Ϊ���ò������ >>
" =============================================================================

" -----------------------------------------------------------------------------
"  < a.vim ������� >
" -----------------------------------------------------------------------------
" �����л�C/C++ͷ�ļ�
" :A     ---�л�ͷ�ļ�����ռ��������
" :AV    ---�л�ͷ�ļ�����ֱ�ָ��
" :AS    ---�л�ͷ�ļ���ˮƽ�ָ��

" -----------------------------------------------------------------------------
"  < nerdtree ������� >
" -----------------------------------------------------------------------------
" ��Ŀ¼��ṹ���ļ�������

" ����ģʽ������ tr ���ò��
nmap tr :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen=0

" -----------------------------------------------------------------------------
"  < TagList ������� >
" -----------------------------------------------------------------------------
" ��Ч�����Դ��, �书�ܾ���vc�е�workpace
" �������г��˵�ǰ�ļ��е����к�,ȫ�ֱ���, ��������

" ����ģʽ������ tl ���ò��������д� Tagbar �������Ƚ���ر�
nmap tl :Tlist<cr>

let Tlist_Show_One_File=1                   "ֻ��ʾ��ǰ�ļ���tags
let Tlist_Enable_Fold_Column=0              "ʹtaglist�������ʾ��ߵ��۵���
let Tlist_Exit_OnlyWindow=1                 "���Taglist���������һ���������˳�Vim
let Tlist_File_Fold_Auto_Close=1            "�Զ��۵�
let Tlist_WinWidth=30                       "���ô��ڿ��
let Tlist_Use_Right_Window=1                "���Ҳര������ʾ
let Tlist_GainFocus_On_ToggleOpen=1         "���㶨λ��taglist
let Tlist_Close_On_Select=1                 "ѡ����Զ��ر�
let Tlist_Display_Prototype=1               "��ʾprototype

let s:tlist_def_erlang_settings = 'erlang;d:macro;r:record;f:function'

" -----------------------------------------------------------------------------
"  < ctags �������� >
" -----------------------------------------------------------------------------
" ���������ǳ��ķ���,�����ں���,����֮����ת��
set tags=tags;                              "���ϼ�Ŀ¼�ݹ����tags�ļ�������ֻ����Windows�²����ã�

" -----------------------------------------------------------------------------
"  < Ctrlp ������� >
" -----------------------------------------------------------------------------
set wildignore+=*.swp,*.zip,*.exe,*.beam,*.o
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn)$',
    \ 'file': '\v\.(exe|so|dll|beam|pyc|o)$',
    \ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
    \ }

" -----------------------------------------------------------------------------
"  < �ļ��������� >
" -----------------------------------------------------------------------------
set grepprg=grep\ -nri
let g:EasyGrepFilesToExclude = "*.beam,*.bak,*~,*.o,*.pyc,data,.svn,.git,doc,ebin"
let g:EasyGrepAllOptionsInExplorer =1 "��ʹ��GrepOptions���Ƿ���ʾ����������
let g:EasyGrepRecursive = 1 "���õݹ�����
let g:EasyGrepMode = 2 "���ٵ�ǰ��չ
let g:EasyGrepCommand = 1 "use vimgrep:0 grepprg:1
let g:EasyGrepIgnoreCase = 1
let g:EasyGrepOpenWindowOnMatch = 1
let g:EasyGrepJumpToMatch = 1
let g:EasyGrepSearchCurrentBufferDir = 0

" =============================================================================
"                          << ���� >>
" =============================================================================

" ע�����������е�"<Leader>"�ڱ����������Ϊ"\"����������ķ�б�ܣ�����<Leader>t
" ָ�ڳ���ģʽ�°�"\"����"t"�������ﲻ��ͬʱ���������Ȱ�"\"����"t"���������һ
" ���ڣ���<Leader>cs���Ȱ�"\"���ٰ�"c"���ٰ�"s"��
" leader����Ϊ","
let mapleader = ","
let g:mapleader = ","

" ���������
set clipboard+=unnamed

" ����������
set colorcolumn=81

" change word to uppercase
inoremap <c-u> <esc>gUiwea

" ��<C-k,j,h,l>�л����������ҵĴ�����ȥ
nnoremap <c-k> <c-w>k
nnoremap <c-j> <c-w>j
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" ����ʱ��ת��ָ��Ŀ¼
cd d:/work

map <F2> :exec("NERDTree ".expand('%:h'))<cr>
map <F3> :exec("cd ".expand('%:h'))<cr>
map <F4> :! ctags -R --exclude="data"<CR>
map! <F4> <esc>:! ctags -R --exclude="data"<CR>a

" ˫��ʱ����
map <2-LeftMouse> *
map! <2-LeftMouse> <c-o>*
" ctrl+��������ת
map <C-LeftMouse> <C-]>
map! <C-LeftMouse> <esc><C-]>

" �鿴����
nmap <F6> :cn<cr>
nmap <F7> :cp<cr>
nmap <F8> :cw<cr>
nmap <F9> :ccl<cr>

inoremap <c-i> <c-o>I
inoremap <c-l> <c-o>A 
inoremap <c-j> <Esc><Down>I
inoremap <c-k> <Esc><Up>A

"svn����
nmap sl :!start TortoiseProc /command:log /path:% <cr>
nmap sc :!start TortoiseProc /command:commit /path:% <cr>
nmap sd :!start TortoiseProc /command:diff /path:% <cr>

"autocomplpop����
let g:acp_mappingDriven = 1 "�������ģʽ����������

" -----------------------------------------------------------------------------
" CTRL-A is Select all
noremap <C-A> gggH<C-O>G
inoremap <C-A> <C-O>gg<C-O>gH<C-O>G
cnoremap <C-A> <C-C>gggH<C-O>G
onoremap <C-A> <C-C>gggH<C-O>G
snoremap <C-A> <C-C>gggH<C-O>G
xnoremap <C-A> <C-C>ggVG

" CTRL-Tab is Next window
noremap <C-Tab> <C-W>w
inoremap <C-Tab> <C-O><C-W>w
cnoremap <C-Tab> <C-C><C-W>w
onoremap <C-Tab> <C-C><C-W>w

" CTRL-F4 is Close window
noremap <C-F4> <C-W>c
inoremap <C-F4> <C-O><C-W>c
cnoremap <C-F4> <C-C><C-W>c
onoremap <C-F4> <C-C><C-W>c

" CTRL-Z is Undo; not in cmdline though
noremap <C-Z> u
inoremap <C-Z> <C-O>u

" Use CTRL-S for saving, also in Insert mode
noremap <C-S>		:update<CR>
vnoremap <C-S>		<C-C>:update<CR>
inoremap <C-S>		<C-O>:update<CR>

vnoremap <C-X> "+x
vnoremap <C-C> "+y
map! <C-V> <Esc>"+pa