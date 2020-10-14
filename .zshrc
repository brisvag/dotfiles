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


# PATHS AND OTHER EXPORTS

# base paths
export PATH="$HOME/.local/bin:$PATH"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# additional paths
export PATH="$HOME/scripts:$PATH"

# hh-suite and modeller
export HHLIB="$HOME/builds/hh-suite/build"
export PATH="$HHLIB/bin:$HHLIB/scripts:$PATH"
export PYTHONPATH="$HOME/builds/modeller/modlib:$HOME/builds/modeller/lib/x86_64-intel8/python3.3:$PYTHONPATH"
export LD_LIBRARY_PATH="$HOME/builds/modeller/lib/x86_64-intel8:$LD_LIBRARY_PATH"

# docking
export MGLROOT="/opt/mgltools"
export PYTHONPATH="$MGLROOT/MGLToolsPckgs:$PYTHONPATH"
export LD_LIBRARY_PATH="$MGLROOT/lib/python2.7:$LD_LIBRARY_PATH"

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

# dotfiles stuff (https://www.atlassian.com/git/tutorials/dotfiles)
# this alias with env variables is better because it allows the use of other git aliases
alias dot='GIT_DIR=~/.dotfiles/ GIT_WORK_TREE=~/ '

# function "aliases
compdef -d mmd # needed to remove conflict of mcd with MultiMarkdown
mcd () {mkdir -p "$1" && cd "$1"}
unalias gam # otherwise is used for `git am`
gam () {git add "$1" && git commit -m "$2"} # need quotes on the message
up () {
    yay
    vi +PlugUpdate +qall
}


# TEMPORARY STUFF

# exports
export PYTHONPATH="$HOME/git/openage:$PYTHONPATH"
export PYTHONPATH="$HOME/git/stir:$HOME/git/garnish:$PYTHONPATH"
export PYTHONPATH="$HOME/git/gibberify:$PYTHONPATH"
export PYTHONPATH="$HOME/git/spawner:$PYTHONPATH"
# aliases
alias weather='curl -s "v2.wttr.in"'
alias stir="python -m stir"
alias gibberify="python -m gibberify"
alias adt='/opt/mgltools/bin/adt'
alias spawner="python -m spawner"

# fzf completion and search
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
