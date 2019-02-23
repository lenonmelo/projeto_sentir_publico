import 'package:flutter/material.dart';
import 'package:projeto_sentir/Cores.dart';
import 'package:projeto_sentir/domain/login_service.dart';
import 'package:projeto_sentir/pages/cadastro_page.dart';
import 'package:projeto_sentir/pages/escolha_perfil_page.dart';
import 'package:projeto_sentir/pages/paciente_page.dart';
import 'package:projeto_sentir/pages/psicologa_page.dart';
import 'package:projeto_sentir/utils/alerts.dart';
import 'package:projeto_sentir/utils/nav.dart';


class LoginPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //Paciente
//  final _tLogin = TextEditingController(text: "lenonmelo@gmail.com");
  //Psicologa
  final _tLogin = TextEditingController(text: "teste3@teste.com.br");
  final _tSenha = TextEditingController(text: "123456");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }

  String _validateLogin(String text) {
    if(text.isEmpty) {
      return "Informe o email";
    }
    return null;
  }

  String _validateSenha(String text) {
    if(text.isEmpty) {
      return "Informe a senha";
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
            Image.asset("assets/images/logo.png"),
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
              height: 20,
            ),
            Center(
              child: Text(
                "Senha",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                ),
              ),
            ),
            TextFormField(
              controller: _tSenha,
              validator: _validateSenha,
              obscureText: true,
              decoration: InputDecoration(
//                labelText: "Login",
//                labelStyle: TextStyle(fontSize: 30),
                  filled: true,
                  fillColor: Colors.white),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: InkWell(
                onTap: () {
                  _onClickEsqueceuSenha(context);
                },
                child: Text(
                  "Esqueceu sua senha",
                  style: TextStyle(
                      color: Colors.blue, decoration: TextDecoration.underline),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Ainda não tem acesso?"),
                InkWell(
                  onTap: () { _onClickCadastrar(context); },
                  child: Text(
                    "Cadastra-se aqui",
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 150,
              child: RaisedButton(
                color: Colors.blue,
                child: Text(
                  "Entrar",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                onPressed: () {
                  _onClickEntrar(context);
                },
              ),
            ),
            Container(
              width: 150,
              child: RaisedButton(
                color: Colors.red,
                child: Text(
                  "Entrar com Google",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                onPressed: () {
                  _onClickGoogle(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onClickEntrar(BuildContext context) async {


    if(! _formKey.currentState.validate()) {
      return;
    }

    final login = _tLogin.text;
    final senha = _tSenha.text;

//    print("Login $login, senha $senha");

    final usuario = await LoginService.login(login, senha);

    if(usuario.error == null || usuario.error.isEmpty ) {
      if (usuario.perfil == "ps")
        push(context, PsicologaPage());
      else if (usuario.perfil == "pa")
        push(context, PacientePage());
    } else{
      alert(context, "Aviso", usuario.error);
    }
        //alert(context, "teste", usuario.error);

//    print("Nome: ${usuario.nome}, perfil: ${usuario.perfil}");


  }

  void _onClickGoogle(BuildContext context) {
    print("Google");
  }

  void _onClickEsqueceuSenha(BuildContext context) {
    print("Esqueceu a Senha!");
  }

  void _onClickCadastrar(BuildContext context) {
    push(context, EscolhaPerfilPage());
  }
}