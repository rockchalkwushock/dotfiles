#######################################################
#---------------------Variables------------------------
#######################################################

DEFAULT_USER=$USER;
# https://github.com/ohmyzsh/ohmyzsh/issues/6835#issuecomment-390216875
ZSH_DISABLE_COMPFIX=true;
ZSH_THEME="spaceship";

#######################################################
#-----------------------Exports------------------------
#######################################################

# Make VSCode the default editor.
export EDITOR="code";

# Explicitly set the locale to UTF-8
export LANG=en_US.UTF-8

# Homebrew
export HOMEBREW_CASK_OPTS="--appdir=$HOME/Applications --fontdir=$HOME/Library/Fonts --require-sha";
export HOMEBREW_NO_ANALYTICS=true;
export HOMEBREW_NO_ENV_HINTS=true;
export HOMEBREW_NO_INSTALL_UPGRADE=true;

# Enables Erlang Docs
# https://thinkingelixir.com/elixir-1-11-and-erlang-docs/
export KERL_BUILD_DOCS=yes;
export KERL_CONFIGURE_OPTIONS="--disable-debug --without-javac --with-ssl=$(brew --prefix openssl@1.1)";

# MySQL
export DATADIR="$HOME/.asdf/installs/mysql/8.0.32/data/";

# Zoxide
export _ZO_DATA_DIR="$HOME/Library/Application Support";
export _ZO_FZF_OPTS="--height 40% --layout=reverse --border --preview 'bat --color=always --style=header,grid --line-range :500 {}' --preview-window=right:60%:wrap";
export _ZO_MAXAGE=3600;

# Spaceship
export SPACESHIP_CONFIG="$HOME/.config/spaceship.zsh";

# Path to oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh";

#######################################################
#-----------------------Aliases------------------------
#######################################################

# Elixir/Phoenix Aliases
alias mxd="mix deps.get";
alias mxc="mix deps.compile";
alias mxn="mix new";
alias mxt="mix test";
alias phxn="mix phx.new";
alias phxs="mix phx.server";

# Git Aliases
alias branches="git for-each-ref --sort='-authordate:iso8601' --format=' %(authordate:relative)%09%(refname:short)' refs/heads";
alias gc="git checkout";
alias pull="git pull";
alias push="git push";
alias rebase="git rebase";
alias stash="git stash";
alias unwip="git reset HEAD~";
alias wip="git commit -a -m 'WIP' --no-verify";

# Homebrew Aliases
alias cleanup="brew cleanup";
alias make_brewfile="brew bundle dump --force";
alias outdated="brew outdated";
alias services="brew services list";
alias update="brew update";
alias upgrade="brew upgrade";

# Pnpm Aliases
alias pn="pnpm";

# System Related Aliases
alias cat="bat";
alias cd="z";
alias clr="command clear";
alias flush_dns="sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder";
alias nq="networkQuality";
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

# ZSH Zoxide
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/zoxide
plugins+=(zoxide)

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

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh;

# zoxide
eval "#(zoxide init zsh)";

# zsh-completions
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src;

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh;
