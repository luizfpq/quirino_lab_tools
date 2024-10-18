import os
import subprocess

def generate_ssh_key():
    # Nome do arquivo da chave
    key_name = 'id_rsa_github'
    key_path = os.path.join(os.getcwd(), key_name)
    
    # Comando para gerar a chave SSH
    subprocess.run(['ssh-keygen', '-t', 'rsa', '-b', '4096', '-f', key_path, '-N', ''],
                   check=True)

    # Mostrar o caminho da chave pública gerada
    public_key_path = f"{key_path}.pub"
    
    # Comando para mostrar como adicionar a chave ao GitHub
    print("Chave SSH gerada com sucesso!")
    print(f"Caminho da chave privada: {key_path}")
    print(f"Caminho da chave pública: {public_key_path}")
    print("Use o seguinte comando para adicionar a chave ao GitHub:")
    print(f"cat {public_key_path} | pbcopy")  # Para macOS
    print(f"cat {public_key_path} | xclip -sel clip")  # Para Linux
    print("Em seguida, cole no GitHub na seção de SSH keys.")

if __name__ == "__main__":
    generate_ssh_key()
