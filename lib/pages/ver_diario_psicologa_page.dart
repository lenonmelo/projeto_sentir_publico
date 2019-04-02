import 'package:flutter/material.dart';
import 'package:projeto_sentir/Cores.dart';
import 'package:projeto_sentir/domain/diario.dart';
import 'package:projeto_sentir/domain/diario_service.dart';
import 'package:projeto_sentir/pages/diario_psicologa_page.dart';
import 'package:projeto_sentir/utils/alerts.dart';
import 'package:projeto_sentir/utils/nav.dart';

class VerDiarioPsicologaPage extends StatefulWidget {

  Diario diario;

  VerDiarioPsicologaPage(this.diario);
  @override
  _VerdiarioPsicologaPageState createState() => new _VerdiarioPsicologaPageState(diario);
}
class _VerdiarioPsicologaPageState extends State<VerDiarioPsicologaPage>
{
   Diario diario;
  _VerdiarioPsicologaPageState(this.diario);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _tSituacao = TextEditingController();
  final _tMesenti = TextEditingController();
  final _tOquefiz = TextEditingController();


//   String _currentCity;
   @override
   void initState() {
     super.initState();

     _tSituacao.text = this.diario.situacao;
     _tMesenti.text = this.diario.mesentindo;
     _tOquefiz.text = this.diario.oquefiz;
   }

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
                  "Data: ${diario.data}",
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
              enabled: false,
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
              enabled: false,
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
                enabled: false,
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
                  "Remover",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                onPressed: () {
                  _onClickRemover(context, diario.id.toString());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }


  void _onClickRemover(BuildContext context, String id) async {
    confirmRemocao(context, "Excluir", "Deseja excluir esse registro?", id);
  }
  confirmRemocao(BuildContext context, String title, String msg, String id) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(msg),
            actions: <Widget>[
              FlatButton(
                child: Text("Sim"),
                onPressed: () {
                  Navigator.pop(context);
                  excluirdiario(context, id);

                },
              ),
              FlatButton(
                child: Text("Não"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }
  void excluirdiario(BuildContext context, String id) async {
     try{
        final diario = await DiarioService.excluir(id);

        if(diario.error.isEmpty || diario.error == null){
//          print("retorno >> ${diario.nome_paciente}");
//          pushReplacement(context,DiarioPsicologaPage(diario.id_paciente, diario.nome_paciente));
          pop(context);
        }
//        else
//          alert(context, "Aviso", diario.error);
     } catch(error) {
       print("erro $error");
     }
  }
}

