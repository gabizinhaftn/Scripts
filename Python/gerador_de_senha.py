import random
import string

def gerar_senha (tamanho = 12):
    caracteres = string.ascii_letters + string.digits + string.punctuation + string.ascii_uppercase + string.ascii_lowercase
    senha = ''.join(random.choice(caracteres) for _ in range(tamanho ))
    return senha

senha = gerar_senha()
print(f'Senha gerada: {senha}')