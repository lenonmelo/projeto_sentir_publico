import 'package:flutter/material.dart';
import 'package:projeto_sentir/Cores.dart';
import 'package:projeto_sentir/domain/diario.dart';
import 'package:projeto_sentir/domain/diario_service.dart';
import 'package:projeto_sentir/pages/paciente_page.dart';
import 'package:projeto_sentir/utils/alerts.dart';
import 'package:projeto_sentir/utils/nav.dart';
import 'package:intl/intl.dart';

class CadastroDiarioPage extends StatelessWidget {

  Diario diario;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _tSituacao = TextEditingController();
  final _tMesenti = TextEditingController();
  final _tOquefiz = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Realizar registro"),
        centerTitle: false,
      ),
      body: _body(context),
    );
  }
  
  String _validateSituacao(String text) {
    if(text.isEmpty) {
      return "Informe a situaçao";
    }
    return null;
  }
  String _validateMesenti(String text) {
    if(text.isEmpty) {
      return "Informe o que sentiu";
    }
    return null;
  }

  String _validateOquefiz(String text) {
    if(text.isEmpty) {
      return "Preencher este campo";
    }
    return null;
  }

  _body(BuildContext context) {
    var now = new DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy').format(now);

    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(10),

        color: Cores.azul,
        child: ListView(
          children: <Widget>[
            Image.asset("assets/images/logo_500px.png",
                alignment: Alignment(0, -1),
              height: 120,
            ),

            Center(
              child: Text(
                  "Data: ${formattedDate.toString()}",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                "Situação:",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
            TextFormField(
              controller: _tSituacao,
              validator: _validateSituacao,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white
              ),
              maxLines: 5,
            ),
            SizedBox(
              height: 6,
            ),
            Center(
              child: Text(
                "Como me senti:",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
//            _dropDownMenuItems(),
            TextFormField(
              controller: _tMesenti,
              validator: _validateMesenti,
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
                "O que eu fiz:",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
            TextFormField(
              controller: _tOquefiz,
              validator: _validateOquefiz,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white),
              maxLines: 5
            ),

            SizedBox(
              height: 6,
            ),
            Container(
              width: 150,
              child: RaisedButton(
                color: Colors.blue,
                child: Text(
                  "Registrar",
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
    final situacao = _tSituacao.text;
    final mesenti = _tMesenti.text;
    final oquefiz = _tOquefiz.text;
    try{
      final diario = await DiarioService.cadastro(situacao, mesenti, oquefiz);
      if(diario.error.isEmpty || diario.error == null) {
        pop(context);
        pushReplacement(context, PacientePage());
      }else
        alert(context, "Aviso", diario.error);
    } catch(error) {
      alert(context, "Erro","Ocorreu um erro ao realizar registro no diario");
    }
  }
}