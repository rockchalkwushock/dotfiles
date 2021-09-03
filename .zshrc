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
PERSONAL_DIR="$HOME/Desktop/PERSONAL";
WORK_DIR="$HOME/Desktop/WORK"
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

# Docker aliases
alias d="docker";
alias dv="docker version";
alias dc="docker-compose";
alias dcv="docker-compose version";

# Elixir/Phoenix aliases
alias e_shell="iex -S mix";
alias mi="mix deps.get";
alias mc="mix deps.compile";
alias mm="mix ecto.migrate";
alias mn="mix new";
alias mt="mix test";
alias phxn="mix phx.new";
alias phxs="mix phx.server";
alias phxv="mix phx.new --version";

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
alias flush_dns="sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder";
alias recov_postgres="command rm ./usr/local/var/postgres/postmaster.pid";
alias rmf="rm -rf";
alias zs="source .zshrc";

# pnpm related aliases
alias pa="pnpm add";
alias pb="pnpm run build";
alias pc="pnpm run commit";
alias pd="pnpm run dev";
alias pga="pnpm add -g";
alias pgl="pnpm ls -g";
alias pgr="pnpm rm -g";
alias pgu="pnpm up -g -i";
alias pi="pnpm i";
alias prl="pnpm run lint";
alias prm="pnpm rm";
alias prs="pnpm start";
alias pt="pnpm t";
alias ptc="pnpm run type-check";
alias pu="pnpm up -i";

# Yarn related aliases

alias ya="yarn add";
alias yb="yarn build";
alias yc="yarn commit";
alias yd="yarn dev";
alias yga="yarn global add";
alias ygl="yarn global list";
alias ygr="yarn gloabl remove";
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
