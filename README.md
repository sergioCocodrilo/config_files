# Config files and packages to have a better desktop/system

## Required dependencies
sudo pacman -S base-devel
sudo pacman -S xorg tmux picom startx firefox rofi
sudo pacman -S xorg-xinit nitrogen alacritty
sudo pacman -S zsh
sudo pacman -S xbindkeys
sudo pacman -S vlc
sudo pacman -S i3-wm
sudo pacman -S polybar
sudo pacman -S thunar
sudo pacman -S gthumb
sudo pacman -S ntfs-3g
sudo pacman -S zathura zathura-pdf-mupdf 

## To install
- nvim packer and install all plugins :PackerSync
- ohmyzsh
- tmux plugin manager https://github.com/tmux-plugins/tpm


## AURs
Install with:
- git clone
- cd
- makepkg -si

https://aur.archlinux.org/nerd-fonts-fira-code.git
https://aur.archlinux.org/nerd-fonts-complete.git
https://aur.archlinux.org/psst-git.git

## python
sudo pacman -S xclip
sudo pacman -S python-pip
python3 -m pip install virtualenv

## Run audio from user account
sudo pacman -S pipewire qpwgraph wireplumber pulseaudio-alsa pipewire-alsa pipewire-pulse
systemctl --user start pipewire-pulse.service

## Update path
export PATH="/home/sergio/.local/bin:$PATH"

## Silent speaker
sudo echo "blacklist pcspkr" >> /etc/modprobe.d/nobeep.conf

## Set a bigger terminal font
sudo cat << EOT >> /etc/vconsole.conf
FONT=ter-p24n
FONT_MAP=8859-2
EOT

# Make symbolic links
Assuming repo was downloaded to Documents and named config_files.

## In config directory
ln -s ~/Documents/config_files/.config/alacritty ~/.config/
ln -s ~/Documents/config_files/.config/i3        ~/.config/
ln -s ~/Documents/config_files/.config/nvim      ~/.config/
ln -s ~/Documents/config_files/.config/polybar   ~/.config/
ln -s ~/Documents/config_files/.config/rofi      ~/.config/

## In X11 confs
sudo ln -s ~/Documents/config_files/10-monitor.conf  /etc/X11/xorg.conf.d/
sudo ln -s ~/Documents/config_files/30-touchpad.conf /etc/X11/xorg.conf.d/

## in home directory
ln -s ~/Documents/config_files/.xinitrc     ~/.xinitrc
ln -s ~/Documents/config_files/.tmux.conf   ~/.tmux.conf
ln -s ~/Documents/config_files/.xbindkeysrc ~/.xbindkeysrc
