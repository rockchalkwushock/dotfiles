#!/usr/bin/env bash

###########################################
# THIS FILE CONTROLS THE SETTING OF ALIASES
# FOR EASIER NAVIGATION, LESS TYPING, ETC
# IN BASH.
###########################################

alias ..="cd .."
alias ...="cd ../.."
alias ~="cd ~"
alias D="cd Desktop"
alias ls="command ls -la"
alias clr="command clear"
alias rmf="command rm -rf"
alias update='brew update; brew upgrade; brew cleanup; sudo gem update --system; sudo gem update; sudo gem cleanup'
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
