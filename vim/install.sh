#!/bin/bash

set -euo pipefail

DIR=$(cd "$(dirname "$0")"; pwd -P)

mkdir -p "$HOME/.vim"
ln -svf "$DIR/init.vim" "$HOME/.vimrc"
mkdir -p "$HOME/.vim/autoload"
ln -svf "$DIR/plug.vim" "$HOME/.vim/autoload/plug.vim"

mkdir -p "$HOME/.vim-temp/backup"
mkdir -p "$HOME/.vim-temp/swapfiles"
mkdir -p "$HOME/.vim-temp/undo"

# setup neovim to use the same config as vim
mkdir -p "$HOME/.config"
if [[ ! -L "$HOME/.config/nvim" ]]; then
    ln -svf "$HOME/.vim" "$HOME/.config/nvim"
fi
ln -svf "$HOME/.vimrc" "$HOME/.config/nvim/init.vim"
