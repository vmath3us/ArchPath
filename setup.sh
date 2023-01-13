#!/usr/bin/env sh
command_for_setup(){
sudo touch /etc/subuid /etc/subgid && sudo usermod --add-subuids 100000-165535 --add-subgids 100000-165535 $USER && podman system migrate
}
mkdir_setup(){
printf "###########################################################################%s\n"
printf "\ncriando diretórios%s\n"
mkdir -pv $HOME/.local/bin
printf "%s\n" &&
mkdir -pv $HOME/.local/bin/archpath
printf "%s\n" &&
mkdir -pv $HOME/.cache/pacmancache
printf "%s\n" &&
printf "###########################################################################%s\n"
printf "###########################################################################%s\n"
printf "%s\n" &&
printf "%s\n" &&
distrobox_initial_setup
}
distrobox_initial_setup(){
printf "###########################################################################%s\n"
printf "%s\n" &&
printf "\ninstalando Distrobox%s\n"
printf "%s\n" &&
printf "\nhttps://github.com/89luca89/distrobox%s\n"
printf "%s\n" &&
printf "%s\n" &&
curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/install | sh -s -- --prefix ~/.local &&
printf "%s\n" &&
printf "###########################################################################%s\n"
printf "%s\n" &&
printf "%s\n" &&
first_entry_setup
}
first_entry_setup (){
printf "###########################################################################%s\n"
printf "%s\n" &&
printf "\n Distrobox instalado, criando container...%s\n"
printf "%s\n" &&
DBX_CONTAINER_MANAGER="podman" $HOME/.local/bin/distrobox create ArchPath --image docker.io/archlinux/archlinux:latest --volume /home/$USER/.cache/pacmancache:/var/cache/pacman/pkg:rw &&
printf "###########################################################################%s\n"
printf "%s\n" &&
printf "\ncontainer criado, preparando para instalar o Yay%s\n"
printf "%s\n" &&
printf "\nhttps://github.com/Jguer/yay%s\n"
printf "%s\n" &&
printf "###########################################################################%s\n"
printf "%s\n" &&
$HOME/.local/bin/distrobox enter -n ArchPath --  /usr/bin/bash setup-in-container.sh &&
exiting
}
exiting(){
printf "%s\n" &&
printf "%s\n" &&
printf "###########################################################################%s\n" &&
printf "\n" &&
printf 'cole o conteúdo de setup.shell em seu .SHELLrc, e execute exec $SHELL' &&
printf "%s\n" &&
printf "%s\n" &&
printf "###########################################################################%s\n" &&
printf "\napós instalar algo via yay, basta executar distrobox-import%s\n" &&
printf "%s\n" &&
printf "###########################################################################%s\n"
}
printf "###########################################################################\n                           vmath3us/ArchPath                           \n###########################################################################%s\n"
printf "\nprocurando pelos comandos podman, sudo e curl%s\n" &&
if command -v podman && command -v sudo && command -v curl; then
    printf "\no podman está instalado, tentando configurar o modo rootless usando sudo...%s\n" &&
    command_for_setup &&
    mkdir_setup
else
    printf "\ncomandos não encontrados%s\n"
fi
