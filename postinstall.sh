#!/usr/bin/bash
# Setup my Fedora system

# Generate hostname from model name
HOSTNAME="$(cat /sys/devices/virtual/dmi/id/product_name | tr '[:upper:]' '[:lower:]' | tr ' ' '-' )"

INSTALL=(
    firefox
    emacs
    gcc
    gcc-go
    gdb
    gimp
    gnome-tweaks
    gramps
    keepassxc
    make
    mpc
    mpd
    mpv
    powertop
    torbrowser-launcher
    youtube-dl
)

REMOVE=(
    cheese
    gedit
    evolution
    gnome-documents
    gnome-contacts
    gnome-photos
    rhythmbox
    totem
)

#
# Basic Setup
#

hostnamectl set-hostname $HOSTNAME

# Remove unwanted packages
sudo dnf -y remove ${REMOVE[*]}

# Add RPM Fusion Free (no non-free software on this system!)
sudo dnf -y install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm

sudo dnf -y update

sudo dnf -y install ${INSTALL[*]}

# Start saving power!
sudo systemctl enable --now powertop

systemctl --user enable emacs
systemctl --user enable mpd

# GNOME Settings
# Mouse
dconf write /org/gnome/desktop/peripherals/touchpad/natural-scroll  false
dconf write /org/gnome/desktop/peripherals/touchpad/speed           1.0
dconf write /org/gnome/desktop/peripherals/touchpad/tap-to-click    true

# Keybindings
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-up   "['<Super>k']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-down "['<Super>j']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-up     "['<Shift><Super>k']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-down   "['<Shift><Super>j']"
dconf write /org/gnome/desktop/wm/keybindings/panel-run-dialog         "['<Super>space']"
dconf write /org/gnome/settings-daemon/plugins/media-keys/screensaver  "['<Shift><Super>l']"
# Swap capslock and control
dconf write /org/gnome/desktop/input-sources/xkb-options "['caps:ctrl_modifier']"

# FIXME: Also doesn't work
# dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/name    'Terminal'
# dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/binding '<Super>t'
# dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/command 'gnome-terminal'
# dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"

# dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/name    'Emacs Client'
# dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/binding '<Super>e'
# dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/command 'emacsclient --create-frame'
# dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/']"

# Nautilus
dconf write /org/gtk/settings/file-chooser/sort-directories-first true
