#!/usr/bin/env sh
command_for_setup(){
sudo touch /etc/subuid /etc/subgid && sudo usermod --add-subuids 100000-165535 --add-subgids 100000-165535 $USER && podman system migrate
}
mkdir_setup(){
printf "\ncriando diretórios\n"
mkdir -p $HOME/.local/bin
mkdir -p $HOME/.local/bin/archpath
mkdir -p $HOME/.config/distrobox
mkdir -p $HOME/.cache/pacmancache
printf "\ncriando arquivo de configuração do distrobox\n"
printf "container_image="archlinux"\ncontainer_manager="podman"" > $HOME/.config/distrobox/distrobox.conf &&
distrobox_initial_setup
}
distrobox_initial_setup(){
printf "\ninstalando Distrobox\n"
printf "\nhttps://github.com/89luca89/distrobox\n"
curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/install | sh -s -- --prefix ~/.local &&
first_entry_setup
}
first_entry_setup (){
printf "\n Distrobox instalado, criando container...\n"
$HOME/.local/bin/distrobox create ArchPath --volume /home/usuario/.cache/pacmancache:/var/cache/pacman/pkg:rw &&
printf "\ncontainer criado, preparando para instalar o Yay\n"
printf "\nhttps://github.com/Jguer/yay\n"
$HOME/.local/bin/distrobox enter -n ArchPath --  /usr/bin/bash first-setup.sh
}
if command -v podman && command -v sudo && command -v curl; then
     command_for_setup &&
     printf "\no podman está instalado, tentando configurar o modo rootless usando sudo\n" &&
     mkdir_setup
 else
     printf "\ncomandos não encontrados"
 fi
