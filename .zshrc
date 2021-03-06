# -----------------------------
# 環境変数
# -----------------------------

# SSHで接続した先で日本語が使えるようにする
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# エディタ
export EDITOR=/usr/local/bin/vim

# postgresの環境変数
# export PGDATA="/usr/local/var/postgres"

# goの環境変数
export GOPATH=$HOME

# --------------------------------------
# ヒストリー
# --------------------------------------
export HISTFILE=$HOME/.zsh-history
export HISTSIZE=100000
export SAVEHIST=100000
setopt extended_history
function history-all { history -E 1 }

# ----------------------------
# zshのオプション
# ----------------------------

## 補完機能の強化
autoload -U compinit promptinit
compinit

## 入力しているコマンド名が間違っている場合にもしかして:を出す
setopt correct

## ビープを鳴らさない
setopt nobeep

## 色を使う
setopt prompt_subst

## ^Dでログアウトしない
setopt ignoreeof

## バックグラウンドジョブが終了したらすぐに知らせる
setopt no_tify

## 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_dups

# 補完
#＃ タブによるファイルの順番切り替えをしない
unsetopt auto_menu

# cd -[tab]で過去のディレクトリに飛べる
setopt auto_pushd

# ディレクトリ名を入力するだけでcdできるようにする
setopt auto_cd

# メタ文字が含まれていてもファイル名と思わせない
setopt nonomatch

# Ctrl+S/Ctrl+Q によるフロー制御を使わないようにする
setopt no_flow_control

# --------------------------------------
# パス
# --------------------------------------

# 重複する要素を自動的に削除
typeset -U path cdpath fpath manpath

export PHP_ROOT="$HOME/.phpenv"

path=(
    $HOME/bin(N-/)
    /usr/local/bin(N-/)
    /usr/local/sbin(N-/)
    $HOME/.rbenv/bin(N-/)
    $PHP_ROOT/bin(N-/)
    $HOME/.nodebrew/current/bin(N-/)
    $path
)

# rbenvの環境変数
eval "$(rbenv init -)"

# phpenv
# eval "$(phpenv init -)"


# -------------------------------------
# プロンプト
# ------------------------------------

autoload -U promptinit; promptinit
autoload -Uz colors; colors
autoload -Uz vcs_info
autoload -Uz is-at-least

# begin VCS
zstyle ":vcs_info:*" enable git svn hg bzr
zstyle ":vcs_info:git:*:-all-" command /usr/bin/git
zstyle ":vcs_info:*" formats "(%s)-[%b]"
zstyle ":vcs_info:*" actionformats "(%s)-[%b|%a]"
zstyle ":vcs_info:(svn|bzr):*" branchformat "%b:r%r"
zstyle ":vcs_info:bzr:*" use-simple true

zstyle ":vcs_info:*" max-exports 6

if is-at-least 4.3.10; then
    zstyle ":vcs_info:git:*" check-for-changes true # commitしていないのをチェック
    zstyle ":vcs_info:git:*" stagedstr "<S>"
    zstyle ":vcs_info:git:*" unstagedstr "<U>"
    zstyle ":vcs_info:git:*" formtas "(%b) %c%u"
    zstyle ":vcs_info:git:*" actionformats "(%s)-[%b|%a] %c%u"
fi

funciton vcs_prompt_info() {
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && echo -n " %{$fg[yelow]%}$vcs_info_msg_0_%f"
}
# end VCS

OK="^_^ "
NG="X_X "

PROMPT=""
PROMPT+="%(?.%F{green}$OK%f.%F{red}$NG%f) "
PROMPT+="%F{magenta}%~%f"
PROMPT+="\$(vcs_prompt_info)"
PROMPT+="
"
PROMPT+="%% "
RPROMPT="[%*]"

# --------------------------------------------------
# エイリアス
# --------------------------------------------------

# -n 行数表示, -I バイナリファイル無視, svn関係のファイルを無視
alias grep="grep --color -n -I --exclude='*.svn-*' --exclude='entries' --exclude='*/cache/*'"

# ls
alias ls="ls -G" # color for darwin
alias l="ls -la"
alias la="ls -la"
alias ll="ls -la"

# bundle execを省略
alias be="bundle exec"

# rbenv execを省略
alias re="rbenv exec"

# tree
alias tree="tree -NC" # N: 文字化け対策, C:色をつける

# localhost:3000
alias ol3="open http://localhost:3000"

# gitでhubを可能にする
function git(){hub "$@"}

# ---------------------------------------------------
# キーバインド
# ---------------------------------------------------

bindkey -e

function peco-select-history() {
  local tac
  if which tac > /dev/null; then
    tac="tac"
  else 
    tac="tail -r"
  fi
  BUFFER=$(history -n 1 | \
    eval $tac | \
    awk '!a[$0]++' | \
    peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  # zle clear-screen
}
zle -N peco-select-history
bindkey "^R" peco-select-history

function peco-src() {
  local selected_dir=$(ghq list --full-path | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^s' peco-src

function peco-co-branch() {
  local selected_branch=$(git branch | peco --query "$LBUFFER")
  if [ -n "$selected_branch" ]; then
    BUFFER="git checkout ${selected_branch}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-co-branch
bindkey '^g' peco-co-branch

# ---------------------------------------------------
# その他
# ---------------------------------------------------

# cdしたあとで、自動的にls + iTerm2のタブ名変更
function chpwd() { ll ; echo -ne "\033]0;$(pwd | rev | awk -F \/ '{print "/"$1"/"$2}'| rev)\007" }

# iTerm2のタブ名を変更する
function title {
    echo -ne "\033]0;"$*"\007"
}

# added by travis gem
[ -f /Users/highwide/.travis/travis.sh ] && source /Users/highwide/.travis/travis.sh
