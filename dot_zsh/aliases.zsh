alias vi="nvim"

# Safe move and copy, avoids silent overwrite
alias cp="cp -i"
alias mv="mv -i"

alias ls="ls --color='auto'"
alias lsh="ls -d .*"

alias nicepath="print -l $path"

# Aliases related to package management
alias brokenpkg="dpkg --list | grep -v '^ii'"
