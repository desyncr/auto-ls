# Auto-ls

There are many `auto-ls`s out there but this one is mine.

# Features

- Auto `ls` on `cwd` change
- Auto `ls` on `enter-key` (with empty buffer)
- Git status on a git work tree

# Install

    antigen bundle desyncr/auto-ls

# Configuration

- `AUTO_LS_COMMANDS`: Use this configuration option to define the functions to run on cwd/enter-key.

Example: `AUTO_LS_COMMANDS=(ls git-status)`

# Customization

You may redefine default functions or define custom functions to be run on cwd/enter-key:

- Before loading auto-ls define a function to be executed

      auto-ls-custom_function () {
        echo "Current directory list:"
        ls -ltra
      }

* Be sure to call it `auto-ls-`\<name of your function\>.

- Configure auto-ls to load your function

Put the following line before sourcing auto-ls:

    AUTO_LS_COMMANDS=(custom_function)

You may as well load the default functions, `ls` and `git-status`:

    AUTO_LS_COMMANDS=(ls git-status custom_function)

* Only use <name of your function> rather than `auto-ls-`\<name of your function\>.

# Future

- `zstyle` options to customize ls options
- `zstyle` options to customize git status
