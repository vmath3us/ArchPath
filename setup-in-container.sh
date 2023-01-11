#!/usr/bin/bash
yaydir=$(mktemp -d -p /tmp)
sudo pacman -Fyyy &&
sudo sed -i "s|ParallelDownloads.*|ParallelDownloads = 15\nDisableDownloadTimeout\nILoveCandy|g" /etc/pacman.conf &&
sudo pacman -Syu reflector --noconfirm --needed &&
sudo reflector --save /etc/pacman.d/mirrorlist --country US,UK --protocol https --latest 50
sudo pacman -Syu base-devel git --noconfirm --needed &&
sudo cp export-bin.sh /usr/share/libalpm/scripts/export-bin.sh &&
sudo cp 99-export-bin.hook /usr/share/libalpm/hooks/99-export-bin.hook &&
git clone https://aur.archlinux.org/yay-bin $yaydir &&
cd $yaydir &&
makepkg -s &&
sudo pacman -U *.zst --noconfirm
