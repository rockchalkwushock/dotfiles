###########################################
# THIS FILE IS WHAT WILL BE READ UPON
# OPENING TERMINAL.
###########################################

# Add path from `yarn global bin` to the `$PATH` for `yarn global` usage.
export PATH="$HOME/.node_modules_global/bin:$PATH";

# Message about shorcuts:
echo "Common Aliases: .. , ..., cleanup, clr, globals, pkgUpdates, rmf, update";

# Load dotfiles
for file in ~/.{bash_aliases,bash_prompt}; do
        [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Add tab completion for bash & git.
if [ -f $(brew --prefix)/etc/bash_completion ]; then
        . $(brew --prefix)/etc/bash_completion
fi
