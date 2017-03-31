#!/bin/bash

# DnsDragon - Pesquise por diretorios em sistemas web
# Description :  
# Use         : ./dnsdragon [ https://www.siteparaanalisar.com ] dragon.txt
# Developer   : Walderlan Sena - <http://www.walderlan.xyz/about>
# Email       : contato@walderlan.xyz
# LINCENSE    : Lincense GPL <http://gnu.org/lincense/gpl.html>  

# Variaveis Globais

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
                                           |___/      v-0.0.1
               \033[1;33m"Pesquise por diretórios em websites"\033[0m 
                           
           contato@walderlna.xyz - Developer: Walderlan Sena
             https//www.github.com/WalderlanSena/dnsdragon

        \033[0m'''
} # end function

# Verifica se os parametros foram passador corretamente
if [ -z "$1" ] || [ ! -e "$2" ]
then
  splash
  echo -e "$error Passe os parâmetros nescessarios: \n"
  echo -e "\033[1;33m./dnsdragon [ https://www.siteparaanalisar.com ] dragon.txt\033[0m \n"
else
  # Chamando tela de Boas Vindas
  splash
  word=$(cat $2 | wc -l)
  echo -e "
            \t[ \033[1;34mWordlist:\033[0m $word  \033[1;34mInicio:\033[0m `date | cut -d " " -f4` ]
          "
  echo -e "$ok Inicializando a busca. Aguarde..."
  for search in $(cat $2);
  do
    # Realiza a requisição via HTTP com o curl e captura o valor de retorno
    result=$(curl -s --head $1'/'$search'/' | grep -o -E '200|403')
    
    # Verifica se é um diretorio acessivel ou forbidden
    if [ "$result" = "200" ] || [ "$result" = "403" ];
    then
      echo -e "\033[0;36m[ `date | cut -d " " -f4` ]\033[0m $found $1/$search/"
    else
      echo -e "\033[0;36m[ `date | cut -d " " -f4` ]\033[0m $notfound $1/$search/"
    fi
  done
fi
