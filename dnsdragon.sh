#!/bin/bash

# DnsDragon - Pesquise por diretorios em sistemas web
# Description : Ache diretorios ocultos em websites com a requisição via Curl
# Use         : ./dnsdragon [ https://www.siteparaanalisar.com ] dragon.txt
# Developer   : Walderlan Sena - <http://www.walderlan.xyz/about>
# Email       : contato@walderlan.xyz
# LINCENSE    : Lincense GPL <http://gnu.org/lincense/gpl.html>

# Variaveis Globais
scriptversion="v-beta2"

ok="\033[1;32m[ Iniciado a busca ]\033[0m"

error="\033[1;31m[ ERROR ]\033[0m"

found="\033[1;32mFOUND DIRECTORY »»»»»»»\033[0m"

notfound="\033[1;31mNOT FOUND »»»»»»»\033[0m"

# Tela de splash
splash(){
clear # Limpando a tela do terminal
echo -e '''\033[1;32m
           ____            ____
          |  _ \ _ __  ___|  _ \ _ __ __ _  __ _  ___  _ __
          | | | |  _ \/ __| | | |  __/ _  |/ _  |/ _ \|  _ \
          | |_| | | | \__ \ |_| | | | (_| | (_| | (_) | | | |
          |____/|_| |_|___/____/|_|  \__,_|\__, |\___/|_| |_|
                                           |___/      v-beta2
               \033[1;33m"Pesquise por diretórios em websites"\033[0m

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
  --help     exibir esta ajuda e sair.
  --version  exibir informações sobre a versão e sair.

  -v  (Opção padrão) Mostra o scaneamento em funcionamento
  -s  Mostra apenas os Host/Diretorio encontrados
  -i  instalar no seu desktop no diretorio /bin/

Exemplo execute:
  ./dnsdragon.sh https://www.Site.com dragon.txt

  Caso esteja instalado no seu PC utilize:
  dnsdragon [ Site ] [ wordlist ] [ opcoes ]
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
      echo -e "\033[1;32m[ + ]\033[m Iniciando a instalação em /bin/"
      if sudo cp dnsdragon.sh /bin/dnsdragon
      then
        echo -e "[!] Instalado com sucesso em /bin/ agora realize a chamada do software\n
        Apenas com 'dnsdragon [ Site ] [ wordlist ] [ opcoes ]'"
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
  word=$(cat $2 | wc -l)
  echo -e "
            \t[ \033[1;34mWordlist:\033[0m $word  \033[1;34mInicio:\033[0m `date +%r`]
          "
  echo -e "$ok Iniciando a busca..."
  for search in $(cat $2);
  do
    # Realiza a requisição via HTTP com o curl e captura o valor de retorno
    result=$(curl -s --head $1'/'$search'/' | grep -o -E '200|403')

    if [ "$3" != "-s" ]
    then
      # Verifica se é um diretorio acessivel ou forbidden
      if [ "$result" = "200" ] || [ "$result" = "403" ];
      then
        echo -e "\033[0;36m[ `date +%r`]\033[0m $found $1/$search/"
      else
        echo -e "\033[0;36m[ `date +%r`]\033[0m $notfound $1/$search/"
      fi
      # Caso exista a opção -s passada como parametro
    else
      if [ "$result" = "200" ] || [ "$result" = "403" ];
      then
        echo -e "\033[0;36m[ `date +%r`]\033[0m $found $1/$search/"
      fi
    fi
  done
else
  splash
  echo -e "$error ./dnsdragon.sh https://www.SiteDesejado.com dragon.txt \n"
fi
