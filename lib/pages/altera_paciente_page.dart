import 'package:flutter/material.dart';
import 'package:projeto_sentir/Cores.dart';
import 'package:projeto_sentir/domain/cadastro_paciente_service.dart';
import 'package:projeto_sentir/domain/cadastro_psicologa_service.dart';
import 'package:projeto_sentir/drawer_list_psicologa.dart';

import 'package:projeto_sentir/pages/login_page.dart';
import 'package:projeto_sentir/pages/paciente_page.dart';

import 'package:projeto_sentir/utils/alerts.dart';
import 'package:projeto_sentir/utils/nav.dart';
import 'package:projeto_sentir/utils/prefs.dart';

class AlteraPacientePage extends StatelessWidget {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _tNome = TextEditingController();
  final _tSenha = TextEditingController();
  final _tSenhaRepetir = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de Psicologa"),
        centerTitle: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              _onClickSair(context);
            },
          ),
        ],
      ),
      body: _body(context),

      drawer: DrawerMenu(context),
    );
  }
  String _validateNome(String text) {
    if(text.isEmpty) {
      return "Informe o nome";
    }
    return null;
  }



  String _validateSenhaRepetir(String text) {

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
            Image.asset("assets/images/logo.png"),
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
              keyboardType: TextInputType.text,
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
              obscureText: true,
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
//                labelText: "Login",
//                labelStyle: TextStyle(fontSize: 30),
                  filled: true,
                  fillColor: Colors.white),
            ),
            SizedBox(
              height: 6,
            ),
//            Center(
//              child: Text(
//                "Foto",
//                style: TextStyle(
//                  color: Colors.black,
//                  fontSize: 20,
//                ),
//              ),
//            ),
//            TextFormField(
//              controller: _tSenhaRepetir,
//              validator: _validateSenhaRepetir,
//              obscureText: true,
//              decoration: InputDecoration(
////                labelText: "Login",
////                labelStyle: TextStyle(fontSize: 30),
//                  filled: true,
//                  fillColor: Colors.white),
//            ),
//            SizedBox(
//              height: 6,
//            ),
            Container(
              width: 150,
              child: RaisedButton(
                color: Colors.blue,
                child: Text(
                  "Cadastrar",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                onPressed: () {
                  _onClickAlterar(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onClickAlterar(BuildContext context) async {
    if(! _formKey.currentState.validate()) {
      return;
    }
    final nome = _tNome.text;
    final senha = _tSenha.text;
    final paciente = await CadastroPacienteService.alterar(nome, senha);

//    final psicologa = await CadastroPsicologaService.cadastro(nome, login, senha);
    if(paciente.sucesso != null)
      push(context,PacientePage());
    else
      alert(context, "Aviso", paciente.error);


  }

  void _onClickGoogle(BuildContext context) {
    print("Google");
  }

  void _onClickEsqueceuSenha(BuildContext context) {
    print("Esqueceu a Senha!");
  }
}

void _onClickSair(BuildContext context) {
  push(context, LoginPage());
}