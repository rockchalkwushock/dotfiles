# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password promts, [y/n] confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh";
fi;

#######################################################
#---------------------Variables------------------------
#######################################################

DEFAULT_USER=$USER;
# https://github.com/ohmyzsh/ohmyzsh/issues/6835#issuecomment-390216875
ZSH_DISABLE_COMPFIX=true;
ZSH_THEME="powerlevel10k/powerlevel10k";

#######################################################
#-----------------------Exports------------------------
#######################################################

# Make VSCode the default editor.
export EDITOR="code";

# Homebrew
export HOMEBREW_CASK_OPTS="--appdir=$HOME/Applications --fontdir=$HOME/Library/Fonts --require-sha";
export HOMEBREW_NO_ANALYTICS=true;
export HOMEBREW_NO_ENV_HINTS=true;
export HOMEBREW_NO_INSTALL_UPGRADE=true;

# Enables Erlang Docs
# https://thinkingelixir.com/elixir-1-11-and-erlang-docs/
export KERL_BUILD_DOCS=yes;
export KERL_CONFIGURE_OPTIONS="--disable-debug --without-javac --with-ssl=$(brew --prefix openssl@1.1)";

# pnpm
export PNPM_HOME="$HOME/Library/pnpm";
export PATH="$PNPM_HOME:$PATH";
# pnpm end

# Path to oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh";

#######################################################
#-----------------------Aliases------------------------
#######################################################

# Docker / Docker Compose Aliases
alias d="docker";
alias dc="docker-compose";

# Elixir / Phoenix Aliases
alias mxd="mix deps.get";
alias mxc="mix deps.compile";
alias mxem="mix ecto.migrate";
alias mxn="mix new";
alias mxt="mix test";
alias phxn="mix phx.new";
alias phxs="mix phx.server";

# Git Aliases
alias branches="git for-each-ref --sort='-authordate:iso8601' --format=' %(authordate:relative)%09%(refname:short)' refs/heads";
alias gc="git checkout";
alias ghr="git reset --hard";
alias gr="git rebase";
alias gs="git stash";
alias gsr="git reset --soft";
alias pull="git pull";
alias push="git push";
alias unwip="git reset HEAD~";
alias wip="git commit -a -m 'WIP' --no-verify";

# Homebrew Aliases
alias cleanup="brew cleanup";
alias make_brewfile="brew bundle dump --force";
alias outdated="brew outdated";
alias services="brew services list";
alias update="brew update";
alias upgrade="brew upgrade";

# PNPM
alias pn="pnpm";

# System Related Aliases
alias cat="bat";
alias clr="command clear";
alias flush_dns="sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder";
alias recov_postgres="command rm ./usr/local/var/postgres/postmaster.pid";
alias rmf="rm -rf";
alias zs="source .zshrc";

#######################################################
#-----------------------Functions----------------------
#######################################################

killport() { lsof -i tcp:"$*" | awk "NR!=1 {print $2}" | xargs kill -9 ;}

#######################################################
#-----------------------Plugins------------------------
#######################################################

# ZSH Completions
# https://github.com/zsh-users/zsh-completions
plugins=(zsh-completions)

# ZSH Autosuggestions
# https://github.com/tarruda/zsh-autosuggestions
plugins+=(zsh-autosuggestions)

# ZSH ASDF
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/asdf
plugins+=(asdf)

# ZSH Syntax Highlighting
# https://github.com/zsh-users/zsh-syntax-highlighting
# NOTE: Must be the last plugin sourced before initializing oh-my-zsh
plugins+=(zsh-syntax-highlighting)

# NOTE: https://gist.github.com/ctechols/ca1035271ad134841284#gitcommnet-2609770
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done;
compinit -C

#######################################################
#-----------------------Sourcing-----------------------
#######################################################

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh;

#######################################################
#-----------------------Style Prompt-------------------
#######################################################

# To customize prompt run `p10k configure` or edit ~/.p10k.zsh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh;