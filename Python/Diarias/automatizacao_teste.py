import pyautogui
from time import sleep

pyautogui.click(147,856, duration=2) #clicar para abrir o app
pyautogui.click(147,856, duration=0) #clicar para abrir o app

pyautogui.click(966,596, duration=8) # clicar em registrar novo usuario

pyautogui.click(1004,542, duration=2) #clicar em login
pyautogui.write('gabizinhaftn') #colocar o nick do login

pyautogui.click(1004,567, duration=2) #clicar em senha
pyautogui.write('1234') #colocar senha

pyautogui.click(937,598, duration=2) #clicar em registrar

pyautogui.click(994,540, duration=2) #clicar em login novamente
pyautogui.write('gabizinhaftn') #colocar o nick do login

pyautogui.click(988,568, duration=2) #clicar em senha
pyautogui.write('1234') #colocar senha

pyautogui.click(872,600, duration=2) #clicar em entrar

with open ('produtos.txt', 'r') as arquivo:
    for linha in arquivo:
        produto = linha.split(',')[0]
        quantidade = linha.split(',')[1]
        preco = linha.split(',')[2]

        pyautogui.click(711,528, duration=2) #clicar em produto
        pyautogui.write(produto)

        pyautogui.click(712,555, duration=2) #clicar em quantidade
        pyautogui.write(quantidade)

        pyautogui.click(713,582, duration=2) #clicar em preço
        pyautogui.write(preco)

        pyautogui.click(593,735, duration=2) #clicar em registrar
        sleep(1)