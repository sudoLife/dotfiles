export EDITOR=emacsclient
alias E="SUDO_EDITOR=\"emacsclient\" sudo -e"
alias mirror="sudo reflector --protocol https --latest 50 --number 20 --sort rate --save /etc/pacman.d/mirrorlist"

export _JAVA_AWT_WM_NONREPARENTING=1

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
