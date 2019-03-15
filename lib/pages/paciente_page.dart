import 'package:flutter/material.dart';
import 'package:projeto_sentir/Cores.dart';
import 'package:projeto_sentir/domain/diario.dart';
import 'package:projeto_sentir/domain/diario_service.dart';
import 'package:projeto_sentir/drawer_list_paciente.dart';
import 'package:projeto_sentir/pages/cadastro_diario_page.dart';
import 'package:projeto_sentir/pages/login_page.dart';
import 'package:projeto_sentir/pages/ver_diario_page.dart';
import 'package:projeto_sentir/utils/nav.dart';

class PacientePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Diário"),
        backgroundColor: Colors.grey,
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
      body: _body2(context),
      drawer: DrawerMenu(context),
      floatingActionButton: new FloatingActionButton(
          onPressed: () {
            _cadastrodiario(context);
          } ,
          child: new Icon(Icons.add)
      ),
    );
  }


  _body2(BuildContext context) {
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
    final diario = DiarioService.getDiarios();
    final star_colosrs = Colors.blue;
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
                  diario.situacao,
                ),
                trailing: Text(
                    diario.mesentindo
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

  void _onClickSair(BuildContext context) {
    push(context,LoginPage());
  }


  void _cadastrodiario(BuildContext context) {
    push(context, CadastroDiarioPage());
  }

  _mostrarRegistro(BuildContext context, Diario diario) {
    push(context, VerDiarioPage(diario));
  }
}
