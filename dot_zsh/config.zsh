# ZSH configuration file

HISTFILE=$ZDOTDIR/history
HISTSIZE=10000
SAVEHIST=10000

setopt PROMPT_SUBST
setopt COMPLETE_IN_WORD
setopt CORRECT

# Include more information about history
setopt EXTENDED_HISTORY
# Allow multiple terminal sessions to same history file.
setopt APPEND_HISTORY
# Add commands to history as they are typed.
setopt INC_APPEND_HISTORY
# Shares history across multiple zsh sessions.
setopt SHARE_HISTORY

setopt HIST_IGNORE_ALL_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY


# Misc Settings
setopt NO_BEEP
setopt MULTI_OS

# Make the shell act like vi if esc is pressed
setopt vi

# Protect existing files
setopt NO_CLOBBER

# Directory Navigation
setopt AUTO_CD

# Globbing
setopt NO_CASE_GLOB
setopt EXTENDED_GLOB
setopt NUMERIC_GLOB_SORT

# Autocomplete
setopt LIST_ROWS_FIRST
