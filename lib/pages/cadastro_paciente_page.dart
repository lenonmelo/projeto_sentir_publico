import 'package:flutter/material.dart';
import 'package:projeto_sentir/Cores.dart';
import 'package:projeto_sentir/domain/paciente_service.dart';
import 'package:projeto_sentir/pages/paciente_page.dart';
import 'package:projeto_sentir/utils/alerts.dart';
import 'package:projeto_sentir/utils/nav.dart';

class CadastroPacientePage extends StatelessWidget {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _tNome = TextEditingController();
  final _tLogin = TextEditingController();
  final _tSenha = TextEditingController();
  final _tSenhaRepetir = TextEditingController();
  final _tCodigoPsicologa = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de Paciente"),
        centerTitle: false,
      ),
      body: _body(context),
    );
  }
  String _validateNome(String text) {
    if(text.isEmpty) {
      return "Informe o nome";
    }
    return null;
  }
  String _validateLogin(String text) {
    if(text.isEmpty) {
      return "Informe o email";
    }
    return null;
  }

  String _validateCodigoPsicologa(String text) {
    if(text.isEmpty) {
      return "Informe o código da psicóloga(o)";
    }
    return null;
  }
  String _validateSenha(String text) {
    if(text.isEmpty) {
      return "Informe a senha";
    }
    return null;
  }
  String _validateSenhaRepetir(String text) {

    if(text.isEmpty) {
        return "Repita a senha${_tSenhaRepetir.text}";
    }
    if(_tSenha.text != text){
      return "Senhas não conferêm";
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
                "Nome",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
            TextFormField(
              controller: _tNome,
              validator: _validateNome,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white),
            ),
            SizedBox(
              height: 6,
            ),
            Center(
              child: Text(
                "E-Mail",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
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
              height: 6,
            ),
            Center(
              child: Text(
                "Código da psicóloga(o)",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
            TextFormField(
              controller: _tCodigoPsicologa,
              validator: _validateCodigoPsicologa,
              decoration: InputDecoration(
//                labelText: "Login",
//                labelStyle: TextStyle(fontSize: 30),
                  filled: true,
                  fillColor: Colors.white),
            ),
            SizedBox(
              height: 6,
            ),
            Center(
              child: Text(
                "Senha",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
            TextFormField(
              controller: _tSenha,
              validator: _validateSenha,
              obscureText: true,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white),
            ),
            SizedBox(
              height: 6,
            ),
            Center(
              child: Text(
                "Repita a senha",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
            TextFormField(
              controller: _tSenhaRepetir,
              validator: _validateSenhaRepetir,
              obscureText: true,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white),
            ),
            SizedBox(
              height: 6,
            ),


            Container(
              width: 150,
              child: RaisedButton(
                color: Colors.blue,
                child: Text(
                  "Cadastrar",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                onPressed: () {
                  _onClickCadastrar(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onClickCadastrar(BuildContext context) async {

    if(! _formKey.currentState.validate()) {
      return;
    }
    final nome = _tNome.text;
    final login = _tLogin.text;
    final senha = _tSenha.text;
    final codigoPsicologa = _tCodigoPsicologa.text;
    try {
      final paciente = await PacienteService.cadastro(nome, login, senha, codigoPsicologa);
      if(paciente.error.isEmpty || paciente.error == null)
        pushReplacement(context,PacientePage());
      else
        alert(context, "Aviso", paciente.error);
    } catch(error) {
      alert(context, "Erro","Ocorreu um erro ao cadastrar paciente");
    }
  }
}