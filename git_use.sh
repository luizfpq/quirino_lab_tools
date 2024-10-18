#!/usr/bin/env bash

# Função para exibir ajuda
function mostrar_ajuda() {
    echo "Uso:"
    echo "  $0 <caminho/para/chave> <comando_git> [args...]"
    echo ""
    echo "Descrição:"
    echo "  Executa um comando Git usando uma chave SSH especificada."
    echo ""
    echo "Exemplo:"
    echo "  $0 /caminho/para/minha_chave clone git@github.com:usuario/repositorio.git"
    exit 1
}

# Verifica se o número de argumentos está correto
if [ "$#" -lt 2 ]; then
    mostrar_ajuda
fi

CHAVE_SSH=$1
shift
COMANDO_GIT=$@

GIT_SSH_COMMAND="ssh -i $CHAVE_SSH" git $COMANDO_GIT
