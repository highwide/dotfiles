"#####表示設定#####
set number "行番号表示
set title "編集中ファイル表示
syntax on "コードの色分け
set showmatch "括弧入力時の対応する括弧を表示
set smartindent "オートインデント

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
NeoBundle 'Townk/vim-autoclose'

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


" Unite.vim(vimのファイラ)
NeoBundle 'Shougo/unite.vim'
" Unite.vim(Unite.vimで最近使ったファイルを表示
NeoBundle 'Shougo/neomru.vim'


call neobundle#end() "NeoBundleプラグインここまで

" Required:
filetype plugin indent on

NeoBundleCheck "プラグインのインストール確認
