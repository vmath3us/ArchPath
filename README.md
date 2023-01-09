# ArchPath <h1>

Graças ao [Distrobox](https://github.com/89luca89/distrobox) de 89luca89, se tornou fácil rodar programas de uma distribuição em outra. Se valendo do comando distrobox-export, e dos hooks do pacman, Archpath se propoẽ a, caso um comando não seja encontrado no seu path, guiar o usuário a instalá-lo num container do Archlinux, e ao fim, exportá-lo para o path do host, tornando-o instantaneamente acessível. Programas gráficos e serviços não estão no escopo desse projeto, mas deve ser facilmente estendível também para esse propósito, como pode ser visto na documentação do [distrobox-export](https://github.com/89luca89/distrobox/blob/main/docs/usage/distrobox-export.md).

Do host, é exigido:
* A possibilidade de rodar containers rootless, via podman (docker é suportado pelo distrobox, mas neste projeto o podman será configurado por padrão). Para execução do [Podman Rootless](https://github.com/containers/podman/blob/main/docs/tutorials/rootless_tutorial.md#enable-user-namespaces-on-rhel7-machines), setup.sh tentará executar o comando "sudo touch /etc/subuid /etc/subgid && sudo usermod --add-subuids 100000-165535 --add-subgids 100000-165535 $USER && podman system migrate". Caso isso não funcione, procure a documentação da sua distribuição para o podman, e edite setup.sh, alterando o comando
* Curl

[Setup.sh](https://github.com/vmath3us/archpath/blob/main/setup.sh) irá criar as pastas $HOME/.local/bin, $HOME/.local/bin/archpath, $HOME/.cache/pacmancache, e $HOME/.config/distrobox. Dentro dessa última, distrobox.conf, configurando a imagem padrão para o Archlinux, e o gerenciador de container como podman. Após, via curl, o distrobox será instalado em $HOME/.local/bin.

    curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/install | sh -s -- --prefix ~/.local

Já via distrobox, um container será gerado, montando $HOME/.cache/pacmancache em /var/cache/pacman/pkg do container. O processo pode demorar dependendo da sua conexão, e da performance da sua máquina, especialmente na primeira vez, onde ainda não há cache do pacman. [Distrobox-enter](https://github.com/89luca89/distrobox/blob/main/docs/usage/distrobox-enter.md) será executado imediatamente, o que implica em mais instalação de pacotes, para integração do container com o host, [como pode ser visto aqui](https://github.com/89luca89/distrobox/blob/main/distrobox-init). Uma vez isso terminado, serão executados, já dentro do container, os comandos de [first-setup.sh](https://github.com/vmath3us/archpath/blob/main/first-setup.sh)

Se valendo do distrobox-export, um hook pós-instalação será habilitado, tendo como destino $HOME/.local/bin/archpath, para que os comandos instalados fiquem visíveis no host. O [yay](https://aur.archlinux.org/packages/yay-bin) já será exportado pelo hook.

Ao fim, adicione o conteúdo de setup.shell no seu .SHELLrc (bash,zsh...), e rode:

    exec $SHELL


O conteúdo de setup.shell será responsável por usar $HOME/.local/bin e $HOME/.local/bin/archpath no seu $PATH, e também por rodar yay -F no comando que não for encontrado no $PATH. Tenha em mente que -F só procura por comandos nos repositórios do Archlinux, e não no AUR, por isso yay -Ss é oferecido. Além disso, por ser um container rootless, não espere poder instalar por exemplo módulos de kernel, cli de sistema de arquivos (compsize, btrfs-progs), enfim, programas que exijam acesso profundo ao sistema. Outro detalhe é editores de texto não irão conseguir editar arquivos de configuração do root do host, e sim de dentro do container. Programas tais como gerenciadores de download cli (aria2c), navegadores cli (lynx, w3m), ou mesmo players de vídeo (mvp, cvlc) deverão funcionar normalmente.

A ideia é que o seguinte ocorra: ao tentar executar um comando que não exista no host, e nem em $HOME/.local/bin/archpath, a função de shell irá executar automaticamente yay -F "comando" e (opcionalmente) yay -Ss "comando". Em qualquer caso, o usuário deve instalar manualmente um pacote que oferte o comando desejado. O hook do pacman irá exportar o comando para $HOME/.local/bin/archpath, e a partir de então estará disponível. Manter o container atualizado, resolver conflito de dependências e demais problemas é responsabilidade do usuário.

Conhecer a cli do pacman é fortemente encorajado. Por exemplo, yay -Qqem listará somente os pacotes instalados via AUR; -Qqen, somente os NÃO instalados via AUR, mas que foram instalados explicitamente (e não como dependência). A saída pode ser redirecionada para arquivos, e esses arquivos usados para reprovisionar um novo container. [A Archwiki é sua melhor amiga](https://wiki.archlinux.org/title/pacman),e para funções específicas do yay para uso do AUR, [consulte esta documentação](https://github.com/Jguer/yay#examples-of-custom-operations).

Confira [Stateless Arch](https://github.com/vmath3us/stateless-arch)
