import 'package:flutter/material.dart';
import 'package:projeto_sentir/Cores.dart';
import 'package:projeto_sentir/domain/login_service.dart';
import 'package:projeto_sentir/domain/paciente_service.dart';
import 'package:projeto_sentir/domain/usuario.dart';
import 'package:projeto_sentir/drawer_list_psicologa.dart';

import 'package:projeto_sentir/pages/login_page.dart';
import 'package:projeto_sentir/pages/paciente_page.dart';

import 'package:projeto_sentir/utils/alerts.dart';
import 'package:projeto_sentir/utils/nav.dart';

class AlteraPacientePage extends StatefulWidget {

  @override
  _AlteraPacientePageState createState() => _AlteraPacientePageState();
}

class _AlteraPacientePageState extends State<AlteraPacientePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _tNome = TextEditingController();
  final _tSenha = TextEditingController();
  final _tSenhaRepetir = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future<Usuario> future = Usuario.get();
    future.then((Usuario u) {
      _tNome.text = u.nome;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de Paciente"),
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
    try{
      final paciente = await PacienteService.alterar(nome, senha);
      if(paciente.sucesso != null) {
        pop(context);
        pushReplacement(context, PacientePage());
      }else
        alert(context, "Aviso", paciente.error);
    } catch(error) {
      alert(context, "Erro","Ocorreu um erro ao alterar o paciente");
    }
  }
}

Future _onClickSair(BuildContext context) async {
  final usuario = await LoginService.logout();
  push(context, LoginPage());
}