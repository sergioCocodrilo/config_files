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

Arch Install
------------------------------------------------------------


1. Connect to the internet (Conectar a internet y probar)

```
    # ip link               MUESTRA DATOS DE CONEXIÓN
    # ping archlinux.org    INTENTA REALIZAR UNA CONEXIÓN A archlinux.org, SI ES EXITOSO SE RECIBEN PAQUETES. TERMINAR CON CTRL+C

```

2. Partition the disks (Particionar el disco duro)

```
    # lsblk             MUESTRA EL ESTADO DEL DISCO DURO. IDENTIFICAR DÓNDE ESTÁ MONTADO Y CÓMO SE LLAMA.
    # fdisk /dev/sda    EDITAR EL DISCO DURO
```

delete all partitions (borrar todas las particiones)

```
    d ENTER             REPETIR PARA CADA UNA DE LAS PARTICIONES EXISTENTES
```
Cuando no haya más particiones, crear una nueva tabla de particiones

```
    g for new table
```

create partitions (crear las particiones)

```
    n,1,intro,+1G     SI APARECE: Do you want to remove the signature? Y
    n,2,intro,+4G
    n,3,intro,+200G
    n,4,intro,intro
```

chance type of partitions (cambiar el tipo de particiones)

```
    t,1,1           EFI SYSTEM
    t,2,19          LINUX SWAP
```

write the partitions (escribir las particiones, esto ejecuta todos los cambios del paso 2)

```
    w
```

3. Format the partitions file system (cambiar el formato de las particiones)

```
    # mkfs.fat -F 32 /dev/sda1
    # mkswap /dev/sda2
    # mkfs.ext4 /dev/sda3
    # mkfs.ext4 /dev/sda4
```

4. Mount the file systems (montar las particiones)

```
    # mount /dev/nvme0n1p3 /mnt
    # mount --mkdir /dev/nvme0n1p1 /mnt/boot
    # mount --mkdir /dev/nvme0n1p4 /mnt/home
    # swapon /dev/nvme0n1p2
```

5. Install essential packages (instalar los paquetes esenciales)

```
    # pacstrap /mnt base linux linux-firmware neovim
```

6. Configure the system (configurar el sistema)

```
    # genfstab -U /mnt >> /mnt/etc/fstab
    # arch-chroot /mnt

    # ln -sf /usr/share/zoneinfo/America/Mexico_City /etc/localtime
    # hwclock --systohc
    # nvim /etc/locale.gen
```

En el archivo descomentar (quitar los caracteres al inicio) las líneas:

```
    en_US=UTF-8 UTF-8
    es_MX=UTF-8 UTF-8

    # locale-gen
    # nvim /etc/hostname        ESCRIBIR EL NOMBRE QUE TENDRÁ LA COMPUTADORA, EJ. COMPUTER_NAME
    # nvim /etc/hosts
```

Agregar lo siguiente con el nombre elegido para la computadora

```
    127.0.0.1   localhost
    ::1         localhost
    127.0.1.1   computer_name.localdomain    computer_name
```

7. Users and passwords (agregar usuarios y asignar contraseñas)

```
    # passwd                        CREAR PASSWORD DE SUPERUSUARIO
    # useradd -m nuevo_usuario      CREAR nuevo_usuario
    # passwd nuevo_usuario          CREAR password DE nuevo_usuario
    # usermod -aG wheel,audio,video,optical,storage nuevo_usuario
    # pacman -S sudo
    # EDITOR=nvim visudo
```

Descomentar la linea de %wheel ALL=(ALL) ALL

```
    # pacman -S grub efibootmgr dosfstools os-prober mtools
```

GRUB

```
    # mkdir /boot/EFI
    # mount /dev/sda1 /boot/EFI
    # grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck
    # grub-mkconfig -o /boot/grub/grub.cfg
```

8. Extra packages (instalar paquetes)

```
    # pacman -S networkmanager tmux xorg-server xorg-xinit nitrogen picom kitty firefox base-devel cups qtile
    # systemctl enable NetworkManager
    # exit
    # umount /mnt         SI NO FUNCIONA --->  umount -l /mnt
    # reboot
```



# Installed packages in previous OS:

The following packages are the output of pacman -Qe.

alacritty 0.13.2-2
apfs-fuse-git r101.66b86bd-1
arandr 0.1.11-3
audacity 1:3.5.1-2
autorandr 1.15-1
base 3-2
base-devel 1-1
blueman 2.4.1-2
bluez 5.76-1
bluez-utils 5.76-1
calibre 7.10.0-2
chromium 125.0.6422.76-1
clang 17.0.6-2
cmus 2.10.0-4
code 1.89.1-1
cups 1:2.4.8-1
cups-pdf 3.0.1-7
dfu-programmer 1.1.0-1
dfu-util 0.11-2
dialog 1:1.3_20240307-2
docker 1:26.1.3-1
docker-compose 2.27.0-1
dosfstools 4.2-3
dunst 1.11.0-1
efibootmgr 18-3
fd 10.1.0-1
feh 3.10.2-1
firefox 126.0-1
gimp 2.10.38-1
git 2.45.1-1
gmtp 1.3.11-3
gnome-bluetooth-3.0 46.0-1
gnome-clocks 46.0-1
gnome-control-center 46.1-2
gnome-disk-utility 46.0-1
gnome-multi-writer 3.35.90-1
gnome-subtitles 1.7.2-1
gromit-mpx 1.4.3-2
grub 2:2.12-2
gthumb 3.12.6-1
gvfs 1.54.0-3
hplip 1:3.23.12-6
htop 3.3.0-3
huiontablet v15.0.0.121.202301131103-1
inkscape 1.3.2-5
iscan 2.30.4.2-3
jre-openjdk 22.0.1.u0-1
kitty 0.33.1-4
krita 5.2.2-9
lazygit 0.42.0-1
libreoffice-still 7.6.7-1
libva-utils 2.21.0-1
libvncserver 0.9.14-2
linux 6.9.1.arch1-2
linux-firmware 20240510.b9d2bf23-1
lutris 0.5.17-4
lvm2 2.03.24-1
lxrandr 0.3.2-3
mons 0.8.2-1
mtools 1:4.0.43-1
nautilus 46.1-1
neovim 0.10.0-2
nerd-fonts-complete-mono-glyphs 2.1.0-1
netctl 1.29-1
network-manager-applet 1.36.0-1
networkmanager 1.46.0-2
networkmanager-openvpn 1.10.4-1
nitrogen 1.6.1-5
nm-connection-editor 1.36.0-1
nmap 7.95-1
nodejs 22.2.0-1
nsxiv 32-4
ntp 4.2.8.p17-1
nvidia 550.78-5
nvidia-lts 1:550.78-4
nvidia-settings 550.78-1
nvim-packer-git r566.1d0cf98-1
obs-studio 30.1.2-1
okular 24.02.2-1
openbsd-netcat 1.226_1-2
os-prober 1.81-1
p7zip 1:17.05-2
pavucontrol 1:5.0+r66+gc330506-1
pdfgrep 2.2.0-4
picocom 3.1-3
picom 11.2-1
pipewire-alsa 1:1.0.6-1
pipewire-pulse 1:1.0.6-1
playerctl 2.4.1-3
polybar 3.7.1-1
postgresql 16.2-4
python-dbus-next 0.2.3-5
python-keyring 25.2.0-1
python-pip 24.0-2
python-pipenv 2023.12.1-2
python-proton-client 0.7.1-2
python-protonvpn-nm-lib 3.16.0-1
python-pulsectl-asyncio 1.2.0-1
python-pynvim 0.5.0-3
python-pythondialog 3.5.3-3
python310 3.10.13-1
qbittorrent 4.6.4-1
qgis 3.36.2-2
qtile 0.25.0-2
rawtherapee 1:5.10-2
rofi 1.7.5-2
samsung-unified-driver 1.00.39-6
sane 1.3.1-1
scrot 1.10-3
shotwell 2:0.32.6-2
simple-scan 46.0-1
socat 1.8.0.0-1
sof-firmware 2024.03-1
spotify-launcher 0.5.4-1
sqlitebrowser 3.12.2-3
steam 1.0.0.79-2
sublime-text-4 4.4143-4
system-config-printer 1.5.18-4
telegram-desktop 5.0.1-1
terminus-font 4.49.1-6
texlive-basic 2024.2-1
texlive-bibtexextra 2024.2-1
texlive-fontsextra 2024.2-1
texlive-formatsextra 2024.2-1
texlive-games 2024.2-1
texlive-humanities 2024.2-1
texlive-latexextra 2024.2-1
texlive-mathscience 2024.2-1
texlive-music 2024.2-1
texlive-pictures 2024.2-1
texlive-pstricks 2024.2-1
texlive-publishers 2024.2-1
thunar 4.18.10-2
thunar-archive-plugin 0.5.2-1
thunar-media-tags-plugin 0.4.0-2
thunar-volman 4.18.0-1
tmate 2.4.0-4
tmux 3.4-8
tree 2.1.1-1
tree-sitter-cli 0.22.6-1
ttf-firacode-nerd 3.2.1-2
ttf-mononoki-nerd 3.2.1-2
udiskie 2.5.2-2
unetbootin 702-2
unrar 1:7.0.9-1
vial-appimage v0.6-2
vim 9.1.0429-1
virtualbox 7.0.18-1
virtualbox-guest-utils 7.0.18-1
vlc 3.0.20-9
w3m 0.5.3.git20230713_1-1
wget 1.24.5-2
wire-desktop 3.34.3307-2
wireless_tools 30.pre9-3
wireplumber 0.5.2-2
woeusb-ng 0.2.12-3
wpa_supplicant_gui 2.10-1
xbindkeys 1.8.7-4
xclip 0.13-5
xorg-bdftopcf 1.1.1-1
xorg-docs 1.7.3-2
xorg-font-util 1.4.1-1
xorg-fonts-100dpi 1.0.4-2
xorg-fonts-75dpi 1.0.4-1
xorg-iceauth 1.0.10-1
xorg-mkfontscale 1.2.3-1
xorg-server 21.1.13-1
xorg-server-devel 21.1.13-1
xorg-server-xephyr 21.1.13-1
xorg-server-xnest 21.1.13-1
xorg-server-xvfb 21.1.13-1
xorg-sessreg 1.1.3-1
xorg-smproxy 1.0.7-1
xorg-x11perf 1.6.2-1
xorg-xbacklight 1.2.3-3
xorg-xcmsdb 1.0.6-1
xorg-xcursorgen 1.0.8-1
xorg-xdpyinfo 1.3.4-1
xorg-xdriinfo 1.0.7-1
xorg-xev 1.2.6-1
xorg-xgamma 1.0.7-1
xorg-xhost 1.0.9-1
xorg-xinit 1.4.2-1
xorg-xinput 1.6.4-1
xorg-xkbevd 1.1.5-1
xorg-xkbutils 1.0.6-1
xorg-xkill 1.0.6-1
xorg-xlsatoms 1.1.4-1
xorg-xlsclients 1.1.5-1
xorg-xpr 1.2.0-1
xorg-xrandr 1.5.2-1
xorg-xrefresh 1.1.0-1
xorg-xset 1.2.5-1
xorg-xsetroot 1.1.3-1
xorg-xvinfo 1.1.5-1
xorg-xwayland 24.1.0-1
xorg-xwd 1.0.9-1
xorg-xwininfo 1.1.6-1
xorg-xwud 1.0.6-1
xterm 392-1
yay-git 12.1.0.r19.g688434b-1
zathura 0.5.6-2
zathura-pdf-mupdf 0.4.2-1
zip 3.0-11
zoom 5.17.1-1
zsh 5.9-5


ardour 8.6-1
arm-none-eabi-binutils 2.42-1
arm-none-eabi-gcc 14.1.0-1
arm-none-eabi-newlib 4.4.0.20231231-1
avr-binutils 2.42-2
avr-gcc 14.1.0-1
avr-libc 2.1.0-3
avrdude 1:7.3-1
blender 17:4.1.1-4
bmon 4.0-4
ddgr 2.2-1
garcon 4.18.2-1
geeqie 2.4-1
grafana 11.0.0-1
haruna 1.1.1-1
i3-wm 4.23-4
influxdb 2.7.5-1
ntfs-3g 2022.10.3-1
obsidian 1.5.12-1
openshot 3.1.1-2
openvpn 2.6.10-1
prometheus 2.52.0-1
protonup-qt 2.9.1-1
protonvpn 1.0.0-3
protonvpn-cli 3.13.0-2
protonvpn-gui 1.12.0-1
psst-git r516.67ec1b4-1
qpwgraph 0.7.2-1
ranger 1.9.3-11
remmina 1:1.4.35-4
retroarch 1.18.0-2
retroarch-assets-ozone 1:495-1
retroarch-assets-xmb 1:495-1
riscv64-elf-binutils 2.39-1
riscv64-elf-gcc 12.2.0-2
riscv64-elf-newlib 4.1.0-3
slack-desktop 4.35.131-1
task 3.0.2-1
tk 8.6.14-3
tldr 3.2.0-3
tumbler 4.18.2-1

xf86-video-nouveau 1.0.17-3
xfburn 0.7.0-1
xfce4-appfinder 4.18.1-1
xfce4-artwork 0.1.1a_git20110420-6
xfce4-battery-plugin 1.1.5-1
xfce4-clipman-plugin 1.6.6-1
xfce4-cpufreq-plugin 1.2.8-1
xfce4-cpugraph-plugin 1.2.10-1
xfce4-dict 0.8.6-1
xfce4-diskperf-plugin 2.7.0-1
xfce4-eyes-plugin 4.6.0-1
xfce4-fsguard-plugin 1.1.3-1
xfce4-genmon-plugin 4.2.0-1
xfce4-mailwatch-plugin 1.3.1-1
xfce4-mount-plugin 1.1.6-1
xfce4-mpc-plugin 0.5.3-1
xfce4-netload-plugin 1.4.1-1
xfce4-notes-plugin 1.11.0-1
xfce4-panel 4.18.6-1
xfce4-power-manager 4.18.3-1
xfce4-pulseaudio-plugin 0.4.8-1
xfce4-screensaver 4.18.3-1
xfce4-screenshooter 1.10.5-1
xfce4-sensors-plugin 1.4.4-1
xfce4-session 4.18.3-1
xfce4-settings 4.18.4-1
xfce4-smartbookmark-plugin 0.5.2-2
xfce4-systemload-plugin 1.3.2-1
xfce4-taskmanager 1.5.7-1
xfce4-terminal 1.1.3-1
xfce4-time-out-plugin 1.1.3-1
xfce4-timer-plugin 1.7.2-1
xfce4-verve-plugin 2.0.3-1
xfce4-wavelan-plugin 0.6.3-1
xfce4-weather-plugin 0.11.2-1
xfce4-whiskermenu-plugin 2.8.3-1
xfce4-xkb-plugin 0.8.3-1
xfdesktop 4.18.1-1
xfwm4 4.18.0-2
xfwm4-themes 4.10.0-5
