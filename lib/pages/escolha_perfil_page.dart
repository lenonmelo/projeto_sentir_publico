import 'package:flutter/material.dart';
import 'package:projeto_sentir/Cores.dart';
import 'package:projeto_sentir/pages/cadastro_page.dart';
import 'package:projeto_sentir/pages/cadastro_psicologa_page.dart';
import 'package:projeto_sentir/utils/nav.dart';

class EscolhaPerfilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Escolha o perfil"),
        centerTitle: false,
      ),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      color: Cores.azul,
      child: ListView(
        children: <Widget>[
          Image.asset(
            "assets/images/logo.png",
            width: 100,
            height: 100,
          ),
          SizedBox(
            height: 50,
          ),
          Center(
            child: Text(
              "Você é",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                color: Colors.blue,
                child: Text(
                  "Psicólogo(a)",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                onPressed: () {
                  _onClickPsicologo(context);
                },
              ),
              RaisedButton(
                color: Colors.blue,
                child: Text(
                  "Paciente",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                onPressed: () {
                  _onClickPaciente(context);
                },
              )
            ],
          )
        ],
      ),
    );
  }

  void _onClickPsicologo(BuildContext context) {
//    print("Psicologo!");
    push(context, CadastroPsicologaPage());
//    push(context,CadastroPage());
  }

  void _onClickPaciente(BuildContext context) {
    print("Paciente");

    push(context,CadastroPage());
  }
}
