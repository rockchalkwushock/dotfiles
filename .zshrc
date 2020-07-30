# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#################################################
#---------------- Variables --------------------#
#################################################

APPOINTLET_DIR="$HOME/Desktop/Appointlet"
DOTFILES_DIR="$HOME/Desktop/dotfiles"
PERSONAL_DIR="$HOME/Desktop/Personal"
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

# Python 3
export PATH="/usr/local/opt/python@3.8/bin:$PATH"
#################################################
#---------------- Aliases ----------------------#
#################################################

alias clr="command clear"
alias globals="yarn global upgrade-interactive"
# Creates a Brewfile if not found, overwrites current if there is.
alias make_brewfile="brew bundle dump --force"
alias rmf="command rm -rf"
alias zs="source .zshrc"
alias gcm="git checkout master"
alias grm="git rebase master"
# Lists branches by date last worked in with relative dates.
alias branches="git for-each-ref --sort='-authordate:iso8601' --format=' %(authordate:relative)%09%(refname:short)' refs/heads"
# Should Postgres shit down it's leg this command will 99% of the time fix the prob.
alias recov_postgres="command rm ./usr/local/var/postgres/postmaster.pid"

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

# Function for jumping to work directories.
# Use: appointlet dashboard
appointlet() {
  if [ $1 = "" ]; then
    echo 'Must provide directory you want to jump too as first argument';
    return 1;
  else
    # Jump to directory.
    cd $APPOINTLET_DIR/$1;

    if [ "$1" = 'scheduler' ]; then
      # The scheduler uses a specific version of node.
      nvm use;
    else
      # Load current stable version node.
      nvm use stable;
    fi;
    return 0;
  fi;
}

# Function for jumping to dotfiles.
dotfiles() {
  cd $DOTFILES_DIR;
}

# Function for jumping to my personal projects.
# Use: me elixir_todos
me() {
  if [ $1 = "" ]; then
    echo 'Must provide directory you want to jump too as first argument';
    return 1;
  else
    # Jump to directory.
    cd $PERSONAL_DIR/$1;
    return 0;
  fi;
}

# Function for working on the v5 API.
v5() {
  if [ "$1" = "help" ]; then
    echo 'run-heroku     --- pipenv run heroku local';
    echo 'run-local      --- pipenv run ./manage.py runserver 5000';
    echo 'tunnel         --- ngrok http 5000 -subdomain=cody-appointlet';
    echo 'install        --- pipenv install';
    echo 'makemigrations --- pipenv run ./manage.py makemigrations';
    echo 'migrate        --- pipenv run ./manage.py migrate';
    echo 'token          --- pipenv run ./manage.py addstatictoken $1';
    echo 'static         --- pipenv run ./manage.py collectstatic';
    echo 'shell          --- pipenv run ./manage.py shell'
    return 0;
  else
    dir=$(pwd);
    if [ $dir = "$APPOINTLET_DIR/api" ]; then
      if [ "$1" = "run-heroku" ]; then
        pipenv run heroku local;
        return 0;
      elif [ "$1" = "run-local" ]; then
        pipenv run ./manage.py runserver 5000;
        return 0;
      elif [ "$1" = "tunnel" ]; then
        ngrok http 5000 -subdomain=cody-appointlet;
        return 0;
      elif [ "$1" = "install" ]; then
        pipenv install;
        return 0;
      elif [ "$1" = "makemigrations" ]; then
        pipenv run ./manage.py makemigrations;
        return 0;
      elif [ "$1" = "migrate" ]; then
        pipenv run ./manage.py migrate;
        return 0;
      elif [ "$1" = "token" ]; then
        # Need to handle missing variable here.
        pipenv run ./manage.py addstatictoken $2;
        return 0;
      elif [ "$1" = "static" ]; then
        pipenv run ./manage.py collectstatic;
        return 0;
      elif [ "$1" = "shell" ]; then
        pipenv run ./manage.py shell;
        return 0;
      fi;
    else
      echo "You are not in the v5 API directory!";
    fi;
  fi;
}

#################################################
#----------------- Plugins ---------------------#
#################################################

# ZSH Completions
# https://github.com/zsh-users/zsh-completions
plugins=(zsh-completions)

# ZSH Autosuggestions (as you type)
# Custom plugin (see oh-my-zsh/custom)
# See https://github.com/tarruda/zsh-autosuggestions
plugins+=(zsh-autosuggestions)

# Adds nvm integration.
plugins+=(zsh-nvm)

# Highlight terminal commands for correctness on-the-fly
# Custom plugin (see oh-my-zsh/custom)
# This mist be the last plugin sourced before initializing OMZSH.
plugins+=(zsh-syntax-highlighting)

# FROM: https://gist.github.com/ctechols/ca1035271ad134841284#gistcomment-2609770
# On slow systems, checking the cached .zcompdump file to see if it must be
# regenerated adds a noticable delay to zsh startup.  This little hack restricts
# it to once a day.
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

#################################################
#----------------- Sourcing --------------------#
#################################################

# Load oh-my-zsh.
source $ZSH/oh-my-zsh.sh

#################################################
#--------------- Style Prompt ------------------#
#################################################

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
