# PATHS AND OTHER EXPORTS

# base paths
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# additional paths
export PATH="$HOME/scripts:$PATH"

# cuda
export CUDA_PATH="/opt/cuda-11.1"

# Share history between open terminals, only find unique history with up/down
setopt inc_append_history hist_find_no_dups

plugins=(
    archlinux
    bgnotify
    colored-man-pages
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
# plugin configs go here before sourcing ohmyzsh

# FZF
export FZF_DEFAULT_COMMAND='fd'

# initialize ohmyzsh and fix completion
export ZSH="/usr/share/oh-my-zsh"
source $ZSH/oh-my-zsh.sh
autoload -Uz compinit
compinit # added to fix missing completion stuff, such as yay
# fzf completion and search (off by default for arch fzf package)
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# fancy theme
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

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

# python debug
export PYTHONBREAKPOINT="ipdb.set_trace"

# virtualenv
export WORKON_HOME="~/venv"
source /usr/bin/virtualenvwrapper.sh

# nnn
export NNN_OPTS='aCdgDeirx'
export NNN_PLUG='d:dragdrop;p:preview-tui'
export NNN_ICONLOOKUP=1
# for full usability, preview-tui requires:
# - being in a TMUX
# - having bat,exa,ueberzug,ffmpegthumbnailer,poppler,

# ALIASES AND SIMILAR

# basic aliases
alias sudo='sudo '	# space needed to sudo other aliases
alias l='exa -lh --git --group-directories-first'
alias la='l -a'
alias lt='l -s new' 
alias ltree='l -TI "__pycache__"'
alias lg='l --git-ignore'
alias rg='rg -S'
alias cat='bat --theme=gruvbox-dark'
alias rm='rm -I'
alias cp='advcp -ig'
alias mv='advmv -ig'
alias vi='nvim'
alias vim='vi'
alias vimrc='vi $XDG_CONFIG_HOME/nvim/init.vim'
alias i3conf='vi $XDG_CONFIG_HOME/i3/config'
alias r='ranger'
alias n='nnn -F 0 -P p'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
dsf () {diff -u $@ | diff-so-fancy | less}
alias :q='exit'
alias q='exit'
alias open='xdg-open'
alias feh='feh -d.'
up () {(set -e; yay; vi +UpdateRemotePlugins +TSUpdateSync +PlugUpdate +qall; sudo pkgfile -u)}
alias pip_publish='python -m build && twine upload dist/*'
alias rsync_all='rsync -avztuhHAXP'
alias rsync_remote='rsync -rlvztuhHP'
alias dud='dust -d 1'
alias pydbg='python -m ipdb -c continue'
alias pytestdbg='pytest -s --pdb --pdbcls=IPython.terminal.debugger:Pdb'
alias F="| fzf"
alias fzcat='fzf --preview "cat --color=always --style=numbers --line-range=:500 {}"'
tailf () {tail -F "$@" | cat --paging=never}
unalias help  # man alias
help () {"$@" --help 2>&1 | cat --plain --language=help}
man () {/usr/bin/man "$@" | cat --plain --language=man}
alias catw='cat --wrap never'
alias xclip='xclip -selection c'  # send to system clipboard by default

# dotfiles stuff (https://www.atlassian.com/git/tutorials/dotfiles)
# this alias with env variables is better because it allows the use of other git aliases
# requires:
# - git init --bare $HOME/.dotfiles
# - dot git config --local status.showUntrackedFiles no
# - dot git remote add origin git@github.com:brisvag/dotfiles.git
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
alias grbum='git rebase upstream/$(git_main_branch)'

# put this in a function so we use it only if needed (slow)
conda_init () {
    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/opt/mambaforge/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/opt/mambaforge/etc/profile.d/conda.sh" ]; then
            . "/opt/mambaforge/etc/profile.d/conda.sh"
        else
            export PATH="/opt/mambaforge/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<
}
