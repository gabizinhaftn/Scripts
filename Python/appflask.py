from flask import Flask, render_template_string, request, jsonify
import sqlite3

app = Flask(__name__)

# Função para conectar ao banco de dados SQLite e criar a tabela
def init_db():
    with sqlite3.connect('contratos.db') as conn:
        cursor = conn.cursor()
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS contratos (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                cod_contrato TEXT NOT NULL
            )
        ''')
        conn.commit()

# Função para inserir um novo contrato no banco de dados
def inserir_contrato(cod_contrato):
    with sqlite3.connect('contratos.db') as conn:
        cursor = conn.cursor()
        cursor.execute('''
            INSERT INTO contratos (cod_contrato)
            VALUES (?)
        ''', (cod_contrato,))
        conn.commit()

# Função para obter todos os contratos do banco de dados
def obter_contratos():
    with sqlite3.connect('contratos.db') as conn:
        cursor = conn.cursor()
        cursor.execute('SELECT * FROM contratos')
        return cursor.fetchall()

@app.route('/', methods=['GET', 'POST'])
def form():
    cod_contrato_recebido = None
    if request.method == 'POST':
        cod_contrato = request.form['cod_contrato']
        # Inserir o contrato no banco de dados
        inserir_contrato(cod_contrato)
        cod_contrato_recebido = f'CODCONTRATO Recebido: {cod_contrato}'
    
    return render_template_string('''
        <!DOCTYPE html>
        <html lang="pt-br">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Formulário CODCONTRATO</title>
            <style>
                body {
                    font-family: Arial, sans-serif;
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    height: 100vh;
                    margin: 0;
                    background-color: #f4f4f9;
                }
                .form-container {
                    background-color: white;
                    padding: 20px;
                    border-radius: 8px;
                    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                    width: 100%;
                    max-width: 400px;
                    text-align: center;
                }
                h1 {
                    font-size: 24px;
                    margin-bottom: 20px;
                }
                label {
                    display: block;
                    margin-bottom: 8px;
                    font-size: 16px;
                }
                input[type="text"] {
                    width: 100%;
                    padding: 10px;
                    font-size: 16px;
                    border: 1px solid #ccc;
                    border-radius: 4px;
                    margin-bottom: 20px;
                }
                button {
                    padding: 10px 20px;
                    font-size: 16px;
                    background-color: #4CAF50;
                    color: white;
                    border: none;
                    border-radius: 4px;
                    cursor: pointer;
                }
                button:hover {
                    background-color: #45a049;
                }
                .message {
                    margin-top: 20px;
                    font-size: 18px;
                    color: #333;
                    font-weight: bold;
                }
            </style>
        </head>
        <body>
            <div class="form-container">
                <h1>Formulario para CODCONTRATO</h1>
                <form method="POST">
                    <label for="cod_contrato">CODCONTRATO:</label>
                    <input type="text" id="cod_contrato" name="cod_contrato" pattern="^[A-Z]{3}[0-9]{1}\.[0-9]{6}\.[0-9]{2}$" title="Formato válido: PSP0.001991.24" required>
                    <button type="submit">Enviar</button>
                </form>
                {% if cod_contrato_recebido %}
                    <div class="message">{{ cod_contrato_recebido }}</div>
                {% endif %}
            </div>
        </body>
        </html>
    ''', cod_contrato_recebido=cod_contrato_recebido)

# Rota pública para listar todos os contratos
@app.route('/contratos', methods=['GET'])
def listar_contratos():
    contratos = obter_contratos()
    contratos_lista = [{"id": c[0], "cod_contrato": c[1]} for c in contratos]
    return jsonify(contratos_lista)

if __name__ == '__main__':
    init_db()  # Cria o banco de dados e a tabela se não existirem
    app.run(debug=True)
