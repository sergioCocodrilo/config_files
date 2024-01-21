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

    # ip link               MUESTRA DATOS DE CONEXIÓN
    # ping archlinux.org    INTENTA REALIZAR UNA CONEXIÓN A archlinux.org, SI ES EXITOSO SE RECIBEN PAQUETES. TERMINAR CON CTRL+C


2. Partition the disks (Particionar el disco duro)

    # lsblk             MUESTRA EL ESTADO DEL DISCO DURO. IDENTIFICAR DÓNDE ESTÁ MONTADO Y CÓMO SE LLAMA.
    # fdisk /dev/sda    EDITAR EL DISCO DURO

delete all partitions (borrar todas las particiones)

    d ENTER             Repetir para cada una de las particiones existentes

Cuando no haya más particiones, crear una nueva tabla de particiones

    g for new table

create partitions (crear las particiones)

    n,1,intro,+550M     Do you want to remove the signature? Y
    n,2,intro,+2G
    n,3,intro,+100G
    n,4,intro,intro

chance type of partitions (cambiar el tipo de particiones)

    t,1,1   efi system
    t,2,19  linux swap

write the partitions (escribir las particiones, esto ejecuta todos los cambios del paso 2)

    w

3. Format the partitions file system (cambiar el formato de las particiones)

    # mkfs.fat -F 32 /dev/sda1
    # mkswap /dev/sda2
    # mkfs.ext4 /dev/sda3
    # mkfs.ext4 /dev/sda4

4. Mount the file systems (montar las particiones)

    # mount /dev/sda3 /mnt
    # mount /dev/sda1 /boot
    # swapon /dev/sda2

5. Install essential packages (instalar los paquetes esenciales)

    # pacstrap /mnt base linux linux-firmware neovim

6. Configure the system (configurar el sistema)

    # genfstab -U /mnt >> /mnt/etc/fstab
    # arch-chroot /mnt

    # ln -sf /usr/share/zoneinfo/America/Mexico_City /etc/localtime
    # hwclock --systohc
    # nvim /etc/locale.gen

En el archivo descomentar (quitar los caracteres al inicio) las líneas:

    en_US=UTF-8 UTF-8
    es_MX=UTF-8 UTF-8

    # locale-gen
    # nvim /etc/hostname        ESCRIBIR EL NOMBRE QUE TENDRÁ LA COMPUTADORA, EJ. COMPUTER_NAME
    # nvim /etc/hosts

Agregar lo siguiente con el nombre elegido para la computadora

    127.0.0.1   localhost
    ::1         localhost
    127.0.1.1   computer_name.localdomain    computer_name

7. Users and passwords (agregar usuarios y asignar contraseñas)

    # passwd                        CREAR PASSWORD DE SUPERUSUARIO
    # useradd -m nuevo_usuario      CREAR nuevo_usuario
    # passwd nuevo_usuario          CREAR password DE nuevo_usuario
    # usermod -aG wheel,audio,video,optical,storage nuevo_usuario
    # pacman -S sudo
    # EDITOR=nvim visudo

Descomentar la linea de %wheel ALL=(ALL) ALL

    # pacman -S grub efibootmgr dosfstools os-prober mtools
    # mkdir /boot/EFI
    # mount /dev/sda1 /boot/EFI
    # grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck
    # grub-mkconfig -o /boot/grub/grub.cfg

8. Extra packages (instalar paquetes)

    # pacman -S networkmanager i3-wm git tmux base-devel xorg xorg-init nitrogen picom kitty firefox base-devel cups polybar
    # systemctl enable NetworkManager
    # exit
    # umount /mnt         SI NO FUNCIONA --->  umount -l /mnt
    # reboot

