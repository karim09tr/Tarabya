# Disable the default fish greeting message
set fish_greeting ""

# Ensure terminal supports 256 colors
set -gx TERM xterm-256color

# Theme customization settings
set -g theme_color_scheme terminal-dark # Set color scheme
set -g fish_prompt_pwd_dir_length 1 # Customize the prompt directory display length
set -g theme_display_user yes # Display the user in the prompt
set -g theme_hide_hostname no # Do not hide the hostname in the prompt
set -g theme_hostname always # Always display the hostname

# Define aliases for commonly used commands
alias ls "ls -p -G" # Colorized listing
alias la "ls -A" # List all except . and ..
alias ll "ls -l" # Long format listing
alias lla "ll -A" # Long format listing, including hidden files
alias g git # Shortcut for git
command -qv nvim && alias vim nvim # Use nvim for vim if nvim is available

# Set the default editor
set -gx EDITOR nvim

# Extend the PATH variable to include common directories
set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH

# NodeJS setup: prioritize local node modules
set -gx PATH node_modules/.bin $PATH

# Go language setup: define GOPATH and extend PATH to include Go binaries
set -g GOPATH $HOME/go
set -gx PATH $GOPATH/bin $PATH

# NVM (Node Version Manager) integration: automatically use .nvmrc if present
function __check_rvm --on-variable PWD --description 'Do nvm stuff'
    status --is-command-substitution; and return # Exit if in a command substitution to prevent recursion

    if test -f .nvmrc; and test -r .nvmrc
        # Check for readable .nvmrc file
        nvm use # Use version specified in .nvmrc
    end
end

# Platform-specific configuration: source additional config files based on the operating system
switch (uname)
    case Darwin
        source (dirname (status --current-filename))/config-osx.fish
    case Linux
        source (dirname (status --current-filename))/config-linux.fish
    case '*'
        source (dirname (status --current-filename))/config-windows.fish
end

# Load local configuration file if it exists
set LOCAL_CONFIG (dirname (status --current-filename))/config-local.fish
if test -f $LOCAL_CONFIG
    source $LOCAL_CONFIG
end
