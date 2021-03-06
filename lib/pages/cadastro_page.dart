import 'package:flutter/material.dart';
import 'package:projeto_sentir/Cores.dart';
import 'package:projeto_sentir/domain/paciente_service.dart';
import 'package:projeto_sentir/drawer_list.dart';
import 'package:projeto_sentir/utils/nav.dart';

class CadastroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro"),
        backgroundColor: Colors.blue,
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
    final pacientes = PacienteService.getPacientes();

    return FutureBuilder(
      future: pacientes,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final lista = snapshot.data;

          return ListView.builder(
            itemCount: lista.length,
            itemBuilder: (context, idx) {
              return ListTile(
                leading: Icon(
                  Icons.perm_identity,
                ),
                trailing: Icon(
                  Icons.star,
                  color: Colors.yellow,
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

//    return ListView.builder(
//      itemCount: pacientes.length,
//      itemBuilder: (context, idx) {
//        final paciente = pacientes[idx];
//
//        return ListTile(
//          title: Text(
//            paciente.nome,
//            style: TextStyle(
//              color: Colors.black,
//            ),
//          ),
//          subtitle: Text(
//            paciente.desc,
//          ),
//          leading: Icon(
//            Icons.perm_identity,
//          ),
//          trailing: Icon(
//            Icons.star,
//            color: Colors.yellow,
//          ),
//        );
//      },
//    );
  }

  void _onClickSair(BuildContext context) {
    pop(context);
  }
}
