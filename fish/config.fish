function fish_user_key_bindings
  bind \cr peco_select_history
  bind \cs peco_cd_repository
end

set -x GOPATH $HOME/go
set -x PATH $PATH $GOPATH/bin
set -x PATH $HOME/.anyenv/bin $PATH
set -x PATH ./node_modules/.bin $PATH
set -x PATH ./highwide/.bin $PATH

set -x LC_ALL en_US.UTF-8

set -g fish_user_paths "/usr/local/opt/libxml2/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/libiconv/bin" $fish_user_paths
eval (anyenv init - | source)
eval (direnv hook fish)
set -g fish_user_paths "/usr/local/opt/bison/bin" $fish_user_paths
