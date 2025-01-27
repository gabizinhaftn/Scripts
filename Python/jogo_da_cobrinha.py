import pygame
import random

pygame.init()

BRANCO = (255, 255, 255)
VERDE = (0, 255, 0)
VERDE_ESCURO = (0, 200, 0)
VERMELHO = (213, 50, 80)
AZUL = (50, 153, 213)

largura_tela = 600
altura_tela = 400
tela = pygame.display.set_mode((largura_tela, altura_tela))
pygame.display.set_caption('Jogo da Cobrinha')

tamanho_cobra = 10
velocidade_cobra = 15

def desenhar_cobra(tamanho_cobra, lista_cobra):
    for segmento in lista_cobra:
        pygame.draw.rect(tela, VERDE_ESCURO, [segmento[0], segmento[1], tamanho_cobra, tamanho_cobra])

def jogo():
    fim_jogo = False
    sair = False

    x = largura_tela / 2
    y = altura_tela / 2
    x_mudar = 0
    y_mudar = 0

    lista_cobra = []
    comprimento_cobra = 1

    comida_x = round(random.randrange(0, largura_tela - tamanho_cobra) / 10.0) * 10.0
    comida_y = round(random.randrange(0, altura_tela - tamanho_cobra) / 10.0) * 10.0

    clock = pygame.time.Clock()

    while not fim_jogo:
        for evento in pygame.event.get():
            if evento.type == pygame.QUIT:
                fim_jogo = True
            if evento.type == pygame.KEYDOWN:
                if evento.key == pygame.K_LEFT:
                    x_mudar = -tamanho_cobra
                    y_mudar = 0
                elif evento.key == pygame.K_RIGHT:
                    x_mudar = tamanho_cobra
                    y_mudar = 0
                elif evento.key == pygame.K_UP:
                    y_mudar = -tamanho_cobra
                    x_mudar = 0
                elif evento.key == pygame.K_DOWN:
                    y_mudar = tamanho_cobra
                    x_mudar = 0

        if x >= largura_tela or x < 0 or y >= altura_tela or y < 0:
            fim_jogo = True

        x += x_mudar
        y += y_mudar
        tela.fill(AZUL)

        pygame.draw.rect(tela, VERDE, [comida_x, comida_y, tamanho_cobra, tamanho_cobra])

        cabeca_cobra = []
        cabeca_cobra.append(x)
        cabeca_cobra.append(y)
        lista_cobra.append(cabeca_cobra)

        if len(lista_cobra) > comprimento_cobra:
            del lista_cobra[0]

        for segmento in lista_cobra[:-1]:
            if segmento == cabeca_cobra:
                fim_jogo = True

        desenhar_cobra(tamanho_cobra, lista_cobra)

        pygame.display.update()

        if x == comida_x and y == comida_y:
            comida_x = round(random.randrange(0, largura_tela - tamanho_cobra) / 10.0) * 10.0
            comida_y = round(random.randrange(0, altura_tela - tamanho_cobra) / 10.0) * 10.0
            comprimento_cobra += 1

        clock.tick(velocidade_cobra)

    pygame.quit()
    quit()

jogo()