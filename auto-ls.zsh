# vim: sw=2 ts=2 et!
AUTO_LS_COMMANDS=(ls git-status)
auto-ls-ls () {
  ls
  echo ""
}

auto-ls-git-status () {
  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == true ]]; then
    git status
  fi
}

auto-ls () {
  if [[ $#BUFFER -eq 0 ]]; then
    zle && echo ""
    for cmd in $AUTO_LS_COMMANDS; do
      auto-ls-$cmd
    done
    zle && zle redisplay
  else
    zle .$WIDGET
  fi
}

zle -N auto-ls
zle -N accept-line auto-ls
chpwd_functions+=(auto-ls)
