#!/bin/bash

ARGS=$1

help() {
    echo "Ferramenta usada para remover linhas de logs contendo seu IP"
    echo "by SNISS"
    echo ""
    echo "Modo de uso:"
    echo "$0 -ip 127.0.0.1"
    echo "$0 -f ips.txt"
}

history_clear() {
    echo "Apagando o histórico existente da sessão..."
    history -c
    unset SSH_CLIENT SSH_CONNECTION
    export HISTFILE=/dev/null
    echo "Histórico limpo e pausado."
}


ip() {
    if [[ -n "$2" && "$2" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        echo "Removendo todas as linhas de logs contendo o IP: $2"
        find / -type f -name "*.log*" ! -path "$(pwd)/*" -exec sed -i "/$2/d" {} \;
        echo "Operação concluída."
    else
        echo "Digite um IP válido!"
    fi
}


fileip() {
    if [[ -e "$2" && -s "$2" ]]; then
        if grep -Evq '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$' "$2"; then
            echo "O arquivo '$2' contém valores que não são IPs."
            exit 1
        else
            echo "Removendo IPs listados no arquivo '$2'..."
            while IFS= read -r ip; do
                find / -type f -name "*.log*" ! -path "$(pwd)/*" -exec sed -i "/$ip/d" {} \;
            done < "$2"
            echo "Operação concluída."
        fi
    else
        echo "O arquivo '$2' está vazio ou não existe."
    fi
}

if [[ -z "$ARGS" ]]; then
    help
    exit 0
fi

case $ARGS in
    "-ip"|"--ip")
        history_clear
        ip "$@" 
        ;;
    "-f"|"--file")
        history_clear
        fileip "$@" 
        ;;
    "-h"|"--help")
        help
        ;;
    *)
        echo "Opção não encontrada!"
        exit 1
        ;;
esac
