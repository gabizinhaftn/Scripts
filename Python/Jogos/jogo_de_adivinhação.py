import random

def jogo_adivinhacao():
    numero_secreto = random.randint(1, 100)
    tentativas = 10

    print('Bem vindo (a) ao jogo de adivinhção')
    print('Eu escolhi um número entre 0 e 100. Você tem 10 tentativas para acertá-lo')

    while tentativas > 0:
        tentativa = int(input(f'Tentativa {11 - tentativas}/10: Qual é o seu palpite? '))
        if tentativa < numero_secreto:
            print('Ops, o número é maior')
        elif tentativa > numero_secreto:
            print('Ops, o número é menor')
        else:
            print(f'Parabéns você conseguiu acertar o número {numero_secreto}')
            break

        tentativas -= 1

    if tentativas  == 0:
        print(f'Você perdeu! O número secreto era {numero_secreto}.')


jogo_adivinhacao()