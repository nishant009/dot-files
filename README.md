# dot-files

Repo for my dot files.

## Notes on VI setup

### Prerequisites
- Make sure you have installed `vim` with the command `brew install vim --with-lua --with-override-system-vi`

### Setup
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

## Notes on pyenv
The following steps need to be taken for `pyenv` to work on MacOS Mojave (10.14+)

- If `pyenv` is already installed uninstall and reinstall using `brew` to make sure you get the right version.
- Make sure `openssl`, `readline`, and `zlib` packages are installed. These can be installed using `brew`.
- Make sure needed headers are installed using the command: `sudo installer -pkg /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.14.pkg -target /`

You can now install python versions with `pyenv`
