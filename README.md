# Auto-ls

There are many `auto-ls`s out there but this one is mine.

# Features

- Custom command on `cwd` change/`enter-key`
- Auto `ls` on `cwd` change
- Auto `ls` on `enter-key` (with empty buffer)
- Git status on a git work tree

# Install

- Manual

      curl -L https://git.io/auto-ls > /path/to/auto-ls.zsh
      source /path/to/auto-ls.zsh

- [Antigen](https://github.com/zsh-users/antigen)

      antigen bundle desyncr/auto-ls
    
# Configuration

- `AUTO_LS_COMMANDS`: Use this configuration option to define the functions to run on cwd/enter-key.

Example: `AUTO_LS_COMMANDS=(ls git-status)`

# Customization

You may redefine default functions or define custom functions to be run on cwd/enter-key:

- Before loading auto-ls define a function to be executed:

      auto-ls-custom_function () {
        echo "Current directory list:"
        ls -ltra
      }


    * Be sure to call it `auto-ls-`\<name of your function\>.
    * It can be a binary instead of a function, but be sure it's located in `$PATH` and with the proper `+x` flags.

- Configure auto-ls to load your function. Put the following line before sourcing auto-ls:

      AUTO_LS_COMMANDS=(custom_function)

   * Only use \<name of your function\> rather than `auto-ls-`\<name of your function\>.
    
You may as well load the default functions, `ls` and `git-status`:

     AUTO_LS_COMMANDS=(ls git-status custom_function)

# Future

- `zstyle` options to customize ls options
- `zstyle` options to customize git status
