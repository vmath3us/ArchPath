#!/usr/bin/env sh
command_for_setup(){
sudo touch /etc/subuid /etc/subgid && sudo usermod --add-subuids 100000-165535 --add-subgids 100000-165535 $USER && podman system migrate
}
mkdir_setup(){
printf "###########################################################################"
printf "\ncriando diretórios\n"
mkdir -pv $HOME/.local/bin
printf "###########################################################################"
mkdir -pv $HOME/.local/bin/archpath
printf "###########################################################################"
mkdir -pv $HOME/.cache/pacmancache
printf "###########################################################################"
printf "###########################################################################"
distrobox_initial_setup
}
distrobox_initial_setup(){
printf "###########################################################################"
printf "\ninstalando Distrobox\n"
printf "###########################################################################"
printf "\nhttps://github.com/89luca89/distrobox\n"
printf "###########################################################################"
curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/install | sh -s -- --prefix ~/.local &&
printf "###########################################################################"
first_entry_setup
}
first_entry_setup (){
printf "###########################################################################"
printf "\n Distrobox instalado, criando container...\n"
DBX_CONTAINER_MANAGER="podman" $HOME/.local/bin/distrobox create ArchPath --image docker.io/archlinux/archlinux:latest --volume /home/$USER/.cache/pacmancache:/var/cache/pacman/pkg:rw &&
printf "\ncontainer criado, preparando para instalar o Yay\n"
printf "###########################################################################"
printf "\nhttps://github.com/Jguer/yay\n"
$HOME/.local/bin/distrobox enter -n ArchPath --  /usr/bin/bash setup-in-container.sh &&
printf "###########################################################################"
printf "\ncole o conteúdo de setup.shell em seu .SHELLrc, e execute exec $SHELL\n"
printf "###########################################################################"
printf "\napós instalar algo via yay, basta executar distrobox-import\n"
printf "###########################################################################%s\n"
}
printf "###########################################################################\n                           vmatheus/ArchPath                           \n###########################################################################%s\n"
printf "\nprocurando pelos comandos podman, sudo e curl%s\n" &&
if command -v podman && command -v sudo && command -v curl; then
    command_for_setup &&
    printf "\no podman está instalado, tentando configurar o modo rootless usando sudo\n" &&
    mkdir_setup
else
    printf "\ncomandos não encontrados"
fi
