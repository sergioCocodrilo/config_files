# config_files
The .conf files go in /etc/X11/xorg.conf.d/


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

# turn off screen saver:
xset s off -dpms

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
    # grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB --recheck # opcion mas segura
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

sudo pacman -S arandr audacity autorandr blueman bluez bluez-utils calibre chromium clang cmus code cups-pdf dfu-programmer dfu-util dialog docker docker-compose dunst fd feh gimp gmtp gnome-bluetooth-3.0 gnome-clocks gnome-control-center gnome-disk-utility gnome-multi-writer gnome-subtitles gthumb gvfs hplip htop inkscape jre-openjdk krita lazygit libreoffice-still libva-utils libvncserver lutris lvm2 lxrandr nautilus netctl network-manager-applet networkmanager-openvpn nm-connection-editor nmap nodejs nsxiv ntp nvidia nvidia-lts nvidia-settings obs-studio okular openbsd-netcat p7zip pavucontrol pdfgrep picocom pipewire-alsa pipewire-pulse playerctl polybar postgresql python-dbus-next python-keyring python-pip python-pipenv python-pynvim python-pythondialog qbittorrent qgis rawtherapee rofi sane scrot shotwell simple-scan socat sof-firmware spotify-launcher sqlitebrowser system-config-printer telegram-desktop terminus-font texlive-basic texlive-bibtexextra texlive-fontsextra texlive-formatsextra texlive-games texlive-humanities texlive-latexextra texlive-mathscience texlive-music texlive-pictures texlive-pstricks texlive-publishers thunar thunar-archive-plugin thunar-media-tags-plugin thunar-volman tmate tree tree-sitter-cli ttf-firacode-nerd ttf-mononoki-nerd udiskie unrar vim virtualbox virtualbox-guest-utils vlc w3m wget wire-desktop wireless_tools xbindkeys xclip xorg-bdftopcf xorg-docs xorg-font-util xorg-fonts-100dpi xorg-fonts-75dpi xorg-iceauth xorg-mkfontscale xorg-server-devel xorg-server-xephyr xorg-server-xnest xorg-server-xvfb xorg-sessreg xorg-smproxy xorg-x11perf xorg-xbacklight xorg-xcmsdb xorg-xcursorgen xorg-xdpyinfo xorg-xdriinfo xorg-xev xorg-xgamma xorg-xhost xorg-xinput xorg-xkbevd xorg-xkbutils xorg-xkill xorg-xlsatoms xorg-xlsclients xorg-xpr xorg-xrandr xorg-xrefresh xorg-xset xorg-xsetroot xorg-xvinfo xorg-xwayland xorg-xwd xorg-xwininfo xorg-xwud xterm zathura zathura-pdf-mupdf zip zsh udisks2

AUR packages:

https://aur.archlinux.org/packages/apfs-fuse-git
https://aur.archlinux.org/packages/python-pulsectl
https://aur.archlinux.org/python-pulsectl-asyncio.git
https://aur.archlinux.org/gromit-mpx.git
https://aur.archlinux.org/huiontablet.git
https://aur.archlinux.org/iscan.git
https://aur.archlinux.org/mons.git
https://aur.archlinux.org/nerd-fonts-complete-mono-glyphs.git
https://aur.archlinux.org/nvim-packer-git.git
https://aur.archlinux.org/samsung-unified-driver.git
https://aur.archlinux.org/sublime-text-4.git
https://aur.archlinux.org/unetbootin.git
https://aur.archlinux.org/vial-appimage.git
https://aur.archlinux.org/zoom.git
https://aur.archlinux.org/woeusb-ng.git
https://aur.archlinux.org/wpa_supplicant_gui.git

## Other installed packages that could not be needed
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
