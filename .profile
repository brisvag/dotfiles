# fix local
TZ='Europe/Paris'; export TZ

# fix scaling for hidpi (together with xresources)
# export GTK_SCALE=1
# export GTK_DPI_SCALE=0.85
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export QT_SCREEN_SCALE_FACTORS=2

# paths and defaults
export MANPATH="/usr/local/man:$MANPATH"
export LANG=en_US.UTF-8
export EDITOR='nvim'
# export ARCHFLAGS="-arch x86_64"
export TERM="alacritty"
export BROWSER="firefox"
export READER="okular"
export FILE="ranger"
