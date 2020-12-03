# Path to oh-my-zsh installation
export ZSH="/usr/share/oh-my-zsh"

# theme
ZSH_THEME="bira_venvfix"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(
	common-aliases
	git
    git-auto-fetch
	colored-man-pages
	colorize
	pip
	python
	command-not-found
	archlinux
	virtualenv
	web-search
	zsh-autosuggestions
	zsh-syntax-highlighting
)

# initialize some stuff
source $ZSH/oh-my-zsh.sh

# completion
autoload -Uz compinit
compinit # added to fix missing completion stuff, such as yay

# Share history between open terminals, only find unique history with up/down
setopt inc_append_history hist_find_no_dups

# Fix behaviour of home/end buttons
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line
bindkey "^[[3~" delete-char


# SOURCES

# travis-ci completion
[ -f /home/brisvag/.travis/travis.sh ] && source /home/brisvag/.travis/travis.sh

# fzf completion and search
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
source $HOME/bin/imod/IMOD-linux.sh

# PATHS AND OTHER EXPORTS

# base paths
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# additional paths
export PATH="$HOME/scripts:$PATH"

# pymol
export FREEMOL="$HOME/.cache/yay/freemol-svn/freemol-svn/freemol"
export PYTHONPATH="$HOME/.cache/yay/freemol-svn/freemol-svn/freemol/libpy:$PYTHONPATH"


# ALIASES AND SIMILAR

# basic aliases
alias sudo='sudo '	# space needed to sudo other aliases
alias l='ls -lFh --group-directories-first'
alias la='ls -lFhA --group-directories-first'
alias lt='ls -lFrth --group-directories-first'
alias rm='rm -I'
alias vi='nvim' #--servername vim'
alias vim='nvim' #--servername vim'
alias vimrc='vi $XDG_CONFIG_HOME/nvim/init.vim'
alias i3conf='vi $XDG_CONFIG_HOME/i3/config'
alias r='ranger'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias :q='exit'
alias q='exit'
alias open='xdg-open'
alias nvrun='__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME="nvidia" __VK_LAYER_NV_optimus="NVIDIA_only" '
mcd () {mkdir -p "$1" && cd "$1"}
up () {
    yay
    vi +PlugUpdate +qall
}

# dotfiles stuff (https://www.atlassian.com/git/tutorials/dotfiles)
# this alias with env variables is better because it allows the use of other git aliases
alias dot='GIT_DIR=~/.dotfiles/ GIT_WORK_TREE=~/ '

# git aliases
compdef -d mmd # needed to remove conflict of mcd with MultiMarkdown
unalias gam # otherwise is used for `git am`
gam () {git add "$1" && git commit -m "$2"} # need quotes on the message
alias gusup='git branch --set-upstream-to=upstream/$(git_current_branch)'


# TEMPORARY STUFF

# exports
export PYTHONPATH="$HOME/git/peepingtom:$PYTHONPATH"
# aliases
alias weather='curl -s "v2.wttr.in"'
