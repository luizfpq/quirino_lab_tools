#!/usr/bin/env bash

#!/bin/bash

# Desabilitar proxy para o sistema
unset http_proxy
unset https_proxy
unset ftp_proxy
unset no_proxy

# Desabilitar proxy para o APT
echo "Acquire::http::Proxy \"\";" | sudo tee /etc/apt/apt.conf.d/00proxy
echo "Acquire::https::Proxy \"\";" | sudo tee -a /etc/apt/apt.conf.d/00proxy

# Desabilitar proxy para o usuário atual
gsettings set org.gnome.system.proxy mode 'none'

echo "Proxy do ambiente grafico desabilitado com sucesso."


# Define os arquivos de configuração do usuário
CONFIG_FILES=("$HOME/.bashrc" "$HOME/.bash_profile" "$HOME/.profile")

# Loop através de cada arquivo de configuração
for file in "${CONFIG_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo "Desabilitando entradas de proxy em $file"
        
        # Remove ou comenta as linhas que configuram proxies
        sed -i.bak '/^export *http_proxy=/s/^/#/' "$file"
        sed -i.bak '/^export *https_proxy=/s/^/#/' "$file"
        sed -i.bak '/^export *ftp_proxy=/s/^/#/' "$file"
        sed -i.bak '/^export *no_proxy=/s/^/#/' "$file"

        #executa o load do arquivo atualizado
        source ~/.bashrc
        
    fi
done



echo "Entradas de proxy desabilitadas. Por favor, reinicie seu terminal ou faça login novamente."
