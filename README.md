# dot-files

Repo for my dot files.

## Notes on VI setup

The system VI for MacOS Mojave (10.14+) doesn't work with the powerline bundle. So powerline has been commented out.

- Clone Vundle by running: `git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim`
- Copy `.vimrc` from the project into the root directory.
- Start `vi`. Ignore the error.
- Run command `:PluginInstall` in `vi` to install all plugins.

### Finish YouCompleteMe Installation

A few more steps are required for YouCompleteMe:

- Run `brew install cmake`
- Go to `~/.vim/bundle/YouCompleteMe`
- Run `./install.py --clang-completer`. Make sure system python (2.7.x) is in use.
