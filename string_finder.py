import os
import subprocess
import threading
import sys

# Caminho da home do usuário
home_dir = '/home/estudante1/'  # Alterar se necessário
string_procurada = 'proxy.spo.ifsp.edu.br'

# Lista de arquivos para procurar e lista para armazenar os encontrados
arquivos_a_procurar = []
arquivos_encontrados = []

# Lock para evitar que threads interfiram nas impressões no terminal
print_lock = threading.Lock()

def procurar_string_em_arquivo(caminho_arquivo):
    """
    Função que executa o comando grep para procurar pela string no arquivo.
    """
    try:
        # Exibir a mensagem de leitura do arquivo
        with print_lock:
            #sys.stdout.write(f"Arquivo {caminho_arquivo} sendo lido...\r")
            sys.stdout.flush()

        # Usando o comando grep para procurar a string no arquivo
        resultado = subprocess.run(
            ['grep', '-l', string_procurada, caminho_arquivo],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE
        )
        if resultado.stdout:
            # Se a string for encontrada, adiciona o caminho à lista
            with print_lock:
                arquivos_encontrados.append(caminho_arquivo)
                sys.stdout.write(f"String encontrada no arquivo: {caminho_arquivo}\n")
                sys.stdout.flush()
        else:
            # Caso a string não seja encontrada, apenas limpar a mensagem de leitura
            with print_lock:
                #sys.stdout.write(f"Arquivo {caminho_arquivo} lido.\n")
                sys.stdout.flush()

    except subprocess.CalledProcessError as e:
        with print_lock:
            print(f"Erro ao rodar grep no arquivo {caminho_arquivo}: {e}")

def procurar_string_em_arquivos(diretorio):
    """
    Função que percorre todos os arquivos em um diretório e usa threads
    para procurar a string.
    """
    global arquivos_a_procurar
    
    # Verifica todos os diretórios dentro da home
    for root, dirs, files in os.walk(diretorio):
        for file in files:
            caminho_arquivo = os.path.join(root, file)
            arquivos_a_procurar.append(caminho_arquivo)

def buscar_em_multiplas_threads():
    """
    Função que divide o trabalho de procurar em múltiplas threads.
    """
    threads = []
    for arquivo in arquivos_a_procurar:
        # Criar uma nova thread para procurar em cada arquivo
        thread = threading.Thread(target=procurar_string_em_arquivo, args=(arquivo,))
        thread.start()
        threads.append(thread)
    
    # Aguardar todas as threads terminarem
    for thread in threads:
        thread.join()

if __name__ == '__main__':
    print("Iniciando a busca...")
    procurar_string_em_arquivos(home_dir)  # Preencher a lista com os arquivos
    buscar_em_multiplas_threads()  # Iniciar a busca com threads

    # Listar os arquivos encontrados
    if arquivos_encontrados:
        print("\nString encontrada nos seguintes arquivos:")
        for arquivo in arquivos_encontrados:
            print(arquivo)
    else:
        print("\nNenhum arquivo encontrado com a string.")

    print("Busca concluída.")
