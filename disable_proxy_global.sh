#!/usr/bin/env bash

# Arquivos de configuração globais
GLOBAL_CONFIG_FILES=("/etc/environment" "/etc/profile" "/etc/bash.bashrc")

# Loop através de cada arquivo de configuração
for file in "${GLOBAL_CONFIG_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo "Desabilitando entradas de proxy em $file"

        # Remove ou comenta as linhas que configuram proxies
        sed -i.bak '/^http_proxy=/s/^/#/' "$file"
        sed -i.bak '/^https_proxy=/s/^/#/' "$file"
        sed -i.bak '/^ftp_proxy=/s/^/#/' "$file"
        sed -i.bak '/^no_proxy=/s/^/#/' "$file"
    fi
done

echo "Entradas de proxy desabilitadas. Por favor, reinicie seu terminal ou faça login novamente."
