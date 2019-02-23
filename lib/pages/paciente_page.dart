import 'package:flutter/material.dart';
import 'package:projeto_sentir/Cores.dart';
import 'package:projeto_sentir/domain/diario.dart';
import 'package:projeto_sentir/domain/diario_service.dart';
import 'package:projeto_sentir/drawer_list_paciente.dart';
import 'package:projeto_sentir/pages/login_page.dart';
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
                  diario.mesentindo,
                ),
                leading: Icon(
                  Icons.star,
                  color: star_colosrs,
                  size: 60,
                ),
                trailing: Text(
                    diario.situacao
                ),


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

//  abrirDiario(Paciente paciente) {
//    print(paciente.id);
//  }
}
