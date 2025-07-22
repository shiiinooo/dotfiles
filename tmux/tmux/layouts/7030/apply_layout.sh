#!/bin/bash

LAYOUT=$(cat ~/github/dotfiles-latest/tmux/tmux/layouts/7030/layout.txt)
tmux select-layout "$LAYOUT"
