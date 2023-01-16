#!/usr/bin/bash
yaydir=$(mktemp -d -p /tmp)
sudo sed -i "s|ParallelDownloads.*|ParallelDownloads = 15\nDisableDownloadTimeout\nILoveCandy|g" /etc/pacman.conf &&
sudo pacman -Fyyy &&
sudo pacman -Syu reflector --noconfirm --needed &&
sudo reflector --save /etc/pacman.d/mirrorlist --country US,UK --protocol https --latest 50
sudo pacman -Syu base-devel git --noconfirm --needed &&
sudo cp distrobox-import-handler /usr/bin/distrobox-import &&
sudo cp distrobox-archpath-save /usr/bin/distrobox-archpath-save &&
git clone https://aur.archlinux.org/yay-bin $yaydir &&
cd $yaydir &&
makepkg -s &&
sudo pacman -U *.zst --noconfirm
distrobox-export --bin /usr/sbin/yay --export-path $HOME/.local/bin/archpath
distrobox-export --bin /usr/sbin/pacman --export-path $HOME/.local/bin/archpath
distrobox-export --bin /usr/sbin/distrobox-import --export-path $HOME/.local/bin/archpath
distrobox-export --bin /usr/sbin/distrobox-archpath-save --export-path $HOME/.local/bin/archpath
