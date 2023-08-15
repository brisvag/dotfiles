# fix local
TZ='Europe/Paris'; export TZ

# paths and defaults
export MANPATH="/usr/local/man:$MANPATH"
export LANG=en_US.UTF-8
export EDITOR='nvim'
# export ARCHFLAGS="-arch x86_64"
export TERM="alacritty"
export BROWSER="firefox"
export READER="okular"
export FILE="ranger"
# hardware accel for firefox
# https://wiki.archlinux.org/title/Hardware_video_acceleration#Configuring_VDPAU
# https://wiki.archlinux.org/title/Firefox#Hardware_video_acceleration
export NVD_LOG=0
export NVD_BACKEND=direct
export MOZ_DISABLE_RDD_SANDBOX=1
export LIBVA_DRIVER_NAME=nvidia
