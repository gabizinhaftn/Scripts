import pyautogui
from time import sleep

pyautogui.click(920,1058, duration=3) #abrir rm

pyautogui.click(929,522, duration=45) #clicar em senha
pyautogui.write('G@bi1703') #colocar senha

pyautogui.click(950,657, duration=5) #clicar em entrar

pyautogui.click(1251,73, duration=25) #clicar em centro de custo

pyautogui.click(774,420, duration=10) #clicar em código

pyautogui.click(1046,753, duration=3) #clicar em executar

pyautogui.click(931,447, duration=3) #clicar em digitar
pyautogui.write('00073.000001.018') #digitar o centro de custo

pyautogui.click(1000,618, duration=3) #clicar em ok

pyautogui.click(88,227, duration=2) #clicar para selecionar o centro de custo

pyautogui.click(37,204, duration=4) #clicar para editar o centro de custo

pyautogui.click(876,487, duration=4) #clicar para permitir lançamento do centro de custo

pyautogui.click(1212,736, duration=2) #clicar em salvar

pyautogui.click(1050,738, duration=2) #clicar em ok

pyautogui.click(1900,12, duration=2) #clicar para fechar

pyautogui.click(1098,581, duration=2) #clicar em ok