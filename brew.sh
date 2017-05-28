#!/usr/bin/env bash

###########################################################
# THIS FILE CONTROLS THE 'USER DEFINED' INSTALLATION OF
# HOMEBREW PACKAGES.
# NOTE: MUST INSTALL HOMEBREW PRIOR TO RUNNING THIS SCRIPT!
# /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
###########################################################

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install formulae
# TODO: Add the formulae you want to have installed.
brew install bash-completion
brew install cabextract
brew install git
brew install mongodb
brew install node
brew install postgresql
brew install ruby
brew install watchman
brew install yarn

# Install casks
# TODO: Add the casks you want to have installed.
brew cask install alfred
brew cask install boostnote
brew cask install ccmenu
brew cask install devdocs
brew cask install discord
brew cask install docker
brew cask install expo-xde
brew cask install kap
brew cask install postman
brew cask install robomongo
brew cask install screenhero
brew cask install screenflow
brew cask install sketch
brew cask install spotify

# Remove outdated versions from the cellar.
brew cleanup
brew cask cleanup

