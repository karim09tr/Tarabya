# Check if Z_DATA environment variable is not set
if test -z "$Z_DATA"
    # Determine Z_DATA_DIR based on whether XDG_DATA_HOME is set
    if test -z "$XDG_DATA_HOME"
        # Use a default location under the home directory if XDG_DATA_HOME is not set
        set -U Z_DATA_DIR "$HOME/.local/share/z"
    else
        # Use XDG_DATA_HOME for storing data if it's set
        set -U Z_DATA_DIR "$XDG_DATA_HOME/z"
    end
    # Define Z_DATA as the file path within Z_DATA_DIR
    set -U Z_DATA "$Z_DATA_DIR/data"
end

# Create Z_DATA file if it does not exist
if test ! -e "$Z_DATA"
    # Ensure the Z_DATA_DIR directory exists
    if test ! -e "$Z_DATA_DIR"
        mkdir -p -m 700 "$Z_DATA_DIR"
    end
    # Create the Z_DATA file
    touch "$Z_DATA"
end

# Set the Z_CMD variable to 'z' if not already defined
if test -z "$Z_CMD"
    set -U Z_CMD z
end

# Set ZO_CMD as an extended command for Z_CMD with 'o' appended
set -U ZO_CMD "$Z_CMD"o

# Define the z function if Z_CMD is set
if test ! -z $Z_CMD
    function $Z_CMD -d "jump around"
        __z $argv # Invoke __z function, passing all arguments
    end
end

# Define the z opening function if ZO_CMD is set
if test ! -z $ZO_CMD
    function $ZO_CMD -d "open target dir"
        __z -d $argv # Invoke __z with -d flag to directly open the directory
    end
end

# Exclude directories from z's tracking, setting default exclusion if not already defined
if not set -q Z_EXCLUDE
    set -U Z_EXCLUDE "^$HOME\$"
else if contains $HOME $Z_EXCLUDE
    # Migrate old default values to a regex
    set Z_EXCLUDE (string replace -r -- "^$HOME\$" '^'$HOME'$$' $Z_EXCLUDE)
end

# Set up completions for z command
__z_complete

# Function to add the current directory to z's tracking on PWD change
function __z_on_variable_pwd --on-variable PWD
    __z_add
end

# Uninstallation function for the z integration
function __z_uninstall --on-event z_uninstall
    # Erase the functions set by this configuration
    functions -e __z_on_variable_pwd
    functions -e $Z_CMD
    functions -e $ZO_CMD

    # Prompt user to manually remove data file if Z_DATA is set
    if test ! -z "$Z_DATA"
        printf "To completely erase z's data, remove:\n" >/dev/stderr
        printf "%s\n" "$Z_DATA" >/dev/stderr
    end

    # Unset environment variables used by z
    set -e Z_CMD
    set -e ZO_CMD
    set -e Z_DATA
    set -e Z_EXCLUDE
end
