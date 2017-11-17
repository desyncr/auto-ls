# vim: sw=2 ts=2 et!
# set up default functions
if [[ $#AUTO_LS_COMMANDS -eq 0 ]]; then
  AUTO_LS_COMMANDS=(ls git-status)
fi

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

if [[ $chpwd_functions != "" && ${chpwd_functions[(i)auto-ls]} -gt ${#chpwd_functions} ]]; then
  chpwd_functions+=(auto-ls)
fi
