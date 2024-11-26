import random

def jogo_forca():
    palavras = ["python", "programacao", "jogo", "computador", "desenvolvimento"]
    palavra_secreta = random.choice(palavras)
    letras_descobertas = ["_"] * len(palavra_secreta)
    tentativas = 6
    letras_erradas = []

    print("Bem-vindo ao Jogo da Forca!")

    while tentativas > 0 and "_" in letras_descobertas:
        print("\nPalavra: " + " ".join(letras_descobertas))
        print(f"Tentativas restantes: {tentativas}")
        print(f"Letras erradas: {', '.join(letras_erradas)}")

        letra = input("Digite uma letra: ").lower()

        if letra in letras_erradas or letra in letras_descobertas:
            print("Você já tentou essa letra.")
        elif letra in palavra_secreta:
            for i in range(len(palavra_secreta)):
                if palavra_secreta[i] == letra:
                    letras_descobertas[i] = letra
            print("Boa! Você acertou uma letra.")
        else:
            letras_erradas.append(letra)
            tentativas -= 1
            print("Errou! Tente novamente.")

    if "_" not in letras_descobertas:
        print(f"\nParabéns! Você adivinhou a palavra: {palavra_secreta}")
    else:
        print(f"\nVocê perdeu! A palavra era: {palavra_secreta}")

jogo_forca()
