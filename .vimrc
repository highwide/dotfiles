"#####表示設定#####
set number "行番号表示
set title "編集中ファイル表示
set showmatch "括弧入力時の対応する括弧を表示
set paste "ペースト時のオートインデント無効
set cursorline "カーソルの行を強調
set cursorcolumn "カーソルの列を強調
set autoindent  "オートインデント
set smartindent "オートインデント時の増減

"#####mac用#####
set clipboard+=unnamed "ヤンクしたテキストがクリップボードに入る
set nocompatible "viとの互換性を無効にする
set backspace=indent,eol,start "行頭の空白、改行、挿入モード開始より前の文字を削除可能

"#####ruby用#####
set tabstop=2 "tabはスペース2つ
set shiftwidth=2 "自動インデントはスペース2つ
set softtabstop=0 "tabキーをおしたときのタブ設定はtabstopに依る
set expandtab "tabはtab文字ではなく空白文字
source $VIMRUNTIME/macros/matchit.vim "do/endを移動

"####検索設定####
set ignorecase "検索時に大文字/小文字を区別しない
set smartcase "検索ワードに大文字が入っていたら区別する
set wrapscan	"検索時に最後まで行ったら最初に戻る
set hlsearch  "ハイライト検索する

"####色設定####
let g:hybrid_use_iTerm_colors = 1
colorscheme hybrid
syntax on

"###keymap###
nnoremap <silent><C-e> :NERDTreeToggle<CR>

"####Neobundle設定####
" bundleで管理するディレクトリ指定
set runtimepath+=~/.vim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" neobundle自体をneobundleで管理
NeoBundleFetch 'Shougo/neobundle.vim'

"###ここからプラグイン設定###

" NERDTree(編集中のファイル・ディレクトリを一覧して見られる)
NeoBundle 'scrooloose/nerdtree'

" vim-slim(slimを書くときのテンプレート)
NeoBundle 'slim-template/vim-slim'

" autoclose(括弧の補完)
" NeoBundle 'Townk/vim-autoclose'

" endwise(Rubyでdoやifに対するendを補完)
NeoBundle 'tpope/vim-endwise'

" vim-line(インデントの深さを線で可視化)
" NeoBundle 'Yggdroot/indentLine'

" vim-lineの設定
" let g:indentLine_color_term=3
" let g:indentLine_color_gui='red'
" let g:indentLine_char='¦'

" vim-indent-guides(インデントの深さを可視化)
" NeoBundle 'nathanaelkane/vim-indent-guides'

" vim-indent-guidesの色設定
" let g:indent_guides_auto_colors=0
" autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
" autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
" 
" " vim-indent-guidesのサイズ設定
" let g:indent_guides_guide_size=1
" 
" " vimを立ち上げたときに、自動的にvim-indent-guidesをonにする
" let g:indent_guides_enable_on_vim_startup=1
" 
" vim-markdown
NeoBundle 'plasticboy/vim-markdown'
au BufRead,BufNewFile *.md set filetype=markdown
let g:vim_markdown_folding_disabled=1

" previm
NeoBundle 'kannokanno/previm'

" open-browser
NeoBundle 'tyru/open-browser.vim'

" AnsiEsc(ログなどANSIカラー情報が埋め込まれているファイルはカラー表示)
NeoBundle 'vim-scripts/AnsiEsc.vim'

" syntastic(syntaxチェックの定番らしい)
NeoBundle 'scrooloose/syntastic'
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['ruby'] }
let g:syntastic_ruby_checkers = ['rubocop']


" Unite.vim
NeoBundle 'Shougo/unite.vim'
" Unite.vim(Unite.vimで最近使ったファイルを表示
NeoBundle 'Shougo/neomru.vim'
" AG用vimproc
NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\   'mac'   : 'make -f make_mac.mak',
\   'linux' : 'make',
\   'unix'  : 'gmake',
\   },
\ }

" insert modeで開始
" let g:unite_enable_start_insert=1

" 
let g:unite_source_history_yank_enable = 1
let g:unite_source_file_mru_limit = 200

" 大文字小文字を区別しない
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1

" ヤンク一覧
nnoremap <silent> ,uy :<C-u>Unite history/yank<CR>
" バッファ一覧
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイルとバッファ
nnoremap <silent> ,uu :<C-u>Unite file_mru buffer<CR>

" grep
nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
" カーソル位置の単語をgrep
nnoremap <silent> ,cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>
" grep結果の再呼出
nnoremap <silent> ,r  :<C-u>UniteResume search-buffer<CR>

" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q

" unite grepにagを使う
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opts = ''
endif

call neobundle#end() "NeoBundleプラグインここまで

" Required:
filetype plugin indent on

NeoBundleCheck "プラグインのインストール確認
