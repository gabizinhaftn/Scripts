import random

def jogo_pedra_papel_tesoura():
    opcoes = ["pedra", "papel", "tesoura"]
    print("Bem-vindo ao Jogo Pedra, Papel ou Tesoura!")

    while True:
        escolha_jogador = input("Escolha entre pedra, papel ou tesoura (ou 'sair' para terminar): ").lower()

        if escolha_jogador == "sair":
            print("Jogo encerrado. Até logo!")
            break

        if escolha_jogador not in opcoes:
            print("Opção inválida! Tente novamente.")
            continue

        escolha_computador = random.choice(opcoes)
        print(f"O computador escolheu: {escolha_computador}")

        if escolha_jogador == escolha_computador:
            print("Empate!")
        elif (escolha_jogador == "pedra" and escolha_computador == "tesoura") or \
                (escolha_jogador == "papel" and escolha_computador == "pedra") or \
                (escolha_jogador == "tesoura" and escolha_computador == "papel"):
            print("Você ganhou!")
        else:
            print("Você perdeu!")

jogo_pedra_papel_tesoura()
