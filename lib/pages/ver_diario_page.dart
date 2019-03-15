import 'package:flutter/material.dart';
import 'package:projeto_sentir/Cores.dart';
import 'package:projeto_sentir/domain/cadastro_paciente_service.dart';
import 'package:projeto_sentir/domain/cadastro_psicologa_service.dart';
import 'package:projeto_sentir/domain/diario.dart';
import 'package:projeto_sentir/domain/diario_service.dart';
import 'package:projeto_sentir/domain/login_service.dart';
import 'package:projeto_sentir/domain/mesentindo.dart';
import 'package:projeto_sentir/domain/mesentindo_service.dart';
import 'package:projeto_sentir/pages/escolha_perfil_page.dart';
import 'package:projeto_sentir/pages/paciente_page.dart';
import 'package:projeto_sentir/pages/psicologa_page.dart';
import 'package:projeto_sentir/utils/alerts.dart';
import 'package:projeto_sentir/utils/nav.dart';
import 'package:projeto_sentir/utils/prefs.dart';
import 'package:intl/intl.dart';

class VerDiarioPage extends StatefulWidget {

  Diario diario;

  VerDiarioPage(this.diario);
  @override
  _VerdiarioPageState createState() => new _VerdiarioPageState(diario);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}
class _VerdiarioPageState extends State<VerDiarioPage>
{
   Diario diario;
  _VerdiarioPageState(this.diario);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _tSituacao = TextEditingController();
  final _tMesenti = TextEditingController();
  final _tOquefiz = TextEditingController();


   String _currentCity;
   @override
   void initState() {
     Future<Diario> d = DiarioService.getDiario(this.diario.id.toString());
         print("D >> $d");
     super.initState();
   }

   @override
  Widget build(BuildContext context) {
    _tSituacao.text = this.diario.situacao;
    _tMesenti.text = this.diario.mesentindo;
    _tOquefiz.text = this.diario.oquefiz;
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
//    print("situacao >>>>> ${this.diario.situacao}");
//    var diarioService = new DiarioService();
//    final diario = await DiarioService.getDiario(this.diario.id);
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
                  "Alterar",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                onPressed: () {
                  _onClickAlterar(context, diario.id.toString());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }


  void _onClickAlterar(BuildContext context, String id) async {

    if(! _formKey.currentState.validate()) {
      return;
    }
    final situacao = _tSituacao.text;
    final mesenti = _tMesenti.text;
    final oquefiz = _tOquefiz.text;
//    final codigoPsicologa = _tCodigoPsicologa.text;
    print("id >> $id");
    final diario = await DiarioService.alterar(id, situacao, mesenti, oquefiz);
    if(diario.error.isEmpty || diario.error == null)
      push(context,PacientePage());
    else
      alert(context, "Aviso", diario.error);

  }

}