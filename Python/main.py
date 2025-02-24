# db_config.py
from sqlalchemy import engine_from_config, text
import pandas as pd
from plotly import funcao
# Definir as variáveis da conexão
servername = "spsvsql39\\metas"
dbname = "FINANCA"
driver = "ODBC+Driver+17+for+SQL+Server"
queries = {"fato_fechamento": """SELECT TOP 10 * FROM FATOFECHAMENTO"""}
# Configuração do banco de dados em um dicionário
config = {
    'sqlalchemy.url':
    f'mssql+pyodbc://@{servername}/{dbname}?trusted_connection=yes&driver={driver}'
}
 
def create_engine():
    """Usando engine_from_config para criar a engine a partir da configuração"""
    return engine_from_config(config, prefix='sqlalchemy.')
    print("Conexão realizada.")
 
def close_connection(engine):
    """Liberar os recursos e encerrar a conexão"""
    if engine:
        engine.dispose()
        print("Conexão encerrada com sucesso.")



def main():
    engine = create_engine()
    try:
        with engine.connect() as connection:
            df = pd.read_sql_query(sql=text(queries["fato_fechamento"]),con=connection)
            print(df)
            funcao(df)
    except Exception as e: #❌ printa erro
        print(f"Erro durante a execução: {e}")

if __name__ == "__main__":
    main()