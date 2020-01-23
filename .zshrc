# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#################################################
#---------------- Variables --------------------#
#################################################

CLOUDPATH="$HOME/Library/Mobile Documents/com~apple~CloudDocs/dotfiles"
DEFAULT_USER=$USER
ZSH_THEME="powerlevel10k/powerlevel10k"

#################################################
#---------------- Exports ----------------------#
#################################################

# Path to your oh-my-zsh installation.
export ZSH=/Users/rockchalkwushock/.oh-my-zsh

# Make VS Code the default editor.
export EDITOR='code';

# Lazy loads nvm.
export NVM_LAZY_LOAD=true

#################################################
#---------------- Aliases ----------------------#
#################################################

alias clr="command clear"
alias globals="yarn global upgrade-interactive"
alias makeBrew="brew bundle dump --force"
alias rmf="command rm -rf"
alias zs="source ~/.zshrc"
alias gcm="git checkout master"

#################################################
#---------------- Functions --------------------#
#################################################

# copy2Cloud
# - sends directories & file(s) to dotfiles/ in iCloud
copy2Cloud() {
  if [ $# -eq 0 ]; then
    echo "Must provide a file or directory!";
    return 1;
  else
    # loop through # of args passed
    for i in "$@"
    do
      if [ -d $i ]; then
        cp -R "$i" "$CLOUDPATH";
        echo "$i copied to iCloud.";
      else
        cp "$i" "$CLOUDPATH";
        echo "$i copied to iCloud.";
      fi;
    done;
  fi;
}

#################################################
#----------------- Plugins ---------------------#
#################################################

# ZSH Completions
# https://github.com/zsh-users/zsh-completions
plugins=(zsh-completions)

# FROM: https://gist.github.com/ctechols/ca1035271ad134841284#gistcomment-2609770
# On slow systems, checking the cached .zcompdump file to see if it must be
# regenerated adds a noticable delay to zsh startup.  This little hack restricts
# it to once a day.
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

# ZSH Autosuggestions (as you type)
# Custom plugin (see oh-my-zsh/custom)
# See https://github.com/tarruda/zsh-autosuggestions
plugins+=(zsh-autosuggestions)

# Highlight terminal commands for correctness on-the-fly
# Custom plugin (see oh-my-zsh/custom)
# This mist be the last plugin sourced before initializing OMZSH.
plugins+=(zsh-syntax-highlighting)

# Adds nvm integration.
plugins+=(zsh-nvm)

#################################################
#----------------- Sourcing --------------------#
#################################################

source $ZSH/oh-my-zsh.sh

#################################################
#--------------- Style Prompt ------------------#
#################################################

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
