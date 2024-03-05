# Check if the shell is not in interactive mode and not running in CI
# Skip fzf.fish configuration to speed up shell startup in such cases
if not status is-interactive && test "$CI" != true
    exit
end

# Due to scoping rules, to accurately capture shell variables, read them before executing _fzf_search_variables.
# Use psub to store variable info in temporary files, passing filenames as arguments.
# This variable is global to allow reference in fzf_configure_bindings and tests
set --global _fzf_search_vars_command '_fzf_search_variables (set --show | psub) (set --names | psub)'

# Install default fzf bindings, designed to be mnemonic and minimally conflict with Fish's preset bindings
fzf_configure_bindings

# Function to clean up fzf configurations upon uninstallation, triggered by the fzf_uninstall event
function _fzf_uninstall --on-event fzf_uninstall
    # Uninstall fzf bindings
    _fzf_uninstall_bindings

    # Erase global variable and related functions to clean up
    set --erase _fzf_search_vars_command
    functions --erase _fzf_uninstall _fzf_migration_message _fzf_uninstall_bindings fzf_configure_bindings
    complete --erase fzf_configure_bindings

    # Notify user of uninstallation completion and any manual steps if needed
    set_color cyan
    echo "fzf.fish uninstalled."
    echo "You may need to manually remove fzf_configure_bindings from your config.fish if you were using custom key bindings."
    set_color normal
end
