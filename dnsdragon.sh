#!/bin/bash

# DnsDragon - Pesquise por diretorios em sistemas web
# Description : Encontre diretórios ocultos em websites com a requisição via Curl
# Use         : ./dnsdragon [ https://www.siteparaanalisar.com ] dragon.txt
# Developer   : Walderlan Sena - <https://www.mentesvirtuaissena.com>
# Email       : contato@mentesvirtuaissena.com
# LINCENSE    : Lincense GPL <http://gnu.org/lincense/gpl.html>

# Variaveis Globais
scriptversion="v1.1.2"

ok="\033[1;32m[ Iniciado a busca ]\033[0m"

error="\033[1;31m[ ERROR ]\033[0m"

found="\033[1;32mFOUND DIRECTORY »»»»»»»\033[0m"

notfound="\033[1;31mNOT FOUND »»»»»»»\033[0m"

found2="\033[1;32mFOUND FILE »»»»»»»\033[0m"

# Tela de splash
splash(){
clear # Limpando a tela do terminal
echo -e '''\033[1;32m
       ____            ____
      |  _ \ _ __  ___|  _ \ _ __ __ _  __ _  ___  _ __
      | | | |  _ \/ __| | | |  __/ _  |/ _  |/ _ \|  _ \
      | |_| | | | \__ \ |_| | | | (_| | (_| | (_) | | | |
      |____/|_| |_|___/____/|_|  \__,_|\__, |\___/|_| |_|
                                       |___/       v1.1.2
        \033[1;33m"Pesquise por diretórios e arquivos em websites"\033[0m

       contato@walderlna.xyz - Developer: Walderlan Sena
         https//www.github.com/WalderlanSena/dnsdragon

    \033[0m'''
} # end function

# Opções do script
usage="\
Usage: $0 [SITE] [WORDLIST] [OPTION]...
   or: $0 [SITE] [WORDLIST] -v  [ Opção padrão ]
   or: $0 [SITE] [WORDLIST] -s  Host/Diretorio encontrados

Options:
\t--help     exibir esta ajuda e sair.
\t--version  exibir informações sobre a versão e sair.

\t-v  (Opção padrão) Mostra o scaneamento em funcionamento
\t-s  Mostra apenas os Host/Diretorio encontrados
\t-i  instalar no seu desktop no diretorio /usr/bin/

Exemplo execute:
\t./dnsdragon.sh http://www.sitealvo.com dragon.txt

Caso esteja instalado no seu PC utilize:
\tdnsdragon [ Site ] [ wordlist ] [ opcoes ]
"

# Verifica se os parametros foram passador corretamente
if [ ! -z "$1" ] && [ ! -e "$2" ] && [ -z "$2" ]
then
    # Verifica se o usuario deseja um help a versão ou instalar
    case $1 in
        --help)
            splash
            echo "$usage";;
        --version)
            echo $scriptversion;;
        -i)
            echo -e "\033[1;32m[ + ]\033[m Iniciando a instalação em /usr/bin/"
            if sudo cp dnsdragon.sh /usr/bin/dnsdragon
            then
                echo -e "[!] Instalado com sucesso em /usr/bin/ agora realize a chamada do software\n Apenas com 'dnsdragon [ Site ] [ wordlist ] [ opcoes ]'"
            else
                echo -e "$error Não foi possivel realizar a instalação..."
            fi
            echo "";;
        *)  echo "$usage";
    esac
elif [ ! -z "$1" ] && [ -e "$2" ]
then
    # Chamando tela de Boas Vindas
    splash
    # Obtendo a quantidadde de linhas da wordlist passada
    word=$(cat $2 | wc -l)
    echo -e "
    \t[ \033[1;34mWordlist:\033[0m $word  \033[1;34mInicio:\033[0m `date +"%T"` ]
    "
    echo -e "$ok Iniciando a busca..."
    # Iniciando a leitura da lista passada via parâmetros
    for search in $(cat $2);
    do
        # Realiza a requisição via HTTP com o curl e captura o valor de retorno
        result=$(curl -s -o /dev/null -w "%{http_code}" $1/$search/)        # Busca por diretórios
        result2=$(curl -s -o /dev/null -w "%{http_code}" $1/$search)        # Busca por arquivos
        # Verifica se a opção de pesquisa silênciosa foi selecionada
        if [ "$3" != "-s" ]
        then
            # Verifica se é um diretorio acessivel ou forbidden
            if [ "$result" == "200" ] || [ "$result" == "403" ];
            then
                echo -e "\033[0;36m[ `date +"%T"` ]\033[0m $found $1/$search/"
            else
                echo -e "\033[0;36m[ `date +"%T"` ]\033[0m $notfound $1/$search/"
            fi
            # Verifica se um diretório foi encontrado e realiza o download do mesmo
            if [ "$result2" == "200" ]
            then
                echo -e "\033[0;36m[ `date +"%T"` ]\033[0m $found2 $1/$search"
                curl -s $1/$search --output $search
            fi
            # Caso exista a opção -s passada como parametro mostra apenas os diretórios e os arquivos encontrados
            else
                if [ "$result" == "200" ] || [ "$result" == "403" ]
                then
                    echo -e "\033[0;36m[ `date +"%T"` ]\033[0m $found $1/$search/"
                fi
                if [ "$result2" == "200" ]
                then
                    echo -e "\033[0;36m[ `date +"%T"` ]\033[0m $found2 $1/$search"
                    # Realizando o download do arquivo
                    curl -s $1/$search --output $search
                fi
            fi
        done
else
    # Opção padrão quando não há solicitação correta via parâmentro para o script
    splash
    echo -e "$usage"
fi
