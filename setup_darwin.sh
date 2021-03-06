#!/bin/bash

function init() {
  # install brew
  if type brew >/dev/null 2>&1; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  # install packages
  brew install git curl peco wget go jq tree rmtrash stow ripgrep

  # install vim
  brew install neovim python@2 python@3
  pip install -U pip
  pip install neovim
  python3 -m pip install -U pip
  python3 -m pip install neovim

  # install tmux
  brew install tmux reattach-to-user-namespace

  # install fish
  brew install fish

  # make git repos dir
  mkdir -p ~/repos/{bin,pkg,src}
}

function deploy() {
  [ -f ~/.config/functions/fish_prompt.fish ] &&
    mv ~/.config/fish/functions/fish_prompt.fish ~/.config/fish/functions/fish_prompt.fish.old

  # deploy .files with stow
  stow --ignore ".DS_Store" -v -t ~/.config/fish -S fish
  stow --ignore ".DS_Store" -v -t ~/.config/nvim -S neovim
  stow --ignore ".DS_Store" -v -t ~/ -S git
  stow --ignore ".DS_Store" -v -t ~/ -S others
}

function clean() {
  # clean .files with stow
  stow --ignore ".DS_Store" -v -t ~/.config/fish -D fish
  stow --ignore ".DS_Store" -v -t ~/.config/nvim -D neovim
  stow --ignore ".DS_Store" -v -t ~/ -D git
  stow --ignore ".DS_Store" -v -t ~/ -D others
}

if [ "$1" = "init" ]; then
  init
elif [ "$1" = "deploy" ]; then
  deploy "$2"
elif [ "$1" = "clean" ]; then
  clean
fi
