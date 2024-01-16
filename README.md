# config_files
The .conf files go in /etc/X11/xorg.conf.d/

# Install
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
sudo pacman -S xclip
sudo pacman -S udisks2 udiskie
sudo pacman -S tree ripgrep fd
sudo pacman -S ttf-mononoki-nerd
sudo pacman -S playerctl

# To install
- nvim packer and install all plugins :PackerSync
- ohmyzsh
- tmux plugin manager https://github.com/tmux-plugins/tpm


# AURs
Install with:
- git clone
- cd
- makepkg -si

https://aur.archlinux.org/nerd-fonts-fira-code.git
https://aur.archlinux.org/nerd-fonts-complete.git
https://aur.archlinux.org/psst-git.git

# python
sudo pacman -S xclip
sudo pacman -S python-pip
python3 -m pip install virtualenv

# Run audio from user account
sudo pacman -S pipewire qpwgraph wireplumber pulseaudio-alsa pipewire-alsa pipewire-pulse
systemctl --user start pipewire-pulse.service

# Update path
export PATH="/home/sergio/.local/bin:$PATH"

# Silent speaker
sudo echo "blacklist pcspkr" >> /etc/modprobe.d/nobeep.conf

# Set a bigger terminal font
sudo cat << EOT >> /etc/vconsole.conf
FONT=ter-p24n
FONT_MAP=8859-2
EOT

# for the old macbook Pro:
Install https://aur.archlinux.org/b43-firmware.git for wifi
sudo pacman -S intel-ucode # All users with an AMD or Intel CPU should install the microcode updates to ensure system stability.
