# https://github.com/robbyrussell/oh-my-zsh
# https://github.com/bhilburn/powerlevel9k
# http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
# https://nerdfonts.com

#################################################
#---------------- Variables --------------------#
#################################################

CLOUDPATH="$HOME/Library/Mobile Documents/com~apple~CloudDocs/dotfiles"
DEFAULT_USER=$USER
POWERLEVEL9K_MODE="nerdfont-complete"
ZSH_THEME="powerlevel9k/powerlevel9k"

#################################################
#---------------- Exports ----------------------#
#################################################

# Path to your oh-my-zsh installation.
export ZSH=/Users/rockchalkwushock/.oh-my-zsh

# ANDROID PATHS
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# YARN PATH
export PATH="$PATH:/opt/yarn-[version]/bin"

# YARN GLOBAL BINARIES
export PATH="$PATH:`yarn global bin`"

# FOR CORRECT PYTHON VERSION SYMLINK
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

# ANACONDA PATH
export PATH=/usr/local/anaconda3/bin:"$PATH"

# Make VS Code the default editor.
export EDITOR='code';

#################################################
#---------------- Aliases ----------------------#
#################################################

alias cleanup="brew cleanup; brew cask cleanup"
alias clr="command clear"
alias globals="yarn global upgrade-interactive"
alias list="brew list; brew cask list; mas list"
alias makeBrew="brew bundle dump --force"
alias outdated="brew outdated; brew cask outdated; mas outdated;"
alias rmf="command rm -rf"
alias zs="source ~/.zshrc"

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

# Get Versions
# - display versions of frequently used packages.
# - For info on `:`
# @see https://stackoverflow.com/q/47248220/6520579
get_versions() {
  local brew_version=$(brew --version 2>/dev/null)
  local create_react_app_version=$(create-react-app --version 2>/dev/null)
  local elixir_version=$(elixir --version 2>/dev/null)
  local elm_version=$(elm --version 2>/dev/null)
  local exp_version=$(exp --version 2>/dev/null)
  local git_version=$(git --version 2>/dev/null)
  local macos_version=$(defaults read loginwindow SystemVersionStampAsString 2>/dev/null)
  local mongo_version=$(mongo --version 2>/dev/null)
  local node_version=$(node --version 2>/dev/null)
  local now_version=$(now --version 2>/dev/null)
  local npm_version=$(npm --version 2>/dev/null)
  local nvm_version=$(nvm --version 2>/dev/null)
  local phx_version=$(mix phx.new -v 2>/dev/null)
  local pip_version=$(pip --version 2>/dev/null)
  local psql_version=$(psql --version 2>/dev/null)
  local python2_version=$(python2 --version 2>/dev/null)
  local python3_version=$(python3 --version 2>/dev/null)
  local ruby_version=$(ruby --version 2>/dev/null)
  local yarn_version=$(yarn --version 2>/dev/null)
  local zsh_version=$(zsh --version 2>/dev/null)

  echo "brew:----------------- ${brew_version:9:5}"
  echo "create-react-app:----- ${create_react_app_version}"
  echo "elixir:--------------- ${elixir_version:130}"
  echo "elm:------------------ ${elm_version}"
  echo "exp:------------------ ${exp_version}"
  echo "git:------------------ ${git_version:12}"
  echo "macOS:---------------- ${macos_version}"
  echo "mongo:---------------- ${mongo_version:23:5}"
  echo "node:----------------- ${node_version:1}"
  echo "now:------------------ ${now_version}"
  echo "npm:------------------ ${npm_version}"
  echo "nvm:------------------ ${nvm_version}"
  echo "phoenix:-------------- ${phx_version:9}"
  echo "pip:------------------ ${pip_version:4:6}"
  echo "python3:-------------- ${python3_version:7:12}"
  echo "psql:----------------- ${psql_version:18}"
  echo "ruby:----------------- ${ruby_version:5:9}"
  echo "yarn:----------------- ${yarn_version}"
  echo "zsh:------------------ ${zsh_version:4:4}"
}

# Yarn
prompt_yarn_version() {
  local yarn_version=$(yarn --version 2>/dev/null)
  [[ -z "${yarn_version}" ]] && return

  "$1_prompt_segment" "$0" "$2" "blue" "white" "${yarn_version}" 'YARN_ICON'
}

#################################################
#-------------- Powerlevel9k -------------------#
#################################################

# PROMPT ELEMENTS
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs) # DEFAULT: (context dir rbenv vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status node_version yarn_version root_indicator background_jobs time) # DEFAULT: (status root_indicator background_jobs history time)

# OVERRIDE DEFAULTS
POWERLEVEL9K_DIR_OMIT_FIRST_CHARACTER=true
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_TIME_FORMAT='%D{\uf017 %H%M \uf073 %d.%m.%y}'
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1

# CUSTOM COLORS
POWERLEVEL9K_DIR_HOME_BACKGROUND="140"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="140"
POWERLEVEL9K_VCS_CLEAN_BACKGROUND='078'
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='222'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='210'

# CUSTOM ICONS
POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR="\ue0b4"
POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR="\ue0b6"
POWERLEVEL9K_NODE_ICON=''
POWERLEVEL9K_VCS_BRANCH_ICON_ICON='\ue725'
POWERLEVEL9K_VCS_COMMIT_ICON_ICON='\ue729'
POWERLEVEL9K_VCS_GIT_BITBUCKET_ICON=''
POWERLEVEL9K_VCS_GIT_GITHUB_ICON=''
POWERLEVEL9K_VCS_GIT_GITLAB_ICON=''
POWERLEVEL9K_VCS_GIT_ICON=''
POWERLEVEL9K_YARN_ICON=''

#################################################
#----------------- Plugins ---------------------#
#################################################

plugins=(
  colored-man-pages
  command-not-found
  git
  yarn
  zsh-autosuggestions
  zsh-completions
  zsh-syntax-highlighting
  )

# For `zsh-completions`
autoload -U compinit && compinit

#################################################
#----------------- Sourcing --------------------#
#################################################

source $ZSH/oh-my-zsh.sh
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

