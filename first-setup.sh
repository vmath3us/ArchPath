#!/usr/bin/bash
sudo pacman -Syu base-devel git --noconfirm --needed &&
cp export-bin.sh /usr/share/libpalm/scritps/export-bin.sh &&
cp 99-export-bin.hook /usr/share/libpalm/hooks/99-export-bin.hook &&
git clone https://aur.archlinux.org/yay-bin /tmp/yay-bin &&
cd /tmp/yay-bin &&
makepkg -s &&
sudo pacman -U *.zst --noconfirm
