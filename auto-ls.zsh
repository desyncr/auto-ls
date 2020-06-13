# vim: sw=2 ts=2 et!
# set up default functions

if (( ! ${+AUTO_LS_CHPWD} )); then
  AUTO_LS_CHPWD=true
fi

if [[ $#AUTO_LS_COMMANDS -eq 0 ]]; then
  AUTO_LS_COMMANDS=(ls git-status)
fi

if (( ! ${+AUTO_LS_NEWLINE} )); then
  AUTO_LS_NEWLINE=true
fi

if (( ! ${+AUTO_LS_PATH} )); then
  AUTO_LS_PATH=true
fi


auto-ls-ls () {
  ls
  [[ $AUTO_LS_NEWLINE != false ]] && echo ""
}

auto-ls-git-status () {
  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == true ]]; then
    git status
  fi
}

auto-ls () {
  # Possible invocation sources:
  #  1. Called from `chpwd_functions` – show file list
  #  2. Called by another ZLE plugin (like `dirhistory`) through `zle accept-line` – show file list
  #  3. Called by ZLE itself – only should file list if prompt was empty
  if ! zle                          \
  || { [[ ${WIDGET} != accept-line ]] && [[ ${LASTWIDGET} != .accept-line ]] }\
  || { [[ ${WIDGET} == accept-line ]] && [[ $#BUFFER -eq 0 ]] }; then
    zle && echo
    for cmd in $AUTO_LS_COMMANDS; do
      # If we detect a command with full path, ex: /bin/ls execute it
      if [[ $AUTO_LS_PATH != false && $cmd =~ '/' ]]; then
        eval $cmd
      else
        # Otherwise run auto-ls function
        auto-ls-$cmd
      fi
    done
    zle && zle .accept-line
  fi

  # Forward this event down the ZLE stack
  if zle; then
    if [[ ${WIDGET} == accept-line ]] && [[ $#BUFFER -eq 0 ]]; then
      # Shortcut to reduce the number of empty lines appearing
      # when pressing Enter
      echo && zle redisplay
    elif [[ ${WIDGET} != accept-line ]] && [[ ${LASTWIDGET} == .accept-line ]]; then
      # Hack to make only 2 lines appear after `dirlist` navigation
      # (Uses a VT100 escape sequence to move curser up one line…)
      tput cuu 1
    else
      zle .accept-line
    fi
  fi
}

zle -N auto-ls
zle -N accept-line auto-ls

if [[ ${AUTO_LS_CHPWD} == true && ${chpwd_functions[(I)auto-ls]} -eq 0 ]]; then
  chpwd_functions+=(auto-ls)
fi
