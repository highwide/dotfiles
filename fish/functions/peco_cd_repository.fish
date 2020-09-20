function _peco_cd_repository
  if [ (count $argv) ]
    peco --query "$argv "|perl -pe 's/([ ()])/\\\\$1/g'|read foo
  else
    peco |perl -pe 's/([ ()])/\\\\$1/g'|read foo
  end
  if [ $foo ]
    builtin cd $foo
  else
    commandline ''
  end
end

function peco_cd_repository
  ghq list --full-path | _peco_cd_repository $argv
end
