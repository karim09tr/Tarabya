# Initializes Tide prompt setup
function _tide_init_install --on-event _tide_init_install
    # Disable virtual environment prompt changes
    set -U VIRTUAL_ENV_DISABLE_PROMPT true

    # Source the Tide configuration function and configure the prompt
    source (functions --details _tide_sub_configure)
    _load_config lean
    _tide_finish

    # Only proceed if the shell is interactive
    if status is-interactive
        # Check for Tide issues and wait before proceeding
        tide bug-report --check || sleep 4

        # Warn if the development branch of Tide is used
        if contains ilancosman/tide (string lower $_fisher_plugins)
            set_color bryellow
            echo "ilancosman/tide is a development branch. Please install from a release tag:"
            echo -ns "fisher install ilancosman/tide@v5" | fish_indent --ansi
            sleep 3
        end

        # Prompt the user to configure the Tide prompt upon installation
        switch (read --prompt-str="Configure tide prompt? [Y/n] " | string lower)
            case y ye yes ''
                tide configure
            case '*'
                echo -s \n 'Run ' (echo -ns "tide configure" | fish_indent --ansi) ' to customize your prompt.'
        end
    end
end

# Handles updates for the Tide prompt setup
function _tide_init_update --on-event _tide_init_update
    # Warns users who install from the main branch of Tide
    if contains ilancosman/tide (string lower $_fisher_plugins)
        set_color bryellow
        echo "ilancosman/tide is a development branch. Please install from a release tag:"
        echo -ns "fisher install ilancosman/tide@v5" | fish_indent --ansi
        sleep 3
    end
end

# Cleans up Tide configurations and functions upon uninstallation
function _tide_init_uninstall --on-event _tide_init_uninstall
    # Remove environment variable and Tide-related functions
    set -e VIRTUAL_ENV_DISABLE_PROMPT
    set -e (set -U --names | string match --entire -r '^_?tide')
    functions --erase (functions --all | string match --entire -r '^_?tide')
end
