# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi;

###############################################
#-----------------Variables-------------------#
###############################################

# Homebrew is not being installed in the default manner.
# https://github.com/Homebrew/brew/blob/master/docs/Installation.md#alternative-installs
BREW_LOCAL_DIR="$HOME/homebrew";
DEFAULT_USER=$USER;
ICLOUD_PATH="$HOME/Library/Mobile Documents/com~apple~CloudDocs/dotfiles";
PROJECTS_DIR="$HOME/Desktop/Projects";
# https://github.com/ohmyzsh/ohmyzsh/issues/6835#issuecomment-390216875
ZSH_DISABLE_COMPFIX=true;
ZSH_THEME="powerlevel10k/powerlevel10k";

###############################################
#------------------Exports--------------------#
###############################################

# Make VSCode the default editor.
export EDITOR='code';

# Homebrew
export HOMEBREW_CASK_OPTS="--appdir=~/Applications --fontdir=/Library/Fonts --require-sha";
export HOMEBREW_NO_ANALYTICS=true;
export HOMEBREW_NO_INSTALL_UPGRADE=true;

# n-install - This will be added at install time of n-install, leaving it will cause problems.
# export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin";

# Append the local Homebrew path to $PATH.
export PATH="$BREW_LOCAL_DIR/sbin:$BREW_LOCAL_DIR/bin:$PATH";

# Path to oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh";

###############################################
#------------------Aliases--------------------#
###############################################

# Elixir/Phoenix aliases
alias phx_version="mix phx.new --version";

# Git related aliases

alias branches="git for-each-ref --sort='-authordate:iso8601' --format=' %(authordate:relative)%09%(refname:short)' refs/heads";
alias gr="git rebase";
alias gs="git stash";
alias pull="git pull";
alias push="git push";
alias unwip="git reset HEAD~";
alias wip="git commit -a -m 'WIP' --no-verify";

# Homebrew related aliases

alias cleanup="brew cleanup";
alias make_brewfile="brew bundle dump --force";
alias outdated="brew outdated";
alias services="brew services list";
alias update="brew update";
alias upgrade="brew upgrade";

# System related aliases

alias clr="command clear";
alias flushdns="sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder";
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app';
alias recov_postgres="command rm ./usr/local/var/postgres/postmaster.pid";
alias rmf="rm -rf";
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app';
alias zs="source .zshrc";

# Yarn related aliases
# These have been updated to alias the use of pnpm NOT Yarn
# and to not mess with my own mental modal I am keeping the
# aliases the same where they can be

alias ya="pnpm add";
alias yb="pnpm run build";
alias yc="pnpm run commit";
alias yd="pnpm run dev";
alias yga="pnpm add -g";
alias ygl="pnpm ls -g";
alias ygr="pnpm rm -g";
alias ygu="pnpm up -g -i";
alias yi="pnpm i";
alias yl="pnpm run lint";
alias yr="pnpm rm";
alias ys="pnpm start";
alias yt="pnpm t";
alias ytc="pnpm run type-check";
alias yu="pnpm up -i";

###############################################
#-----------------Functions-------------------#
###############################################

# copy_to_icloud
# - sends directories & files to dotfiles directory in iCloud.
copy_to_icloud() {
    if [ $# -eq 0 ]; then
        echo "Must provide a file or directory";
        return 1;
    else
        for i in "$@"
        do
            if [ -d $i ]; then
                cp -R "$i" "$ICLOUD_PATH";
                echo "$i copied to iCloud";
            else
                cp "$i" "$ICLOUD_PATH";
                echo "$i copied to iCloud";
            fi;
        done;
    fi;
}

killport() { lsof -i tcp:"$*" | awk 'NR!=1 {print $2}' | xargs kill -9 ;}

###############################################
#------------------Plugins--------------------#
###############################################

# ZSH Completions
# https://github.com/zsh-users/zsh-completions
plugins=(zsh-completions)

# ZSH Autosuggestions
# https://github.com/tarruda/zsh-autosuggestions
plugins+=(zsh-autosuggestions)

# ZSH Syntax Highlighting
# https://github.com/zsh-users/zsh-syntax-highlighting
# MUST BE LAST PLUGIN SOURCED BEFORE INITIALIZING OH-MY-ZSH!!!
plugins+=(zsh-syntax-highlighting)

# FROM: https://gist.github.com/ctechols/ca1035271ad134841284#gistcommnet-2609770
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
    compinit
done;
compinit -C

###############################################
#------------------Sourcing-------------------#
###############################################

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh;

###############################################
#----------------Style Prompt-----------------#
###############################################

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh;
