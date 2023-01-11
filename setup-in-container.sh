#!/usr/bin/bash
yaydir=$(mktemp -d -p /tmp)
sudo sed -i "s|ParallelDownloads.*|ParallelDownloads = 15\nDisableDownloadTimeout\nILoveCandy|g" /etc/pacman.conf &&
sudo pacman -Fyyy &&
sudo pacman -Syu reflector --noconfirm --needed &&
sudo reflector --save /etc/pacman.d/mirrorlist --country US,UK --protocol https --latest 50
sudo pacman -Syu base-devel git --noconfirm --needed &&
sudo cp export-bin.sh /usr/share/libalpm/scripts/export-bin.sh &&
sudo cp 99-export-bin.hook /usr/share/libalpm/hooks/99-export-bin.hook &&
sudo cp distrobox-import-handler /usr/bin/distrobox-import-handler &&
git clone https://aur.archlinux.org/yay-bin $yaydir &&
cd $yaydir &&
makepkg -s &&
sudo pacman -U *.zst --noconfirm
distrobox-export --bin /usr/sbin/yay --export-path $HOME/.local/bin/archpath
distrobox-export --bin /usr/sbin/pacman --export-path $HOME/.local/bin/archpath
