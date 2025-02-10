import pywhatkit as kit

numero = "+55 1197440-5040"
mensagem = "oi"

for i in range(100):
    a = str(i)
    kit.sendwhatmsg_instantly(numero, a, 6, True)
    print("Mensagem enviada")

print("Processo encerrado")
