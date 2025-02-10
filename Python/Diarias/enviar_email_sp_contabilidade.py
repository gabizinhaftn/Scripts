
import win32com.client as win32
import os
import pandas as pd
from time import gmtime, strftime


def gerar_corpo_email(dados):
    primeira_linha_fornecedor_valor = dados[0]['detalhes'][0].get("VALOR_PROVISIONADO", 0)
    primeira_linha_fornecedor = dados[0]['detalhes'][0].get("RAZÃO SOCIAL", 0)
    primeira_linha_fornecedor_valor = dados[0]['detalhes'][1].get("VALOR_PROVISIONADO", 0)
    primeira_linha_fornecedor = dados[0]['detalhes'][1].get("RAZÃO SOCIAL", 0)

    # Gerar a data atual formatada
    from time import gmtime, strftime
    data_atual = strftime('%d/%m/%Y', gmtime())
    corpo = f"""
    <html>
    <head>
        <style>
            body {{
                font-family: Arial, sans-serif;
                margin: 20px;
                line-height: 1.6;
                font-size: 14px;
                color: #333;
                background-color: #f9f9f9;
            }}
            .container {{
                background: #fff;
                border: 1px solid #ddd;
                border-radius: 8px;
                padding: 20px;
                max-width: 800px;
                margin: auto;
                box-shadow: 0px 2px 8px rgba(0, 0, 0, 0.1);
            }}
            h2 {{
                color: #007BFF;
                text-align: center;
                font-size: 22px;
                margin-bottom: 20px;
            }}
            h3 {{
                color: #555;
                font-size: 16px;
                margin-top: 10px;
                margin-bottom: 5px;
            }}
            table {{
                width: 80%;
                border-collapse: collapse;
                margin: 15px auto;
                font-size: 14px;
                background-color: #fff;
                color: #000;
                border: 1px solid #333;
            }}
            th, td {{
                border: 1px solid #333;
                text-align: left;
                padding: 8px;
            }}
            th {{
                background-color: #f4f4f4;
                color: #333;
                font-weight: bold;
            }}
            tr:nth-child(even) {{
                background-color: #f9f9f9;
            }}
            .footer {{
                text-align: center;
                margin-top: 20px;
                font-size: 12px;
                color: #888;
            }}
        </style>
    </head>
    <body>
        <div class="container">
            <h2>CONTROLE PROVISÃO DE SERVIÇOS</h2>
            <p>Prezados,</p>
            <p>Segue um resumo do relatório Controle Provisão de Serviços até a data <strong>{data_atual}</strong>.</p>
            <p>Provisão Mensal: Os valores variam ao longo dos meses, com um pico significativo em <strong>agosto e setembro de 2020</strong>, atingindo mais de <strong>R$ 1,9 milhão</strong> e <strong>R$ 2,4 milhões</strong>, respectivamente.</p>
            <p>Fornecedores: Os principais fornecedores incluem <strong>SENAI</strong>, que tem o <strong>maior</strong> valor provisionado (R$ 227 milhões), seguido pela <strong>Fundação Instituto de Administração</strong> e outros. Há valores pendentes de pagamento para diversos fornecedores.</p>
            <p>Pagamentos Realizados: Os pagamentos mensais variam, sendo <strong>janeiro e fevereiro</strong> marcados por quantidades expressivas de transações, com valores que chegam a <strong>R$ 8,7 milhões em um único mês</strong>.</p>
            <p> </p>
            
    """

    for resumo in dados[:1]:
        provisao_total = 0
        valor_documento = 0

# Somando os valores dentro da lista "detalhe"
        for detalhe in resumo.get("detalhe", []):
            provisao_total += detalhe.get("QUANTIDADE DE MOVIMENTO", 0) 
            valor_documento += detalhe.get("VALOR DOCUMENTO", 0)

# Formatar o valor total com separador de milhar no formato brasileiro
        valor_total_formatado = f"{valor_documento:,.2f}".replace(",", "X").replace(".", ",").replace("X", ".")

        corpo += f"""
        <div>
            <h3>Quantidade de Movimento: {provisao_total}</h3>
            <h3>Valor Documento: R$ {valor_total_formatado}</h3>
        </div>
        """

        # Verifique se "detalhe" existe e é uma lista válida
        if not resumo.get("detalhe"):
            corpo += """
            <p style="color: red;">Nenhum detalhe encontrado para este resumo.</p>
            """
            continue

        # Tabela para Tipo de Pagamento, Quantidade e Valor Total
        corpo += """
        <table>
            <thead>
                <tr>
                    <th>ANO</th>
                    <th>MÊS</th>
                    <th>VALOR DOCUMENTO</th>
                    <th>QUANTIDADE DO MOVIMENTO</th>
                </tr>
            </thead>
            <tbody>
        """

        # Criação do dicionário para agrupar por "Tipo de Pagamento"
        provisao_resumo = {}
        for detalhe in resumo["detalhe"]:
            ano = detalhe.get("ANO", 0)
            mes = detalhe.get("MES", 0)
            valor_documento_total = detalhe.get("VALOR DOCUMENTO", 0)
            quantidade_de_movimento = detalhe.get("QUANTIDADE DE MOVIMENTO", 0)

            chave = (ano, mes)

            if chave not in provisao_resumo:
                provisao_resumo[chave] = {'quantidade': 0, 'valor_total': 0}

            provisao_resumo[chave]['quantidade'] += quantidade_de_movimento
            provisao_resumo[chave]['valor_total'] += valor_documento_total 

        for (ano, mes), valores in provisao_resumo.items():
            corpo += f"""
                 <tr>
                    <td>{ano}</td>
                    <td>{mes}</td>
                    <td>R$ {valores['valor_total']:.2f}</td>
                    <td>{valores['quantidade']}</td>
                </tr>
                """

        corpo += """
            </tbody>
        </table>
        <br>
        """

    corpo += """
        </div>
        <div class="footer">
            <p>Este é um e-mail automático. Por favor, não responda.</p>
        </div>
    </body>
    </html>
    """
    return corpo

 
 
def enviar_email(destinatario, copiar, assunto, corpo, caminho_anexo):
    outlook = win32.Dispatch('Outlook.Application')
    mail = outlook.CreateItem(0)  
    mail.To = destinatario
    mail.cc = copiar
    mail.Subject = assunto
    mail.HTMLBody = corpo
    if caminho_anexo and os.path.exists(caminho_anexo):
        mail.Attachments.Add(caminho_anexo)
   
    mail.Send()
    print("E-mail enviado com sucesso!") 