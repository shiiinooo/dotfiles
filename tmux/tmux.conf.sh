# Filename: ~/github/dotfiles-latest/tmux/tmux.conf.sh
# ~/github/dotfiles-latest/tmux/tmux.conf.sh

source "$HOME/github/dotfiles-latest/colorscheme/active/active-colorscheme.sh"

# #############################################################################
# Do not delete the `UNIQUE_ID` line below, I use it to backup original files
# so they're not lost when my symlinks are applied
# UNIQUE_ID=do_not_delete_this_line
# #############################################################################

# Tmux prefix key
set -g prefix C-b

# "xterm-256color" in alacritty and "screen-256color" in tmux doesnt have paste issues in neovim
# "checkhealth" command in neovim shows no color warnings
# set -g default-terminal "screen-256color"

# "xterm-256color" in alacritty and "xterm-256color" in tmux gives me truecolor
# warnings in neovim
# set -g default-terminal "xterm-256color"
# When using "alacritty" in alacritty and "tmux-256color" in tmux, I was having paste

# issues when I pasted over text highlighted in visual mode, spaces were removed
# at the end of the text. This happened in NEOVIM specifically
# "checkhealth" command in neovim shows no color warnings
# set -g default-terminal "tmux-256color"

# I was getting this warning in neovim
# Neither Tc nor RGB capability set. True colors are disabled
# Confirm your $TERM value outside of tmux first, mine returned "screen-256color"
# echo $TERM
# set-option -sa terminal-features ',xterm-256color:RGB'
set -sg terminal-overrides ",*:RGB"

# Undercurl support (works with kitty)
# Fix found below in Folke's tokyonight theme :heart:
# https://github.com/folke/tokyonight.nvim#fix-undercurls-in-tmux
#
# After reloading the configuration, you also have to kill the tmux session for
# these changes to take effect
set -g default-terminal "${TERM}"

# # undercurl support
# # I recently switched to Ghostty and I think this is not needed anymore
# set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'
# # underscore colours - needs tmux-3.0
# set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'

# https://github.com/3rd/image.nvim/?tab=readme-ov-file#tmux
# This is needed by the image.nvim plugin
set -gq allow-passthrough on
# This is related to the `tmux_show_only_in_active_window = true,` config in
# image.nvim
set -g visual-activity off

# When playing around with these, make sure you don't have them defined already
# in your tmux config file, you can also see that with
# tmux list-keys | grep -i 'C-l'
#
# https://github.com/tmux/tmux/wiki/Modifier-Keys#extended-keys
# When not running tmux I see what C-enter sends
# I can do `/bin/cat -v` and then pressed C-enter
# Ghostty sends: ^[[27;5;13~
# 
# The problem is that when I run tmux, nothing is sent, so I'm sending those
# keys here below
bind-key -n C-Enter send-keys "\e[27;5;13~"

# I want to send Ctrl+l to clear the screen, ghostty sends ^L
# This is not a good idea, as I use C-l to navigate to the right mux pane
# unbind-key -n C-l
# bind-key -n C-l send-keys C-l

# Alternate session
# Switch between the last 2 tmux sessions, similar to 'cd -' in the terminal
# I use this in combination with the `choose-tree` to sort sessions by time
# Otherwise, by default, sessions are sorted by name, and that makes no sense
# -l stands for `last session`, see `man tmux`
unbind Space
bind-key Space switch-client -l

# Switch between the last 3 sessions
# I use macOS karabiner-elements mapping the "down" arrow to a bettertouchtool
# keymap

# This enables vim nagivation
# If for example I'm in the scrolling mode (yellow) can navigate with vim motions
# search with /, using v for visual mode, etc
set -g mode-keys vi

bind-key "T" run-shell "sesh connect \"$(
  sesh list --icons | fzf-tmux -p 80%,70% \
    --no-sort --ansi --border-label ' sesh ' --prompt '⚡  ' \
    --header '  ^a all ^t tmux ^g configs ^x zoxide ^d tmux kill ^f find' \
    --bind 'tab:down,btab:up' \
    --bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list --icons)' \
    --bind 'ctrl-t:change-prompt(🪟  )+reload(sesh list -t --icons)' \
    --bind 'ctrl-g:change-prompt(⚙️  )+reload(sesh list -c --icons)' \
    --bind 'ctrl-x:change-prompt(📁  )+reload(sesh list -z --icons)' \
    --bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
    --bind 'ctrl-d:execute(tmux kill-session -t {2..})+change-prompt(⚡  )+reload(sesh list --icons)' \
    --preview-window 'right:55%' \
    --preview 'sesh preview {}'
)\""

# Border lines between panes are thicker
# single -> single lines using ACS or UTF-8 characters
# double -> double lines using UTF-8 characters
# heavy  -> heavy lines using UTF-8 characters
# simple -> simple ASCII characters
# number -> the pane number
set -g pane-border-lines double

# Indicate active pane by colouring only half of the border in windows with 
# exactly two panes, by displaying arrow markers, by drawing both or neither.
# [off | colour | arrows | both]
set -g pane-border-indicators both

# Enables tracking of focus events, allows tmux to respond when the terminal
# window gains or looses focus
set-option -g focus-events on

# # Change color of focused and unfocused panes, it helps me easily identify where
# # my cursor is
# # Make sure these colors also match your neovim autocmd if you change them
# set-hook -g pane-focus-in 'select-pane -P "bg=$linkarzu_color10,fg=white"'
# set-hook -g pane-focus-out 'select-pane -P "bg=$linkarzu_color07,fg=default"'

# When pressing prefix+s to list sessions, I want them sorted by time
# That way my latest used sessions show at the top of the list
# -s starts with sessions collapsed (doesn't show windows)
# -Z zooms the pane (don't uderstand what this does)
# -O specifies the initial sort field: one of ‘index’, ‘name’, or ‘time’ (activity).
# https://unix.stackexchange.com/questions/608268/how-can-i-force-tmux-to-sort-my-sessions-alphabetically
#
# bind s choose-tree -Zs -O time
# bind s choose-tree -Zs -O time -y
bind s choose-tree -Zs -O time -F "#{session_windows}"
# -y at the end is a feature I requested so that the session is closed without confirmation
# https://github.com/tmux/tmux/issues/4152
# bind s choose-tree -Zs -O time -F "#{session_windows}" -y
# bind s choose-tree -Zs -O time -F "#{?session_attached,#[fg=$linkarzu_color02],#[fg=$linkarzu_color03]}#{session_name}#[default]" -y
# bind s choose-tree -Zs -O time -F "#{?session_attached,#[fg=$linkarzu_color02],#[fg=$linkarzu_color03]}" -y

# # Bind 'd' to perform the 'x' action when in choose-tree mode
# # In other words, this allows you to close sessions with "d" when in the session
# # navigator "choose-tree" that comes up with prefix+s
bind -n d if -F '#{==:#{pane_mode},tree-mode}' 'send x' 'send d'

# Use 'd' instead of 't' to tag panes that I want to delete
# bind -n d if -F '#{==:#{pane_mode},tree-mode}' 'send t' 'send d'

# Use 'D' instead of 'X' to delete all tagged panes
bind -n D if -F '#{==:#{pane_mode},tree-mode}' 'send X' 'send D'

# Search sessions using an fzf menu
# Found this gem down here:
# https://github.com/majjoha/dotfiles/blob/cd6f966d359e16b3a7c149f96d4edb8a83e769db/.config/tmux/tmux.conf#L41
bind M-s display-popup -E -w 75% -h 75% "\
  tmux list-sessions -F '#{?session_attached,,#{session_name}}' |\
  sed '/^$/d' |\
  fzf --reverse --header jump-to-session --preview 'tmux capture-pane -pt {}'  |\
  xargs tmux switch-client -t"

# fzf menu to kill sessions
# Credit: video below by Waylon Walker
# https://www.youtube.com/watch?v=QWPyYx54JbE
bind M-S display-popup -E "\
    tmux list-sessions -F '#{?session_attached,,#{session_name}}' |\
    fzf --reverse -m --header=kill-session |\
    xargs -I {} tmux kill-session -t {}"

# Create vertical split
unbind '|'
bind '|' split-window -h

# Create horizontal split
unbind '-'
bind - split-window -v

# how to navigate across the different panes in a window
# Notice I'm using vim motions
#
# I don't use these, I use the christoomey/vim-tmux-navigator to navigate
# between panes using ctrl
# bind h select-pane -L
# bind j select-pane -D
# bind k select-pane -U
# bind l select-pane -R

# Switch to windows 1 through 4
# 'p' is normally used to go to the previous window, but I won't use it
# ctrl+b c -> new window
# ctrl+b , -> rename current window
# ctrl+b w -> show list of windows and sessions
unbind p
bind u select-window -t 1
bind i select-window -t 2
bind o select-window -t 3
bind p select-window -t 4

# Switch to sessions 1 through 4
# ctrl+b : -> new -s 0 -> new session with name '0'
# ctrl+b $ -> rename current session
# ctrl+b s -> show list of sessions
# bind 7 switch-client -t 1
# bind 8 switch-client -t 2
# bind 9 switch-client -t 3
# bind 0 switch-client -t 4

# If you want to use the default meta key, which is 'option' in macos, you have to
# configure the alacritty 'option_as_alt' option, but that messed up my hyper key,
# so if I enable that option in alacritty, I cant do hyper+b which is what I use for
# tmux commands instead of ctrl+b. So instead, I'll just remap these
unbind J
unbind K
# unbind L
unbind C-j
unbind C-k
# unbind C-l
bind J select-layout even-horizontal
bind K select-layout even-vertical
# bind L select-layout tiled
# bind L run-shell ~/github/dotfiles-latest/tmux/layouts/7030/apply_layout.sh
bind C-j select-layout main-horizontal
bind C-k select-layout main-vertical
# bind C-l run-shell ~/github/dotfiles-latest/tmux/layouts/2x3/apply_layout.sh

# Update: In karabiner elements I remapped hyper+f to ctrl+b which allows me to
# now use the meta key, just make sure to configure option as alt in your
# terminal if using macos, I configured it only for the right option key, as I
# use the left option key for unicode input sequences
# These require Ctrl-b first, then Alt+key
bind M-j select-layout even-horizontal
bind M-k select-layout even-vertical
bind M-l run-shell ~/github/dotfiles-latest/tmux/layouts/7030/apply_layout.sh
# You can also use uppercase characters with alt, this is Alt+shift+key
bind M-J select-layout main-horizontal 
bind M-K select-layout main-vertical
bind M-L run-shell ~/github/dotfiles-latest/tmux/layouts/2x3/apply_layout.sh

###############################################################################
# ThePrimeagen's tmux-sessionizer script, got 'em
###############################################################################

# ThePrimeagen's tmux-sessionizer script, got 'em
# I don't really care what these mappings are, pressing ctrl+* doesn't make any
# sense whatsoever, because it's not ergonomic, but I call them from
# bettertouchtool, and BTT is called from karabiner-elements

tmux_sessionizer="~/github/dotfiles-latest/tmux/tools/prime/tmux-sessionizer.sh"
tmux_sshonizer_agen="~/github/dotfiles-latest/tmux/tools/linkarzu/tmux-sshonizer-agen.sh"
ssh_select="~/github/dotfiles-latest/tmux/tools/linkarzu/ssh-select.sh"
# Script below goes through you `~/.ssh/config` file and shows the hosts in an fzf menu
ssh_config_select="~/github/dotfiles-latest/tmux/tools/linkarzu/ssh_config_select.sh"
daily_note="~/github/dotfiles-latest/scripts/macos/mac/misc/300-dailyNote.sh"

# I tend to forget my karabiner mappings, so this opens the file in a new tmux
# session
karabiner_rules="~/github/scripts/macos/mac/301-openKarabinerRules.sh"

colorscheme_selector="~/github/dotfiles-latest/colorscheme/colorscheme-selector.sh"
script_selector="~/github/dotfiles-latest/scripts/macos/mac/misc/240-systemTask.sh"

# Don't use C-r because it's used by tmux-resurrect
# Don't use C-e because I'm already using it for sending command to all panes/windows in current session
# Don't use C-s because Its used to save the session
# Don't use C-z, not sure what its for
unbind C-u
bind-key -r C-u run-shell "$tmux_sessionizer ~/github/dotfiles-latest"
unbind C-i
bind-key -r C-i run-shell "$tmux_sessionizer ~/github/watusy"
unbind C-o
# bind-key -r C-o run-shell "$tmux_sessionizer ~/github/linkarzu.github.io"
bind-key -r C-o run-shell "$tmux_sessionizer /System/Volumes/Data/mnt/github_nfs/linkarzu.github.io"
unbind C-p
bind-key -r C-p run-shell "$tmux_sessionizer ~/github/scripts"
unbind C-t
bind-key -r C-t run-shell "$tmux_sessionizer ~/github/obsidian_main"
unbind 4
bind-key -r 4 run-shell "$tmux_sessionizer ~/github/containerdata"
unbind C-y
bind-key -r C-y run-shell "$tmux_sessionizer /System/Volumes/Data/mnt/containerdata_nfs"
unbind C-h
bind-key -r C-h run-shell "$tmux_sessionizer ~"
unbind C-m
bind-key -r C-m run-shell "$tmux_sessionizer ~/github/containerdata-public"
unbind 3
bind-key -r 3 run-shell "$tmux_sessionizer ~/github/go"
# Leaving this in quotes because iCloud dir has a white space
unbind C-g
bind-key -r C-g run-shell "$tmux_sessionizer ~/github/php"
# bind-key -r C-g run-shell "$tmux_sessionizer '$HOME/Library/Mobile Documents/com~apple~CloudDocs/github/macos-setup'"

unbind C-w
bind-key -r C-w run-shell "$tmux_sshonizer_agen docker3"
unbind C-q
bind-key -r C-q run-shell "$tmux_sshonizer_agen prodkubecp3"
unbind C-a
bind-key -r C-a run-shell "$tmux_sshonizer_agen dns3"
unbind C-d
bind-key -r C-d run-shell "$tmux_sshonizer_agen lb3"
unbind C-f
bind-key -r C-f run-shell "$tmux_sshonizer_agen prodkubew3"
unbind C-x
bind-key -r C-x run-shell "$tmux_sshonizer_agen storage3"
unbind C-c
bind-key -r C-c run-shell "$tmux_sshonizer_agen xocli3"

unbind f
bind-key -r f run-shell "tmux neww $tmux_sessionizer"
unbind 5
# Notice I'm passing 2 arguments, it's going to fzf inside that 2nd argument
bind-key -r 5 run-shell "tmux neww $tmux_sessionizer irrelevant-arg ~/github/goto"
unbind C-v
bind-key -r C-v run-shell "tmux neww $ssh_select"
unbind C-n
bind-key -r C-n run-shell "tmux neww $ssh_config_select"
unbind 1
bind-key -r 1 run-shell "tmux neww $daily_note"
unbind 2
bind-key -r 2 run-shell "tmux neww $karabiner_rules"
unbind 6
bind-key -r 6 run-shell "tmux neww $colorscheme_selector"
unbind 7
bind-key -r 7 run-shell "tmux neww $script_selector"
unbind 8
bind-key -r 8 run-shell "$tmux_sessionizer ~/github/dotfiles-private"

###############################################################################

# Reload the tmux configuration, display a 2 second message
unbind r
bind r source-file ~/.tmux.conf
# bind r source-file ~/.tmux.conf \; display-message -d 2000 "Configuration reloaded!"

# Bind pane synchronization to Ctrl-b s
unbind Q
bind Q setw synchronize-panes

# Go to previous window, I'm using 'p' to change to window 4
unbind m
bind m previous-window

# Resize pane to zoom so it occupies the entire screen
unbind M
bind -r M resize-pane -Z

# The number at the end specifies number of cells
# Increase or decrease to your liking
bind -r Left resize-pane -L 1
bind -r Down resize-pane -D 1
bind -r Up resize-pane -U 1
bind -r Right resize-pane -R 1

# Change the keybinding to enter copy mode from 'prefix + [' to 'prefix + v'
unbind v
bind v copy-mode

# Bind Esc to exit copy-mode
bind-key -T copy-mode-vi 'Escape' send -X cancel

# start selecting text with "v", this is visual mode
bind-key -T copy-mode-vi 'v' send -X begin-selection
# copy text with "y"
bind-key -T copy-mode-vi 'y' send -X copy-selection

# Thi is what allows me to press gh and gl to to to the beginning and end of
# line respectively when in copy-mode (visual mode)
# Unbind the default 'g' key in copy-mode-vi
unbind -T copy-mode-vi g
# Define a custom key table for extended copy-mode bindings
bind-key -T copy-mode-vi 'g' switch-client -T copy-mode-extended
# Bind 'h' in the extended copy-mode to go to the beginning of the line
bind-key -T copy-mode-extended 'h' send -X start-of-line \; switch-client -T copy-mode-vi
# Bind 'l' in the extended copy-mode to go to the end of the line
bind-key -T copy-mode-extended 'l' send -X end-of-line \; switch-client -T copy-mode-vi

# Nope, disabled this as I use them for telescope buffers and snipe
# bind-key -T copy-mode-vi 'H' send -X start-of-line
# bind-key -T copy-mode-vi 'L' send -X end-of-line

# don't exit copy mode when dragging with mouse
unbind -T copy-mode-vi MouseDragEnd1Pane

# Bind Alt-t <M-t> in copy-mode
# This allows me to toggle my neovim terminal even if I'm in tmux copy-mode
bind-key -T copy-mode M-t run-shell "~/github/dotfiles-latest/tmux/tools/linkarzu/simple_toggle.sh"
bind-key -T copy-mode-vi M-t run-shell "~/github/dotfiles-latest/tmux/tools/linkarzu/simple_toggle.sh"

# https://github.com/leelavg/dotfiles/blob/897aa883a/config/tmux.conf#L30-L39
# https://scripter.co/command-to-every-pane-window-session-in-tmux/
# Send the same command to all panes/windows in current session
bind M-e command-prompt -p "Command:" \
  "run \"tmux list-panes -s -F '##{session_name}:##{window_index}.##{pane_index}' \
                | xargs -I PANE tmux send-keys -t PANE '%1' Enter\""

# Send the same command to all panes/windows/sessions
bind M-E command-prompt -p "Command:" \
  "run \"tmux list-panes -a -F '##{session_name}:##{window_index}.##{pane_index}' \
              | xargs -I PANE tmux send-keys -t PANE '%1' Enter\""

# Increase scroll history
set-option -g history-limit 10000

# New windows normally start at 0, but I want them to start at 1 instead
set -g base-index 1

# With this set to off
# when you close the last window in a session, tmux will keep the session
# alive, even though it has no windows open. You won't be detached from
# tmux, and you'll remain in the session
set -g detach-on-destroy off

# Imagine if you have windows 1-5, and you close window 3, you are left with
# 1,2,4,5, which is inconvenient for my navigation method seen below
# renumbering solves that issue, so if you close 3 youre left with 1-4
set -g renumber-windows on

# There's no plugin to renumber sessions, but just do
# : new -s 4
# And that will give the new session the desired number

# Swap the pane with the next pane to the right
# Instead of this use `{` and `}` that are defaults
# bind S swap-pane -D

# Enable mouse support to resize panes, scrolling, etc
set -g mouse on

# I had to set this to on for osc52 to work
# https://github.com/ojroques/nvim-osc52
set -s set-clipboard on

# If I'm in insert mode typing text, and press escape, it will wait this amount
# of time to switch to normal mode when I press escape
# this setting was recommended by neovim `escape-time` (default 500)
# Can be set to a lower value, like 10 for it to be faster
set-option -sg escape-time 100

# I just realized that my eyes are normally on the top left corner on the
# screen, so moving the tmux bar to the top instead of bottom
set -g status-position top
# set -g status-position bottom

##############################################################################
##############################################################################

# Plugins section
# Plugin installation and uninstallation is done through TPM
# To install:
  # First add plugin below
  # Then press prefix shift+i (uppercase, as in Install)
# To uninstall:
  # First comment plugin below
  # Then press prefix alt+u (lowercase, as in uninstall)
  # Then run an update to see the list of installed plugins
  # gx the `~/.tmux/plugins/tmux` path and plugin should not be there
# To update:
  # prefix shift+u (uppercase)
  # type `all` hen hit enter

##############################################################################
##############################################################################

# Tmux Plugin Manager (tpm), to install it, clone the repo below
# git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
set -g @plugin 'tmux-plugins/tpm'

##############################################################################
# Themes section, only enable 1

# >>>>>>>>>>>>>>>>>>>>>>>> VERY IMPORTANT NOTE <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
# To change the theme, delete the `~/.tmux/plugins/tmux` dir first
# rm -rf ~/.tmux/plugins/tmux
# Enable the desired theme in this tmux.conf file, just enable 1
# Then install plugins ctrl+b shift+i
# - If you don't follow these steps, the old theme won't be replaced by the new
# one
##############################################################################

# Dracula theme
# https://draculatheme.com/tmux
# available plugins: battery, cpu-usage, git, gpu-usage, ram-usage,
# tmux-ram-usage, network, network-bandwidth, network-ping, attached-clients,
# network-vpn, weather, time, spotify-tui, kubernetes-context, synchronize-panes

# set -g @plugin 'dracula/tmux'
# set -g @dracula-plugins "synchronize-panes git time network-ping tmux-ram-usage"
# set -g @dracula-synchronize-panes-label "Sync:"
# # available colors: white, gray, dark_gray, light_purple, dark_purple, cyan, green, orange, red, pink, yellow
# set -g @dracula-synchronize-panes-colors "orange gray"
# set -g @dracula-show-powerline true
# set -g @dracula-show-left-icon session
# set -g @dracula-tmux-ram-usage-label "tmuxRam:"
# set -g @dracula-tmux-ram-usage-colors "dark_purple white"
# set -g @dracula-border-contrast true

# ----------------------------------------------------------------------------

# Catppuccin theme
# https://github.com/catppuccin/tmux
# Cons:
# - Doesn't have a sync panes like dracula
#   - Actually I was able to implement this, see below
# Pros:
# - I feel my terminal waaaaay smoother/faster, not completely sure about this
#   But could be due to all the refreshing and polling of data Dracula had to do

# I pinned to 0.3.0 beacuse a new version had breaking changes and my tmux bar
# looked like crap, spent hours trying to figure it out
set -g @plugin 'catppuccin/tmux#v0.3.0'
# set -g @plugin 'catppuccin/tmux#latest'
# or frappe, macchiato, mocha
set -g @catppuccin_flavor 'mocha'

run-shell "~/github/dotfiles-latest/tmux/tools/linkarzu/set_tmux_colors.sh"

set -g @catppuccin_window_left_separator ""
set -g @catppuccin_window_right_separator " "
set -g @catppuccin_window_middle_separator " █"
set -g @catppuccin_window_number_position "right"
set -g @catppuccin_status_modules_left "session"

# # set -g @catppuccin_status_modules_right "none"
# set -g @catppuccin_status_modules_right "directory"
# set -g @catppuccin_directory_text " linkarzu   If you like the video like it  , and remember to subscribe   "
# set -g @catppuccin_directory_color "#04d1f9"
# set -g @catppuccin_directory_icon "null"

# As 'man tmux' specifies:
# Execute the first command if shell-command (run with /bin/sh) returns success or the second command otherwise
if-shell 'test -f ~/github/dotfiles-latest/youtube-banner.txt' {
    set -g @catppuccin_status_modules_right "directory"
    set -g @catppuccin_directory_text " linkarzu   like   subscribe   "
    set -g @catppuccin_directory_icon "null"
} {
    set -g @catppuccin_status_modules_right "null"
}

# `user` and `host` are kind of useless, dont change when you ssh to devices
# set -g @catppuccin_status_modules_right "directory user host"
set -g @catppuccin_status_left_separator " "
set -g @catppuccin_status_right_separator ""
set -g @catppuccin_status_right_separator_inverse "no"
set -g @catppuccin_status_connect_separator "no"

# set -g @catppuccin_directory_text "#{pane_current_path}"

# This can be set to "icon" or "all" if set to "all" the entire tmux session
# name has color
# set -g @catppuccin_status_fill "icon"
set -g @catppuccin_status_fill "all"

# If you set this to off, the tmux line completely dissappears
set -g @catppuccin_status_default "on"

# ----------------------------------------------------------------------------

# Powerline theme
# https://github.com/jimeh/tmux-themepack
# set -g @plugin 'jimeh/tmux-themepack'
# set -g @themepack 'powerline/default/cyan'

##############################################################################
# Other plugins
##############################################################################

# list of tmux plugins

# for navigating between tmux panes using Ctrl-hjkl
# If you have neovim open in a tmux pane, and another tmux pane on the right,
# you won't be able to jump from neovim to the tmux pane on the right.
#
# If you want to do jump between neovim and tmux, you need to install the same
# 'vim-tmux-navigator' plugin inside neovim
set -g @plugin 'christoomey/vim-tmux-navigator'

# # persist tmux sessions after computer restart
# # https://github.com/tmux-plugins/tmux-resurrect
# set -g @plugin 'tmux-plugins/tmux-resurrect'
# # allow tmux-ressurect to capture pane contents
# set -g @resurrect-capture-pane-contents 'on'

# # automatically saves sessions for you every 15 minutes (this must be the last plugin)
# # https://github.com/tmux-plugins/tmux-continuum
# set -g @plugin 'tmux-plugins/tmux-continuum'
# # enable tmux-continuum functionality
# set -g @continuum-restore 'on'
# # Set the save interval in minutes, default is 15
# set -g @continuum-save-interval '5'

# Initialize TMUX plugin manager
# (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'
