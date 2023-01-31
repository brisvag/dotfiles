export ZSH="/usr/share/oh-my-zsh"

ZSH_THEME="bira"

plugins=(
    archlinux
    bgnotify
    colored-man-pages
    colorize
    command-not-found
    common-aliases
    dirhistory
    extract
    fancy-ctrl-z
    fd
    fzf
    gh
    git
    git-auto-fetch
    pip
    ripgrep
    safe-paste
    systemd
    virtualenv
    virtualenvwrapper
    z
    zsh-autosuggestions
    zsh-syntax-highlighting
)

# BGNOTIFY
bgnotify_threshold=20
function bgnotify_formatted {
    ## $1=exit_status, $2=command, $3=elapsed_time
    if [[ $1 -eq 0 ]]; then
        title="Job done!"
        # https://upload.wikimedia.org/wikipedia/commons/3/3b/Eo_circle_green_checkmark.svg
        icon=$XDG_DATA_HOME/icons/green_check.svg
    else
        title="Job failed!"
        # https://upload.wikimedia.org/wikipedia/commons/c/cc/Cross_red_circle.svg
        icon=$XDG_DATA_HOME/icons/red_cross.svg
    fi
    notify-send -u normal -i $icon -a $title "Finished in $3 s." $2
    echo -e '\a'
}

# FZF
export FZF_DEFAULT_COMMAND='fd'

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

# Colorscheme
$HOME/build/theme.sh/bin/theme.sh gruvbox-dark

# SOURCES

# travis-ci completion
[ -f /home/brisvag/.travis/travis.sh ] && source /home/brisvag/.travis/travis.sh

# fzf completion and search
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

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

# cuda
export PATH="$PATH:/opt/cuda/bin"

# ruby
export PATH="$HOME/.local/share/gem/ruby/3.0.0/bin:$PATH"

# python debug
export PYTHONBREAKPOINT="ipdb.set_trace"

# ALIASES AND SIMILAR

# basic aliases
alias sudo='sudo '	# space needed to sudo other aliases
alias l='exa -lh --git --group-directories-first'
alias la='l -a'
alias lt='l -s new' 
alias ltree='l -TI "__pycache__"'
alias lg='l --git-ignore'
alias rg='rg -S'
alias cat='bat'
alias rm='rm -I'
alias vi='nvim'
alias vim='vi'
alias vimrc='vi $XDG_CONFIG_HOME/nvim/init.vim'
alias i3conf='vi $XDG_CONFIG_HOME/i3/config'
alias r='ranger'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
dsf () {diff -u $@ | diff-so-fancy | less}
alias :q='exit'
alias q='exit'
alias open='xdg-open'
alias feh='feh -d.'
up () {(set -e; yay; vi +PlugUpdate +TSUpdate +qall)}
alias pip_publish='python -m build && twine upload dist/*'
alias rsync_all='rsync -avztuhHAXP'
alias dud='dust -d 1'
alias pydbg='python -m ipdb -c continue'
alias pytestdbg='pytest -s --pdb --pdbcls=IPython.terminal.debugger:Pdb'
alias F="| fzf"
alias fzcat='fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"'
tailf () {tail -F "$@" | bat --paging=never}
unalias help  # man alias
help () {"$@" --help 2>&1 | bat --plain --language=help}
man () {/usr/bin/man "$@" | bat --plain --language=man}
alias catw='bat --wrap never'

# dotfiles stuff (https://www.atlassian.com/git/tutorials/dotfiles)
# this alias with env variables is better because it allows the use of other git aliases
# requires:
# - git init --bare $HOME/.dotfiles
# - dot git config --local status.showUntrackedFiles no
alias dot='GIT_DIR=~/.dotfiles/ GIT_WORK_TREE=~/ '
alias dotlist='dot git ls-tree --full-tree --name-only -r HEAD'
alias sysdot='GIT_DIR=~/.system_dotfiles/ GIT_WORK_TREE=/ '
alias sysdotsudo='GIT_DIR=~/.system_dotfiles/ GIT_WORK_TREE=/ sudo --preserve-env '
alias sysdotlist='sysdot git ls-tree --full-tree --name-only -r HEAD'

# git aliases
unalias gam # otherwise is used for `git am`
gam () {git add "$1" && git commit -m "$2"} # need quotes on the message
alias gusup='git branch --set-upstream-to=upstream/$(git_current_branch)'
alias glom='git pull origin main'
alias gruh='git reset upstream/$(git_current_branch) --hard'
alias gdum='git diff upstream/$(git_main_branch)'
alias gdom='git diff origin/$(git_main_branch)'
alias gdo='git diff origin/$(git_current_branch)'
graa () {git remote add "$1" "git@github.com:$1/$(git_repo_name).git"}
grao () {git remote add origin "git@github.com:brisvag/$(git_repo_name).git"}
grau () {git remote add upstream "git@github.com:$1/$(git_repo_name).git"}
gclo () {git clone git@github.com:brisvag/$1.git}
alias gfork="gh repo fork --clone --remote"
alias ghrw="gr repo view -w"

# virtualenv
export WORKON_HOME="~/venv"
source /usr/bin/virtualenvwrapper.sh
