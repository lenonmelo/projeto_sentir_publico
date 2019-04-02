import 'package:flutter/material.dart';
import 'package:projeto_sentir/Cores.dart';
import 'package:projeto_sentir/domain/login_service.dart';
import 'package:projeto_sentir/pages/login_page.dart';
import 'package:projeto_sentir/utils/alerts.dart';
import 'package:projeto_sentir/utils/nav.dart';

class EsqueciSenhaPage extends StatelessWidget {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _tLogin = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recuperar senha"),
        centerTitle: false,
      ),
      body: _body(context),
    );
  }

  String _validateLogin(String text) {
    if(text.isEmpty) {
      return "Informe o email";
    }
    return null;
  }

  _body(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(10),
        color: Cores.azul,
        child: ListView(
          children: <Widget>[
            Image.asset("assets/images/logo_300px.png"),

            Center(
              child: Text(
                "Para recuperar sua senha, ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20
                ),
              ),
            ),
            Center(
              child: Text(
                "digita seu e-mail ultilzado como",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20
                ),
              ),
            ),
            Center(
              child: Text(
                "login que iremos enviar uma nova",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20
                ),
              ),
            ),
            Center(
              child: Text(
                "senha para este e-mail",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                "E-Mail",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                ),
              ),
            ),

            TextFormField(
              controller: _tLogin,
              validator: _validateLogin,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
//                labelText: "Login",
//                labelStyle: TextStyle(fontSize: 30),
                  filled: true,
                  fillColor: Colors.white),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: 150,
              child: RaisedButton(
                color: Colors.blue,
                child: Text(
                  "Recuperar senha",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                onPressed: () {
                  _onClickRecuperar(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onClickRecuperar(BuildContext context) async {

    if(! _formKey.currentState.validate()) {
      return;
    }
    final email = _tLogin.text;
    try {
      final usuario = await LoginService.esquecisenha(email);

      if(usuario.error == null || usuario.error.isEmpty ) {
          pushReplacement(context, LoginPage());
      } else{
        alert(context, "Aviso", usuario.error);
      }
    } catch(error) {
      alert(context, "Erro","Ocorreu um erro ao enviaro o email");
    }
  }

}