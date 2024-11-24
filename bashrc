bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

export HISTCONTROL=ignoredups
shopt -s autocd
source $(blesh-share)/ble.sh
