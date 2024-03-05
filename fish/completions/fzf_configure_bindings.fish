# Disables file path completion for fzf_configure_bindings command
complete fzf_configure_bindings --no-files

# Adds a completion for the help option, providing a description and ensuring it's only suggested if not already used
complete fzf_configure_bindings --long help --short h --description "Print help" --condition "not __fish_seen_argument --help -h"

# Adds completions for changing key bindings associated with different fzf search functionalities,
# each with a description and condition to ensure the suggestion is relevant based on previously typed arguments

# For changing the key binding for searching directories
complete fzf_configure_bindings --long directory --description "Change the key binding for Search Directory" --condition "not __fish_seen_argument --directory"

# For changing the key binding for searching Git logs
complete fzf_configure_bindings --long git_log --description "Change the key binding for Search Git Log" --condition "not __fish_seen_argument --git_log"

# For changing the key binding for searching Git status
complete fzf_configure_bindings --long git_status --description "Change the key binding for Search Git Status" --condition "not __fish_seen_argument --git_status"

# For changing the key binding for searching command history
complete fzf_configure_bindings --long history --description "Change the key binding for Search History" --condition "not __fish_seen_argument --history"

# For changing the key binding for searching running processes
complete fzf_configure_bindings --long processes --description "Change the key binding for Search Processes" --condition "not __fish_seen_argument --processes"

# For changing the key binding for searching shell variables
complete fzf_configure_bindings --long variables --description "Change the key binding for Search Variables" --condition "not __fish_seen_argument --variables"
