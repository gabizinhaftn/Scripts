def soma(x, y):
    return x + y
def sub(x, y):
    return x - y
def multi(x, y):
    return x * y
def div(x, y):
    if y != 0:
        return x / y
    else:
        return 'Divisão por 0 não existe!'

def calculadora ():
    print('Selecione a operação')
    print('1. Soma')
    print('2. Subtração')
    print('3. Multiplicação')
    print('4. Divisão')

    escolha = input('Selecione 1 ou 2 ou 3 ou 4: 4')

    if escolha not in ['1', '2', '3', '4']:
        print('Opção inválida')
        return

    try:
        num1 = float(input('Digite o primeiro número: '))
        num2 = float(input('Digite o segundo número: '))

    except ValueError:
        print('Erro, números inválidos')
        return

    if escolha == '1':
        print(f'{num1} + {num2} = {soma(num1, num2)}')
    elif escolha == '2':
        print(f'{num1} - {num2} = {sub(num1, num2)}')
    elif escolha == '3':
        print(f'{num1} * {num2} = {multi(num1, num2)}')
    elif escolha == '4':
        print(f'{num1} / {num2} = {div(num1, num2)}')

calculadora()