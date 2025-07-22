#!/bin/bash

LAYOUT=$(cat ~/github/dotfiles/tmux/tmux/layouts/2x3/layout.txt)
tmux select-layout "$LAYOUT"
