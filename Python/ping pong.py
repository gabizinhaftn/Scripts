import pygame

pygame.init()

BRANCO = (255, 255, 255)
PRETO = (0, 0, 0)
AZUL = (50, 153, 213)

LARGURA = 800
ALTURA = 600

tela = pygame.display.set_mode((LARGURA, ALTURA))
pygame.display.set_caption("Ping Pong")

clock = pygame.time.Clock()
FPS = 60

RAQUETE_LARGURA = 15
RAQUETE_ALTURA = 100
BOLA_TAM = 15

def desenha_raquete(x, y):
    pygame.draw.rect(tela, BRANCO, [x, y, RAQUETE_LARGURA, RAQUETE_ALTURA])

def desenha_bola(x, y):
    pygame.draw.ellipse(tela, BRANCO, [x, y, BOLA_TAM, BOLA_TAM])

def desenha_pontuacao(pontos_jogador1, pontos_jogador2):
    fonte = pygame.font.SysFont("arial", 30)
    pontuacao = fonte.render(f"{pontos_jogador1} - {pontos_jogador2}", True, BRANCO)
    tela.blit(pontuacao, [LARGURA//2 - pontuacao.get_width()//2, 20])

# Função principal do jogo
def jogo():
    jogador1_x = 30
    jogador1_y = ALTURA // 2 - RAQUETE_ALTURA // 2

    jogador2_x = LARGURA - 30 - RAQUETE_LARGURA
    jogador2_y = ALTURA // 2 - RAQUETE_ALTURA // 2

    bola_x = LARGURA // 2 - BOLA_TAM // 2
    bola_y = ALTURA // 2 - BOLA_TAM // 2

    bola_velocidade_x = 5
    bola_velocidade_y = 5

    velocidade_raquete = 10

    pontos_jogador1 = 0
    pontos_jogador2 = 0

    jogo_rodando = True
    while jogo_rodando:
        tela.fill(AZUL)

        for evento in pygame.event.get():
            if evento.type == pygame.QUIT:
                jogo_rodando = False

        teclas = pygame.key.get_pressed()
        if teclas[pygame.K_w] and jogador1_y > 0:
            jogador1_y -= velocidade_raquete
        if teclas[pygame.K_s] and jogador1_y < ALTURA - RAQUETE_ALTURA:
            jogador1_y += velocidade_raquete
        if teclas[pygame.K_UP] and jogador2_y > 0:
            jogador2_y -= velocidade_raquete
        if teclas[pygame.K_DOWN] and jogador2_y < ALTURA - RAQUETE_ALTURA:
            jogador2_y += velocidade_raquete

        bola_x += bola_velocidade_x
        bola_y += bola_velocidade_y

        if bola_y <= 0 or bola_y >= ALTURA - BOLA_TAM:
            bola_velocidade_y = -bola_velocidade_y

        if bola_x <= jogador1_x + RAQUETE_LARGURA and jogador1_y < bola_y + BOLA_TAM and jogador1_y + RAQUETE_ALTURA > bola_y:
            bola_velocidade_x = -bola_velocidade_x
        if bola_x >= jogador2_x - BOLA_TAM and jogador2_y < bola_y + BOLA_TAM and jogador2_y + RAQUETE_ALTURA > bola_y:
            bola_velocidade_x = -bola_velocidade_x

        if bola_x <= 0:
            pontos_jogador2 += 1
            bola_x = LARGURA // 2 - BOLA_TAM // 2
            bola_y = ALTURA // 2 - BOLA_TAM // 2
            bola_velocidade_x = -bola_velocidade_x

        if bola_x >= LARGURA - BOLA_TAM:
            pontos_jogador1 += 1
            bola_x = LARGURA // 2 - BOLA_TAM // 2
            bola_y = ALTURA // 2 - BOLA_TAM // 2
            bola_velocidade_x = -bola_velocidade_x

        desenha_raquete(jogador1_x, jogador1_y)
        desenha_raquete(jogador2_x, jogador2_y)
        desenha_bola(bola_x, bola_y)
        desenha_pontuacao(pontos_jogador1, pontos_jogador2)

        pygame.display.update()

        clock.tick(FPS)

    pygame.quit()

jogo()
