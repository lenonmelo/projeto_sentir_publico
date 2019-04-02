import 'package:flutter/material.dart';
import 'package:projeto_sentir/Cores.dart';
import 'package:projeto_sentir/domain/diario.dart';
import 'package:projeto_sentir/domain/diario_service.dart';
import 'package:projeto_sentir/domain/login_service.dart';
import 'package:projeto_sentir/pages/cadastro_diario_page.dart';
import 'package:projeto_sentir/pages/login_page.dart';
import 'package:projeto_sentir/pages/ver_diario_psicologa_page.dart';
import 'package:projeto_sentir/utils/nav.dart';

class DiarioPsicologaPage extends StatefulWidget {

  int id_paciente;
  String nome;

  DiarioPsicologaPage(this.id_paciente, this.nome);
  @override
  _DiarioPsicologaState createState() => new _DiarioPsicologaState(id_paciente, nome);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}
class _DiarioPsicologaState extends State<DiarioPsicologaPage>
{
  int id_paciente;
  String nome;
  _DiarioPsicologaState(this.id_paciente, this.nome);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
//   String _currentCity;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.nome.toString()),
        centerTitle: false,
      ),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      color: Cores.azul,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Image.asset(
            "assets/images/diario.png",
            width: 50,
            height: 50,
          ),
          Expanded(
            child: _listView(),
          )
        ],
      ),
    );
  }

  _listView() {

    final diario = DiarioService.getDiariosPaciente(this.id_paciente);
    return FutureBuilder(
      future: diario,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final lista = snapshot.data;

          return ListView.builder(
            itemCount: lista.length,
            itemBuilder: (context, idx) {
              final Diario diario = lista[idx];

              return ListTile(
                title: Text(
                  diario.data,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                    (diario.situacao.length > 40 ) ? diario.situacao.substring(0, 40).toString() : diario.situacao
                ),
                trailing: Text(
                    (diario.mesentindo.length > 15 ) ? diario.mesentindo.substring(0, 15).toString() : diario.mesentindo
                ),

                onTap: (){
                  _mostrarRegistro(context, diario);
                },
              );
            },
          );
        } else {
          return SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(),
          );
        }
      },
    );


  }

  _mostrarRegistro(BuildContext context, Diario diario) {
      push(context, VerDiarioPsicologaPage(diario));
  }
}