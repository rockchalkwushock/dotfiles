# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi;

###############################################
#-----------------Variables-------------------#
###############################################

DOTFILES_DIR="$HOME/dotfiles";
PROJECTS_DIR="$HOME/Desktop/Projects"
DEFAULT_USER=$USER;
ICLOUD_PATH="$HOME/Library/Mobile Documents/com~apple~CloudDocs/dotfiles";
ZSH_THEME="powerlevel10k/powerlevel10k";

###############################################
#------------------Exports--------------------#
###############################################

# Path to oh-my-zsh installation.
export ZSH=/Users/codybrunner/.oh-my-zsh;

# Make VSCode the default editor.
export EDITOR='code';

# Enables auto-complete for nvm.
export NVM_COMPLETION=true;

# Enables lazy-loading nvm.
export NVM_LAZY_LOAD=true;

###############################################
#------------------Aliases--------------------#
###############################################

# Elixir/Phoenix aliases
alias phx_version="mix phx.new --version"

# Git related aliases

alias branches="git for-each-ref --sort='-authordate:iso8601' --format=' %(authordate:relative)%09%(refname:short)' refs/heads";
alias gc="git checkout";
alias gr="git rebase";
alias gs="git stash";
alias h_reset="git reset --hard";
alias pull="git pull";
alias push="git push";
alias s_reset="git reset --soft";
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
alias hide="defaults write com.apple.finder CreateDesktop false; killall Finder;"
alias killport=find_and_kill;
alias recov_postgres="command rm ./usr/local/var/postgres/postmaster.pid";
alias rmf="rm -rf";
alias show="defaults write com.apple.finder CreateDesktop true; killall Finder;"
alias zs="source .zshrc";

# Yarn related aliases

alias ya="yarn add";
alias yb="yarn build";
alias yc="yarn commit";
alias yd="yarn dev";
alias yga="yarn global add";
alias ygl="yarn global list";
alias ygr="yarn global remove";
alias ygu="yarn global upgrade-interactive --latest";
alias yl="yarn lint";
alias yr="yarn remove";
alias ys="yarn start";
alias yt="yarn test";
alias ytc="yarn type-check";
alias yu="yarn upgrade-interactive --latest";

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

# dotfiles
# - jump to dotfiles directory
dotfiles() {
    cd $DOTFILES_DIR;
}

# find_and_kill
# - kill the provide port number's process.
find_and_kill() {
    if [ $# -eq 0 ]; then
        echo "Must provide port number.";
        return 1;
    else
        lsof -ti:$1 | xargs kill;
    fi;
}

###############################################
#------------------Plugins--------------------#
###############################################

# ZSH Completions
# https://github.com/zsh-users/zsh-completions
plugins=(zsh-completions)

# ZSH Autosuggestions
# https://github.com/tarruda/zsh-autosuggestions
plugins+=(zsh-autosuggestions)

# ZSH NVM
# https://github.com/lukechilds/zsh-nvm
plugins+=(zsh-nvm)

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
