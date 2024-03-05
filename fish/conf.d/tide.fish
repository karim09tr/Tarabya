# Set background colors for the Tide Git prompt
set -g tide_git_bg_color 268bd2 # Standard background color
set -g tide_git_bg_color_unstable C4A000 # Background color for unstable state
set -g tide_git_bg_color_urgent CC0000 # Background color for urgent state

# Set foreground colors for various Git states
set -g tide_git_branch_color 000000 # Color for the Git branch name
set -g tide_git_color_branch 000000 # Alternative color for the Git branch name
set -g tide_git_color_conflicted 000000 # Color for conflicted state
set -g tide_git_color_dirty 000000 # Color for dirty state (uncommitted changes)
set -g tide_git_color_operation 000000 # Color for Git operations (rebase, merge, etc.)
set -g tide_git_color_staged 000000 # Color for staged files
set -g tide_git_color_stash 000000 # Color for stashed changes
set -g tide_git_color_untracked 000000 # Color for untracked files
set -g tide_git_color_upstream 000000 # Color for upstream branch comparison

# Redundant settings for Git state colors, consider consolidating
set -g tide_git_conflicted_color 000000 # Color for conflicted state (redundant)
set -g tide_git_dirty_color 000000 # Color for dirty state (redundant)
set -g tide_git_operation_color 000000 # Color for Git operations (redundant)
set -g tide_git_staged_color 000000 # Color for staged files (redundant)
set -g tide_git_stash_color 000000 # Color for stash (redundant)
set -g tide_git_untracked_color 000000 # Color for untracked files (redundant)
set -g tide_git_upstream_color 000000 # Color for upstream branch comparison (redundant)

# Git segment icon
set -g tide_git_icon  # Icon for the Git branch

# Background color for the present working directory segment in Tide
set -g tide_pwd_bg_color 444444 # Background color for the PWD segment
