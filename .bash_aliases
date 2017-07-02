#!/usr/bin/env bash

###########################################
# THIS FILE CONTROLS THE SETTING OF ALIASES
# FOR EASIER NAVIGATION, LESS TYPING, ETC
# IN BASH.
###########################################

################
# Quick commands
################

alias ..="cd .."
alias ...="cd ../.."
alias ls="command ls -la"
alias clr="command clear"
alias rmf="command rm -rf"

#################################
# Running updates, cleaning, etc.
#################################

alias cleanup='brew cleanup; brew cask cleanup'                     # Maybe add `cache`????
alias globals="yarn global upgrade-interactive"
alias list='brew list; brew cask list; mas list'                    # If yarn global list becomes less ugly & faster then I will add it.
alias makeBrew="brew bundle dump --force"
alias outdated='brew outdated; brew cask outdated; mas outdated'
alias pkgUpdates='yarn upgrade-interactive'

# Currently there is no really good way to upgrade casks directly other than upgrading from the app.
# At the moment when `brew update` is ran it updates the taps, but if caskroom has not noticed the upgrade
# made to the cask it is not updated in the process.
# Check back with caskroom/homebrew-cask for more as they work on this.

alias update='brew update; brew upgrade; brew cleanup; brew cask cleanup; mas upgrade; sudo gem update --system; sudo gem update; sudo gem cleanup'

###############
# macOS Related
###############

alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
