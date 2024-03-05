# Disables file completion for the tide command
complete tide --no-files

# Defines a local variable listing known subcommands for tide
set -l subcommands bug-report configure

# Specifies completions for the 'bug-report' and 'configure' subcommands of tide,
# each with a descriptive text to inform the user of the subcommand's purpose
complete tide -x -n __fish_use_subcommand -a bug-report -d "Print info for use in bug reports"
complete tide -x -n __fish_use_subcommand -a configure -d "Run the configuration wizard"

# Adds completions for the help and version options,
# ensuring they are only suggested if no subcommand from the listed ones has been used
complete tide -x -n "not __fish_seen_subcommand_from $subcommands" -s h -l help -d "Print help message"
complete tide -x -n "not __fish_seen_subcommand_from $subcommands" -s v -l version -d "Print tide version"

# For the 'bug-report' subcommand, defines completions for the '--clean' and '--verbose' flags,
# each with a description to explain the flag's effect when used with 'bug-report'
complete tide -x -n '__fish_seen_subcommand_from bug-report' -l clean -d "Run clean Fish instance and install Tide"
complete tide -x -n '__fish_seen_subcommand_from bug-report' -l verbose -d "Print full Tide configuration"
