from flask import Flask, redirect, url_for, session

from authlib.integrations.flask_client import OAuth
 
app = Flask(__name__)

app.secret_key = "chave_super_secreta"
 
# Configuração OAuth2 com Microsoft

oauth = OAuth(app)

oauth.register(

    name="microsoft",

    client_id="SEU_CLIENT_ID",

    client_secret="SEU_CLIENT_SECRET",

    authorize_url="https://login.microsoftonline.com/SEU_TENANT_ID/oauth2/v2.0/authorize",

    authorize_params={"scope": "openid email profile"},

    access_token_url="https://login.microsoftonline.com/SEU_TENANT_ID/oauth2/v2.0/token",

    client_kwargs={"scope": "openid email profile"},

)
 
@app.route("/login")

def login():

    return oauth.microsoft.authorize_redirect(url_for("auth_callback", _external=True))
 
@app.route("/auth/callback")

def auth_callback():

    token = oauth.microsoft.authorize_access_token()

    user_info = oauth.microsoft.parse_id_token(token)

    session["user"] = user_info

    return redirect(url_for("dashboard"))
 
@app.route("/dashboard")

def dashboard():

    if "user" in session:

        return f"Bem-vindo {session['user']['name']}! <a href='/logout'>Sair</a>"

    return redirect(url_for("login"))
 
@app.route("/logout")

def logout():

    session.pop("user", None)

    return redirect(url_for("login"))
 
if __name__ == "__main__":

    app.run(debug=True)

 